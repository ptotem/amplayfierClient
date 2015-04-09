
var base        = new Environment("base");
var meterBar    = new Environment("meterBar");
var meterOverlay = new Environment("meterOverlay");
var msg         = new Entity("msg");

var player      = new Entity("player");
var ai          = new Entity("ai");

var brain       = new Currency("Brain");
var heart       = new Currency("Heart");
var hammer      = new Currency("Hammer");
var meterLimit  = new Currency("meterLimit");
var meter       = new Currency("Meter");

var question;
var flag;
var answered;

var optionIndex = 0;

$(function() {
    initTheme();
    
	parent.setGameAttempt(parent.currentIntegratedGame, parent.currentUid);

    window.ondragstart = function() { return false; }


});

function initTheme() {

    loadConfig(base);
    loadConfig(meterBar);
    loadConfig(meterOverlay);

    initQuiz();


    loadConfig(player);
    player.setState('1');

    loadConfig(ai);
    ai.setState('1');

    $("#base img").attr("id", "qt-base-img");
    $("#ai img").attr("id", "qt-ai-img");
    $("#player img").attr("id", "qt-player-img");
    $("#logo img").attr("id", "qt-game-logo");

    $("#qt-base-img").attr("src", getImg("qt-background"));
    $("#qt-player-img").attr("src", getImg("qt-player"));
    $("#qt-ai-img").attr("src", getImg("qt-ai"));
    $(".qt-bot-overlay-img").attr("src", getImg("qt-bottom-overlay"));
    $("#qt-meter-empty").css({background: "url('" + getImg("qt-meter-bar-empty") + "')"});
	$("#qt-meter-overlay").append("<img src=''>");
    $("#qt-meter-overlay img").attr("src", getImg("qt-logo"));
    $("#qt-meter-filled").css({background: "url('" + getImg("qt-meter-bar-filled") + "')"});
    $("#qt-meter-indicator span").text(getText("qt-text-meter"));
    $("#leftOpt").attr("src", getImg("qt-arrow-left"));
    $("#rightOpt").attr("src", getImg("qt-arrow-right"));
    $("#qt-say-button").attr("src", getImg("qt-button-say-this"));
    $("#qt-know-more").attr("src", getImg("qt-button-know-more"));
    $("#qt-speech-bubble-2").attr("src", getImg("qt-options-back"));
    $("#qt-speech-bubble-1").attr("src", getImg("qt-statement-back"));
    $("#message-box-bg").attr("src", getImg("qt-message-box-back"));


    initGame();

    $("#qt-meter-filled").css({width: ai.meter.is()+"%"});
    $("#limit").css({left: ai.meterlimit.is()+"%"});

}


function initGame() {
	
    showInstructions();

    var random  = randBetween(0, game.ai.length-1);
    ai.createWallet(brain, 0, 10, game.ai[random].brain);
    ai.createWallet(heart, 0, 10, game.ai[random].heart);
    ai.createWallet(hammer, 0, 10, game.ai[random].hammer);
    ai.createWallet(meterLimit, 0, 100, game.ai[random].limit);
    random = randBetween(10,20);
    ai.createWallet(meter, 0, 100, random);
    ai.points = [];

    console.log(ai.brain.is());
    console.log(ai.heart.is());
    console.log(ai.hammer.is());

    ai.points.push(random);

    flag = 1;
    answered = true;
}

function showInstructions() {
	$("#message").html("");

    $("#message").css({padding: "2%"});
    $("#message").append(
        '<div id="game-logo"><img src='+getImg("qt-logo")+' /></div>' +
        '<div id="instructions">' +
            '<div id="inst-header"></div>' +
            '<div id="inst-content" class="mCustomScrollbar"></div>' +
        '</div>' +
        '<img id="start-game" />'
    );
    $("#inst-header").text(getText("qt-text-instruction-header"));
    $("#inst-content").html(getText("qt-text-instructions"));
    $("#start-game").attr('src', getImg("qt-button-start"));
    $("#start-game").unbind('mouseover').on('mouseover', function() {
        $("#start-game").attr('src', getImg("qt-button-start-hover"));
    });
    $("#start-game").unbind('mouseout').on('mouseout', function() {
        $("#start-game").attr('src', getImg("qt-button-start"))
    });
    $("#start-game").unbind('click').on('click', function() {
        $("#message-box").fadeOut ();
		observers();
        playGame();
//		victory();
        $("#message").css({padding: "7%"});
        $("#game-logo").hide();
        $("#instructions").remove();
        $("#start-game").hide();

    });
}


function playGame() {
    question = getQuestion();
    setTimeout(function() {answered = false;}, 500)
    Question.showQuizPanel(quiz, question);
    $(".option-block").hide();
    optionScroller(0);

}

function getQuestion() {
    var question = Question.getByWeight(flag);
    parent.setQuestionAttempt(question.id);
    console.log(question);
    return question;
}

function processAnswer(data) {
    parent.markQuestionAttemptCorrect();

    var points = data.points;
    var brain = parseInt(points[0]);
    var heart = parseInt(points[1]);
    var hammer = parseInt(points[2]);

    points = (ai.brain.is()*brain)+(ai.heart.is()*heart)+(ai.hammer.is()*hammer);
    ai.meter.is(ai.meter.is() + points);

    $(ai.meter).unbind().on('max', function(value, max) {
        ai.meter.is(ai.meter.max);
    });

    $("#qt-meter-filled").animate({
        width: ai.meter.is()+"%"
    }, 500);
    ai.points.push(points);

	console.log(flag);
    flag++;
    
    if(flag > 10)
        endGame();
    else
        playGame();

    return true;
}

function endGame() {
    $("*").unbind('click');
    $("#qt-meter-filled").fadeOut(250).delay(100).fadeIn(250).delay(100).fadeOut(250).delay(100).fadeIn(250);

    setTimeout(function() {
//        $("#player").css({opacity: 0.9});
//        $("#ai").css({opacity: 0.9});
        if(ai.meter.is() > ai.meterlimit.is())
            victory();
        else
            defeat();
    }, 2500);
}

function victory() {
	$("#message").html("");
    $("#message").append("<span>You Win!</span>");
//	$("#start-game").show();
//	$("#game-logo").show();
	$("#message-box").fadeIn();
	$("#quiz").remove();
	
	$("#message").append("<p><img src='" + getImg("qt-button-play-again") + "' id='play-again' />");
	
	$("#play-again").hover(function() {
		$(this).attr("src", getImg("qt-button-play-again-hover"));
	}, function() {
		$(this).attr("src", getImg("qt-button-play-again"));
	});
	
	$("#play-again").unbind('click').on('click', function() {
		initTheme();
	});
}

function defeat() {
	$("#message").html("");
    $("#message").append("<span>You Lose!</span>");
	$("#message-box").fadeIn();
	$("#quiz").remove();
	
	$("#message").append("<p><img src='" + getImg("qt-button-play-again") + "' id='play-again' />");
	
	$("#play-again").hover(function() {
		$(this).attr("src", getImg("qt-button-play-again-hover"));
	}, function() {
		$(this).attr("src", getImg("qt-button-play-again"));
	});
	
	$("#play-again").unbind('click').on('click', function() {
		
		initTheme();
		$("#inst-content").mCustomScrollbar();
	});
}


function observers() {

    var checkEndOfList = function() {
        if(optionIndex==0)
            $("#leftOpt").css({visibility: "hidden"});
        else if(optionIndex==3)
            $("#rightOpt").css({visibility: "hidden"});
        else
        {
            $("#leftOpt").css({visibility: "visible"});
            $("#rightOpt").css({visibility: "visible"});
        }
    }

    checkEndOfList();

    $("#leftOpt").unbind('click').on('click', function() {
        changeOption($(".option-show").attr("id"), "left");
        checkEndOfList();
    });

    $("#rightOpt").unbind('click').on('click', function() {
        changeOption($(".option-show").attr("id"), "right");
        checkEndOfList();
    });

    $("#qt-say-button").unbind('click').on('click', function()
	{
		
        if(answered == false) {
			
				$(question).unbind('answered').on('answered', 					function (e,data) {
					console.log(data)
						answered = true;
						processAnswer(data);
					});	
			
				$(".option-block:first").trigger('click');
			
				$("#leftOpt").css({visibility: "hidden"});
				$("#rightOpt").css({visibility: "visible"});
				optionIndex = 0;
				
            }

    });

    $("#help").unbind('click').on('click', function() {
        initHowto(config.howtoData, "light");
    });
}

function changeOption(id, direction) {
    optionIndex = parseInt(id.charAt(id.length-1));
    console.log(optionIndex);
    switch(direction) {
        case "left":
            if(optionIndex != 0)
                optionIndex--;

            else
                optionIndex = question.options.length - 1;

            optionScroller(optionIndex);
            break;

        case "right":
            if(optionIndex != question.options.length - 1)
                optionIndex++;
            else if(optionIndex==1)
                $("#leftOpt").css({visibility: "hidden"});
            else
                optionIndex = 0;

            optionScroller(optionIndex);
            break;
    }
}

function optionScroller(optionIndex) {
    $(".option-block").removeClass("option-show");
    $("#option-block-"+optionIndex).addClass("option-show");
    $("#option-block-"+optionIndex).hide();
    $("#option-block-"+optionIndex).fadeIn(500);
}
