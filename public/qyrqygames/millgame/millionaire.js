
var base;
var messagebox;
var qholder;
var ladder;
var lifelinepanel;
var lifelines;

var player;

var pollSelected;
var halfSelected;
var changeSelected;
var flag;
var pointsEarned;
var answered;

$(function () {
    window.ondragstart = function() {return false}
    initVariables();
});

function initVariables() {
    $(".environment").remove();
    base = new Environment("base");
    messagebox = new Environment("messagebox");
    qholder = new Environment("qholder")
    ladder = new Environment("ladder");
    lifelinepanel = new Environment("lifelinepanel");
    lifelines = new Environment("lifelines");

    player = new Entity("player");

    initTheme();
}

function initTheme() {
    loadConfig(base);
    $("#help").find('img').attr('src', getImg("kbc-button-know-more"));
    loadConfig(qholder);
    initQuiz();
    $("#knowmore").find('img').attr('src', getImg("kbc-button-know-more"));
    loadConfig(ladder);
    loadConfig(player);

    loadConfig(lifelinepanel);
    loadConfig(lifelines);

    loadConfig(messagebox);

    runGlobalObservers();


//    player.setState('1');
    console.log(player);
    console.log(player.getState());
    player.location(ladder.ladder1);
    var lives = new Currency("lives");
    player.createWallet(lives, 0, 1, 1);
    initGame();
}

function runGlobalObservers() {
    $("#lifeline1img").mouseover(function() {
        lifelines.text.setState('lifeline1');
    });

    $("#lifeline2img").mouseover(function() {
        lifelines.text.setState('lifeline2');
    });

    $("#lifeline3img").mouseover(function() {
        lifelines.text.setState('lifeline3');
    });

    $("#lifelines .location").mouseout(function() {
        lifelines.text.setState('default');
    });

    $("#help").unbind('click').on('click', function(e) {
        initHowto(config.howtoData);
    });

}

function initGame() {
    pollSelected = false;
    halfSelected = false;
    changeSelected = false;
    flag = 1;
    pointsEarned = 0;
    answered = false;
    gameOn = true;
    quizShuffle();
    showStartPage();

}

function quizShuffle() {
    for(var i in Question.all)  {
        Question.all[i].options = shuffle(Question.all[i].options);
    }
    Question.all = shuffle(Question.all);
}

function showStartPage() {
    messagebox.setState('startpage');
    $("#messagebox").show();

    $("#startgame").mouseover(function() {
        $(this).find('img').attr('src', getImg("kbc-button-start-hover"));
    });
    $("#startgame").mouseout(function() {
        $(this).find('img').attr('src', getImg("kbc-button-start"));
    });

    $("#showinst").mouseover(function() {
        $(this).find('img').attr('src', getImg("kbc-button-instruction-hover"));
    });
    $("#showinst").mouseout(function() {
        $(this).find('img').attr('src', getImg("kbc-button-instruction"));
    });

    $("#startgame").unbind('click').on('click', function() {
        messagebox.setState('default');
        $("#messagebox").fadeOut();
        parent.setGameAttempt(parent.currentIntegratedGame,parent.currentUid);
        playGame();
    });

    $("#showinst").unbind('click').on('click', function() {
        messagebox.setState('instructions');

        showInstructions();
    });

}

function showInstructions() {
    messagebox.setState('instruction');
    $(".content").mCustomScrollbar();
    $("#messagebox").show();

    $("#startgame-inst").unbind('mouseover').on('mouseover', function() {
        $(this).find('img').attr('src', getImg("kbc-button-start-hover"));
    });
    $("#startgame-inst").unbind('mouseout').on('mouseout', function() {
        $(this).find('img').attr('src', getImg("kbc-button-start"))
    });
    $("#startgame-inst").unbind('click').on('click', function() {
        messagebox.setState('default');
        $("#messagebox").fadeOut();
        parent.setGameAttempt(parent.currentIntegratedGame,parent.currentUid);
        playGame();
    });
}

function answerHover() {
    $(".answer-block").mouseover(function() {
        if(answered == false)
            $(this).find('img').attr('src', getImg("kbc-answer-hover-back"));
    });
    $(".answer-block").mouseout(function() {
        if(answered == false)
            $(".answer-block-back").attr('src', getImg("kbc-answer-back"));
    });

    $("#knowmore").mouseover(function() {
        $("#knowmore").find('img').attr('src', getImg("kbc-button-know-more-hover"));
        $("#knowmore").css({color: "white"});
    });
    $("#knowmore").mouseout(function() {
        $("#knowmore").find('img').attr('src', getImg("kbc-button-know-more"));
        $("#knowmore").css({color: "#3d2510"});
    });

    $("#help").mouseover(function() {
        $("#help").find('img').attr('src', getImg("kbc-button-know-more-hover"));
        $("#help").css({color: "white"});
    });
    $("#help").mouseout(function() {
        $("#help").find('img').attr('src', getImg("kbc-button-know-more"));
        $("#help").css({color: "#3d2510"});
    });
}

function playGame() {
    $("#player").find('img').attr('src', getImg("kbc-ladder-current"));
    lifelinepanel.setState('default');
    $("#lifelines .location").css({'pointer-events': "auto", 'cursor': "pointer"});

    question = Question.getByWeight(flag);
    $('#quiz').fadeIn(function () {
        Question.showQuizPanel(quiz, question);
        answered = false;
        $(".answer-block-back").attr('src', getImg("kbc-answer-back"));
        parent.setQuestionAttempt(question.id);
        answerHover();
    });
    $(question).unbind('answered').on('answered', function (e, data) {
        if(answered == false) {
            answered = true;
            flag++;
            if(player.location().name == "ladder10")
            gameOn = false;
            if (data.correct == "true") {
                parent.markQuestionAttemptCorrect();
                $(data.$this).find('img').attr('src', getImg("kbc-answer-correct-back"));

                pointsEarned += parseInt(data.points);
                setTimeout(function() {
                    player.location(ladder.nextLocation(player.location()));
                    ladder[ladder.prevLocation(player.location()).name].setState('complete');
                    var playerLocation = parseInt(player.location().name.split('ladder')[1]);
                    if (gameOn)
                        playGame();
                    else {
                        endGame("You Win!");
                    }

                }, 500)


            } else {
                setTimeout(function() {
                    player.lives.is(-1);
                }, 500);

            }
        }
    });

    $(player.lives).unbind('min').on('min', function () {
        endGame("You Lose!");
    });


    //---------------lifeline function----------------------


    $("#lifeline1img").unbind('click').on('click', function () {
        if(pollSelected == false) {
            lifelinepanel.setState('lifeline1');
            $("#close").hide();

            $("#ok").unbind('click').on('click', function() {
                pollSelected = true;
                $("#poll-text").hide();
                $("#poll-chart").show();
                $(".button").hide();
                $("#close").show();
                lifelines.lifeline1img.setState('complete');
                $("#lifelines .location").css({'pointer-events': "none", 'cursor': "default"});
                usePoll();
            });

            $("#cancel").unbind('click').on('click', function() {
                lifelinepanel.setState('default');
            });

            $("#close").unbind('click').on('click', function() {
                lifelinepanel.setState('default');
                $("#lifelines .location").css({'pointer-events': "auto", 'cursor': "pointer"});
            });
        }
    });

    $("#lifeline2img").unbind('click').on('click', function () {
        if(halfSelected == false) {
            lifelinepanel.setState('lifeline2');

            $("#ok").unbind('click').on('click', function() {
                halfSelected = true;
                useHalf();
                lifelines.lifeline2img.setState('complete');
//                $("#lifelines .location").css({'pointer-events': "auto", 'cursor': "pointer"});
                lifelinepanel.setState('default');
            });

            $("#cancel").unbind('click').on('click', function() {
                lifelinepanel.setState('default');
            });
        }
    });

    $("#lifeline3img").unbind('click').on('click', function () {
        if(changeSelected == false) {
            lifelinepanel.setState('lifeline3');

            $("#ok").unbind('click').on('click', function() {
                changeSelected = true;
                flag++;
                playGame();
                lifelines.lifeline3img.setState('complete');
                lifelinepanel.setState('default');
            });

            $("#cancel").unbind('click').on('click', function() {
                lifelinepanel.setState('default');
            });
        }
    });
}

function incFlag() {
    flag++;
    if(flag == Question.all.length){
        flag = 0;
        quizShuffle();
    }

}

function usePoll() {
    var sum = 0;
    var ctx = $("#poll-chart").get(0).getContext("2d");
    var data = {
        labels: ["A", "B", "C", "D"],
        datasets: [
            {
                label: "Poll",
                fillColor: "rgba(61, 37, 16,0.5)",
                strokeColor: "rgba(61, 37, 16,0.8)",
                highlightFill: "rgba(61, 37, 16,0.75)",
                highlightStroke: "rgba(61, 37, 16,1)",
                data: []
            }
        ]
    };

    for(var i = 0; i < question.options.length; i++) {
        if(i != question.options.length-1) {

            if(question.options[i].correct == "true") {
                var random = randBetween(30, 100);
                if((sum+random) > 100)
                    random -= ((sum+random)-100);
                sum += random;
                data.datasets[0].data.push(random);
//                data.labels[i] = data.labels[i]+" - "+random+"%";
            } else {
                var random = randBetween(0, 25);
                if((sum+random) > 100)
                    random -= ((sum+random)-100);
                sum += random;
                data.datasets[0].data.push(random);
//                data.labels[i] = data.labels[i]+" - "+random+"%";
            }
        } else {
            random = (100-sum);
            data.datasets[0].data.push(random);
//            data.labels[i] = data.labels[i]+" - "+random+"%";
        }
    }

    var myBarChart = new Chart(ctx).Bar(data, {

    });
}

function useHalf() {
    while(true) {
        var random1 = randBetween(0,100)%4;
        var random2 = randBetween(0,100)%4;
        while(random1 == random2) {
            random2 = randBetween(0,100)%4;
        }

        if((question.options[random1].correct == "false") && (question.options[random2].correct == "false")) {
            $(".answer-block").eq(random1).hide();
            $(".answer-block").eq(random2).hide();
            break;
        }
    }
}

function endGame(message) {
    messagebox.setState('endgame');
    $("#messagebox").fadeIn();
    $("#endmessage").html('<span>'+message+'</span>');

    $("#playagain").unbind('mouseover').on('mouseover', function() {
        $(this).find('img').attr('src', getImg("kbc-button-play-again-hover"));
    });
    $("#playagain").unbind('mouseout').on('mouseout', function() {
        $(this).find('img').attr('src', getImg("kbc-button-play-again"))
    });
    $("#playagain").unbind('click').on('click', function() {
        messagebox.setState('default');
        $("#messagebox").hide();
        console.log(player.location());
        initVariables();
    });
}
