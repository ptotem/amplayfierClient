var land = new Environment("land");
var city = new Environment("city");
var overlay = new Environment("overlay");
var playdeck = new CardDeck("playdeck", []);
var player = new Entity("player", []);
var grailLocation;

$(function () {
    initGame();
    playGame();
    parent.setGameAttempt(parent.currentIntegratedGame,parent.currentUid);
});

function initGame() {
    loadConfig(land);
    loadConfig(city);
    loadConfig(overlay);
    loadConfig(player);
    initPlayer();
    initCards();
    initQuiz();
    initNotifications();
    cards.shuffle();
    playdeck.location(city.cardblock);
}

function playGame(){

    // Hide the grail

    grailLocation = land.locations[randBetween(0, land.locations.length - 1)];

    // Animate the player across the map and then open up the city view

    $('#land .location').on('click', function () {
        var oldLocation = player.location();
        var newLocation = land[$(this).attr("id")];
        if (oldLocation != newLocation) {
            var oldPosition = $('#' + oldLocation.name).position() || 0;
            var newPosition = $('#' + newLocation.name).position() || 0;
            $('#player').detach().appendTo('#land').css({
                left: oldPosition.left,
                top: oldPosition.top
            }).animate({
                width: "32px",
                left: newPosition.left,
                top: newPosition.top
            }, 1500, function () {
                $('#player').css({'left': 0, 'top': 0});
                player.location(newLocation);
                showCity(newLocation.name);
            });
        }
    });
}

function initPlayer() {
    var life = new Currency("life");
    var gold = new Currency("gold");
    player.createWallet(life, 0, 999999, 100);
    player.createWallet(gold, 0, 999999, 500);
}

function showCity(name) {

    // Draw 3 cards for the city and show the city view

    playdeck.items = [];
    playdeck.addItems(cards.drawCards(3));
    $('#cityname').html(name.toUpperCase());
    $('#city').fadeIn();

    // Player selects a card in the city

    $('.item').unbind('click').on('click', function () {
        var thisCard = findByName('Item', $(this).attr("id"));

        if (thisCard.attributes.question) {

            // If the card is a question, open the question view

            showQuestion();
            cards.cardToBottom(thisCard);
        } else {

            // If the card is not a question, try to play the selected card
            // If the player can afford it, play it.

            var costCurrency = thisCard.attributes.costCurrency;
            var gainCurrency = thisCard.attributes.gainCurrency;
            var cost = randBetween(thisCard.attributes.minCost, thisCard.attributes.maxCost);
            var payoff = randBetween(thisCard.attributes.minGain, thisCard.attributes.maxGain);

            if (player[costCurrency].decrBy(cost)) {
                player[gainCurrency].incrBy(payoff);
                notify('<img src="img/' + thisCard.name.split('_')[0] + '.jpg"/>You spent ' + cost + ' ' + costCurrency + ' to gain ' + payoff + ' ' + gainCurrency, 3000);
                cards.cardToBottom(thisCard);
            }
        }

    });


    // When the player travels from one city to the other, he loses life

    $('#travel').unbind('click').on('click', function () {
        if (!(player.life.decrBy(20) === false)) {
            $('#city').fadeOut();
            notify(config.messages.travel, 1000);
            for (var i = 0; i < playdeck.items.length; i++) {
                cards.cardToBottom(playdeck.items[i]);
            }
        }
    });

    // The player searches for the grail in the current city. If he finds it, he wins

    $('#grailhunt').unbind('click').on('click', function () {
        if (!(player.gold.decrBy(500) === false)) {
            if (player.location() === grailLocation) {
                gameUp('victory');
            } else {
                notify(config.messages.grailfail, 2500);
            }
        }
    });

    // If the player's life goes to 0, he is dead

    $(player.life).unbind('min').on('min', function () {
        player.life.is(player.life.min);
        gameUp('dead');
    });


    // If the player can't afford something, notify him

    $(player.gold).unbind('min').on('min', function () {
        notify(config.messages.unaffordable, 1000);
    });

}

// Show the quiz panel

function showQuestion() {
    $('#city').fadeOut();
    var question = Question.getByWeight(1)
    parent.setQuestionAttempt(question.id);
    $('#quiz').fadeIn(function () {
        Question.showQuizPanel(quiz, question);
        console.log(question)
    });
    $(question).on('answered', function (e, data) {
        if (data.correct) {
            parent.markQuestionAttemptCorrect();
            quiz.statement.setState("correct");
            quiz.options.setState("correct");
            if (player.location() === grailLocation) {
                $('#grail-statement').html(config.messages.grailhere)
            } else {
                $('#grail-direction').html(grailDirections());
            }
        } else {
            quiz.statement.setState("wrong");
            quiz.options.setState("wrong");
            player.life.decrBy(20);
        }
        setTimeout(function () {
            $("#quiz").fadeOut(function () {
                $('#city').fadeIn();
                quiz.statement.setState('default');
                quiz.options.setState('default');
            });
        }, 2000);
    });
}


function grailDirections() {
    var playerLoc = $("#" + player.location().name).position();
    var grailLoc = $("#" + grailLocation.name).position();
    if (randBetween(0, 1) == 1) {
        return (playerLoc.top < grailLoc.top) ? "SOUTH" : "NORTH";
    } else {
        return (playerLoc.left < grailLoc.left) ? "EAST" : "WEST";
    }
}

function gameUp(status) {
    $('#city').fadeOut();
    $('#land').css({
        'opacity': 0.3,
        'pointer-events': 'none'
    });
    switch (status) {
        case 'dead':
            notify(config.messages.dead, 9999999);
            break;
        case 'victory':
            notify(config.messages.victory, 9999999);
            $('#grail').animate({
                left: "60%",
                top: "40%",
                width: "200px"
            });
            break;
    }
}
