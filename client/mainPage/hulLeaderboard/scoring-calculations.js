var leaderboardLogging = false;

function getGameMaster(){
    var gameMaster = false;
    if(platforms.findOne().gameName !== "Kurukshetra"){
        gameMaster = false;
    }else{
        gameMaster = true;   
    }
    return gameMaster;
}

function getAdditiveScore(){
    var additiveScores = false;
    if(platforms.findOne().gameName !== "Kurukshetra"){
        additiveScores = false;
    }else{
        additiveScores = true;  
    }
    return additiveScores;
}

// This is true if the calculations are discrete like in the case of Kurukshetra
// var additiveScores = false;

function generateScore(quoid) {

    _.each(appConfiguration, function (configuration) {
        var quoConfig = _.where(configuration.quoConfig, {quoid: quoid})[0];
        var inputMap = mapInput(configuration, quoid);
        var quoMap = _.pluck(inputMap, "value");

        // Evaluate the criteria

        var evaluatedCriteria = [];
        var unionArray, unionTotal, criteriaStatus;
        _.each(_.sortBy(quoConfig.criteria, "sequence"), function (thisCriteria) {

            switch (thisCriteria.logic) {
                case "unionAnd":
                    unionArray = _.uniq(_.flatten(_.map(thisCriteria.inputvars, function (thisInputvar) {
                        return _.map(quoMap, function (thisArrElm) {
                            return thisArrElm[thisInputvar]
                        });
                    })));
                    evaluatedCriteria.push({
                        name: thisCriteria.name,
                        status: _.intersection(unionArray, thisCriteria.args).length == thisCriteria.args.length
                    });
                    break;
                case "unionOr":
                    unionArray = _.uniq(_.flatten(_.map(thisCriteria.inputvars, function (thisInputvar) {
                        return _.map(quoMap, function (thisArrElm) {
                            return thisArrElm[thisInputvar]
                        });
                    })));
                    evaluatedCriteria.push({
                        name: thisCriteria.name,
                        status: _.intersection(unionArray, thisCriteria.args).length > 0
                    });
                    break;
                case "eachAnd":
                    criteriaStatus = true;
                    _.each(quoMap, function (thisRecord) {
                        if (_.intersection(thisRecord, thisCriteria.args).length < thisCriteria.args.length) {
                            criteriaStatus = false;
                        }
                    });
                    evaluatedCriteria.push({
                        name: thisCriteria.name,
                        status: criteriaStatus
                    });
                    break;
                case "eachOr":
                    criteriaStatus = true;
                    _.each(quoMap, function (thisRecord) {
                        if (_.intersection(thisRecord, thisCriteria.args).length == 0) {
                            criteriaStatus = false;
                        }
                    });
                    evaluatedCriteria.push({
                        name: thisCriteria.name,
                        status: criteriaStatus
                    });
                    break;
                case "minTotal":
                    unionTotal = _.flatten(_.map(thisCriteria.inputvars, function (thisInputvar) {
                        return _.map(quoMap, function (thisArrElm) {
                            return parseInt(thisArrElm[thisInputvar])
                        });
                    }));
                    evaluatedCriteria.push({
                        name: thisCriteria.name,
                        status: _.reduce(unionTotal, function (sum, el) {
                            return sum + el
                        }, 0) >= parseInt(thisCriteria.args)
                    });
                    break;
                case "maxTotal":
                    unionTotal = _.flatten(_.map(thisCriteria.inputvars, function (thisInputvar) {
                        return _.map(quoMap, function (thisArrElm) {
                            return parseInt(thisArrElm[thisInputvar])
                        });
                    }));
                    evaluatedCriteria.push({
                        name: thisCriteria.name,
                        status: _.reduce(unionTotal, function (sum, el) {
                            return sum + el
                        }, 0) <= parseInt(thisCriteria.args)
                    });
                    break;
                case "asIs":
                    evaluatedCriteria.push({
                        name: thisCriteria.name,
                        status: true
                    });
                    break;
                case "not":
                    evaluatedCriteria.push({
                        name: thisCriteria.name,
                        status: !(_.where(evaluatedCriteria, {name: thisCriteria.args})[0].status)
                    });
                    break;
                case "and":
                    criteriaStatus = true;
                    _.each(thisCriteria.args, function (andElm) {
                        criteriaStatus = _.where(evaluatedCriteria, {name: andElm})[0].status && criteriaStatus;
                    });
                    evaluatedCriteria.push({
                        name: thisCriteria.name,
                        status: criteriaStatus
                    });
                    break;
                case "or":
                    criteriaStatus = false;
                    _.each(thisCriteria.args, function (andElm) {
                        criteriaStatus = _.where(evaluatedCriteria, {name: andElm})[0].status || criteriaStatus;
                    });
                    evaluatedCriteria.push({
                        name: thisCriteria.name,
                        status: criteriaStatus
                    });
                    break;
                default:
            }
        });

        // Update the leaderboard
        // Set whether this is a new Quo or an updated Quo

        var leaderboard = _.where(leaderboardJSON, {name: configuration.leaderboard})[0];
        var updating = _.contains(leaderboard.schema, quoid);

        if (updating) {
            _.each(leaderboard.data, function (elm) {
                elm.quoScores.splice(leaderboard.schema.indexOf(quoid), 1);
            });
            leaderboard.schema.splice(leaderboard.schema.indexOf(quoid), 1);
        }

        leaderboard.schema.push(quoid);
        _.each(inputMap, function (elm, index) {
            var userQuoScore = 0;
            var thisRecord = _.where(leaderboard.data, {userid: elm.userid})[0];
            _.each(quoConfig.payoff, function (thisPayoff) {
                if (thisPayoff.criteria == "" || _.where(evaluatedCriteria, {name: thisPayoff.criteria})[0].status) {
                    if (!isNaN(thisPayoff.value)) {
                        if (quoMap[index][parseInt(thisPayoff.inputvar)] != "") {
                            userQuoScore += parseInt(thisPayoff.value) * parseInt(thisPayoff.multiplier);
                        }
                    } else {
                        switch (thisPayoff.value) {
                            case "asIs":
                                userQuoScore += parseInt(quoMap[index][parseInt(thisPayoff.inputvar)]) * parseInt(thisPayoff.multiplier);
                                break;
                            case "multCompound":
                                var multiplierIndices = thisPayoff.multiplier.split("::");
                                var multValues = [];
                                _.each(multiplierIndices, function (multElm) {
                                    var thisMultiplier = multElm.split("-");
                                    var thisInput = _.where(mapInput(configuration, thisMultiplier[0]), {userid: elm.userid})[0];
                                    multValues.push(parseFloat(thisInput.value[parseInt(thisMultiplier[1])]));
                                });
                                var totalMultiplier = _.reduce(multValues, function (prod, elm) {
                                    return prod * parseFloat(elm)
                                }, 1);
                                userQuoScore = parseFloat(thisRecord.totalScore) * totalMultiplier;
                                break;
                            case "multSimple":
                                var multiplierIndices = thisPayoff.multiplier.split("::");
                                var multValues = [];
                                _.each(multiplierIndices, function (multElm) {
                                    var thisMultiplier = multElm.split("-");
                                    var thisInput = _.where(mapInput(configuration, thisMultiplier[0]), {userid: elm.userid})[0];
                                    multValues.push(parseFloat(thisInput.value[parseInt(thisMultiplier[1])]));
                                });
                                var totalMultiplier = _.reduce(multValues, function (sum, elm) {
                                    return sum + (parseFloat(elm) - 1)
                                }, 0);
                                userQuoScore = parseFloat(thisRecord.totalScore) * (1 + totalMultiplier);
                                break;
                            case "addSimple":
                                var additionIndices = thisPayoff.multiplier.split("::");
                                var addValues = [];
                                _.each(additionIndices, function (multElm) {
                                    var thisAdditive = multElm.split("-");
                                    var thisInput = _.where(mapInput(configuration, thisAdditive[0]), {userid: elm.userid})[0];
                                    addValues.push(parseFloat(thisInput.value[parseInt(thisAdditive[1])]));
                                });
                                var totalAdditive = _.reduce(addValues, function (sum, elm) {
                                    return sum + parseFloat(elm)
                                }, 0);
                                userQuoScore = parseFloat(thisRecord.totalScore) + totalAdditive;
                                break;
                            default:

                        }

                    }

                }
            });
            thisRecord.quoScores.push(userQuoScore);
            if (getAdditiveScore()) {
                thisRecord.totalScore = _.reduce(thisRecord.quoScores, function (sum, elm) {
                    return sum + parseInt(elm)
                }, 0).toString();
            } else {
                thisRecord.totalScore = userQuoScore.toString();
            }

        });

        // Game Master Logic

        if (getGameMaster()) {
            var gmQuoScore = 0;
            _.each(quoConfig.gameMaster, function (thisPayoff) {
                if (_.where(evaluatedCriteria, {name: thisPayoff.criteria})[0].status) {
                    if (!isNaN(thisPayoff.value)) {
                        gmQuoScore += parseInt(thisPayoff.value) * parseInt(thisPayoff.multiplier);
                    } else {
                        if (thisPayoff.value == "asIs") {
                            gmQuoScore += parseInt(quoMap[index][parseInt(thisPayoff.inputvar)]) * parseInt(thisPayoff.multiplier)
                        }
                    }

                }
            });
            var gmRecord = _.where(leaderboard.data, {userid: "gameMaster"})[0];
            gmRecord.quoScores.push(gmQuoScore);
            gmRecord.totalScore = _.reduce(gmRecord.quoScores, function (sum, elm) {
                return sum + parseInt(elm)
            }, 0).toString();
        }

        if (leaderboardLogging) {
            console.log("Leaderboard " + leaderboard.name + ": " + _.map(leaderboard.data, function (elm) {
                return  elm.totalScore
            }));
        }

    });
}
window.generateScore = generateScore;

function mapInput(configuration, quoid) {
    var quoConfig = _.where(configuration.quoConfig, {quoid: quoid})[0];
    var quoInput = _.where(inputJSON, {quoid: quoid})[0];
    return _.map(quoInput.scores, function (thisInput) {
        return {
            userid: thisInput.userid,
            value: (thisInput.score == "") ? "1" : quoConfig.mapping === null ? "1" : _.where(quoConfig.mapping, {score: thisInput.score}).length > 0 ? _.where(quoConfig.mapping, {score: thisInput.score})[0].value : "1"
        }
    });
}


// TODO: Testing Display. Remove when integrating

function logToScreen() {
    console.log = function (message) {
        $('#log').append('<p>' + JSON.stringify(message, null, 4) + '</p>');
    };
    console.error = console.debug = console.info = console.log
}
