var leaderboardLogging = false;
window.leaderboardLogging = leaderboardLogging;

function generateScore(quoid) {
    // Get the respective JSONs
    var quoInput = _.where(inputJSON, {quoid: quoid})[0];
    var quoConfig = _.where(configuration, {quoid: quoid})[0];

    // Build the   Input Mapping
    var inputMap = _.map(quoInput.scores, function (thisInput) {
        console.log(thisInput.score)
        return {
            userid: thisInput.userid,
            value: (thisInput.score == "") ? "1" : _.where(quoConfig.mapping, {score: thisInput.score})[0].value
        }
    });

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
    var updating = _.contains(leaderboardJSON.schema, quoid);

    if (updating) {
        _.each(leaderboardJSON.data, function (elm) {
            elm.quoScores.splice(leaderboardJSON.schema.indexOf(quoid), 1);
        });
        leaderboardJSON.schema.splice(leaderboardJSON.schema.indexOf(quoid), 1);
    }

    leaderboardJSON.schema.push(quoid);
    _.each(inputMap, function (elm, index) {
        var userQuoScore = 0;
        _.each(quoConfig.payoff, function (thisPayoff) {
            if (_.where(evaluatedCriteria, {name: thisPayoff.criteria})[0].status) {
                if (!isNaN(thisPayoff.value)) {
                    if (quoMap[index][parseInt(thisPayoff.inputvar)] != "") {
                        userQuoScore += parseInt(thisPayoff.value) * parseInt(thisPayoff.multiplier);
                    }
                } else {
                    if (thisPayoff.value == "asIs") {
                        userQuoScore += parseInt(quoMap[index][parseInt(thisPayoff.inputvar)]) * parseInt(thisPayoff.multiplier)
                    }
                }

            }
        });
        console.log("UserId " + elm.userid)
        console.log(leaderboardJSON.data)
        var thisRecord = _.where(leaderboardJSON.data, {userid: elm.userid})[0];
        thisRecord.quoScores.push(userQuoScore);
        thisRecord.totalScore = _.reduce(thisRecord.quoScores, function (sum, elm) {
            return sum + parseInt(elm)
        }, 0).toString();
    });

    // Game Master Logic

    if (gameMaster) {
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
        var gmRecord = _.where(leaderboardJSON.data, {userid: "gameMaster"})[0];
        gmRecord.quoScores.push(gmQuoScore);
        gmRecord.totalScore = _.reduce(gmRecord.quoScores, function (sum, elm) {
            return sum + parseInt(elm)
        }, 0).toString();
    }

    leaderboardLogging =true;
    if (leaderboardLogging) {
        console.log(_.map(leaderboardJSON.data, function (elm) {
            return elm.totalScore
        }));
    }
    return _.map(leaderboardJSON.data, function (elm) {
        return elm.totalScore
    })

}
window.generateScore = generateScore;

// TODO: Testing Display. Remove when integrating

function logToScreen() {
    console.log = function (message) {
        $('#log').append('<p>' + JSON.stringify(message, null, 4) + '</p>');
    };
    console.error = console.debug = console.info = console.log
}
window.logToScreen = logToScreen;
