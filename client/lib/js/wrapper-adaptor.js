var i;

/* =============================================================================================== */
/* Initialization Routine */
/* =============================================================================================== */

/* Initialize the Page */
function initPage() {

    /* Set the Title of the Platform */
    $('title').text(storyConfig.name);

    /* Set the Story Nameplate */
    $('#story-nameplate').attr('src', storyConfig.imgsrc + "/" + storyConfig.nameplate.image);

    /* Set the Story Presenter */
    $('#story-presenter').attr('src', storyConfig.imgsrc + "/" + storyConfig.presenter.image);

    /* Set the Story Zone Design */
    $('#story-zone').css({
        backgroundImage: 'url(' + storyConfig.imgsrc + "/" + storyConfig.zone.background + ')',
        left: (window.innerWidth > 1280) ? (storyConfig.zone.px + "%") : "5%",
        top: (window.innerWidth > 1280) ? (storyConfig.zone.py + "%") : "3%"
    });

    /* Set the Wrapper Design */
    setDesign();
    $(window).on('resize', setDesign);

    /* Show the screen */
    setTimeout(function () {
        initDeckStates();
        createLandscapeView();
        createPortraitView();
        initNodeStates();
        drawNodes();
        $('#story-wrapper').fadeIn('slow');
        $('#story-node-0').trigger('click');
    }, 1000);

}

/* =============================================================================================== */
/* State Management Variables and Routines */
/* =============================================================================================== */

var deckStates = [];
/* Initialize the Decks from the source Data*/
function initDeckStates() {
    for (i in userdata.decks) {
        deckStates.push({
            deckId: userdata.decks[i].deckId,
            state: userdata.decks[i].complete
        })
    }
}

var nodeStates = [];
/* Initialize the Nodes from the source Data*/
function initNodeStates() {
    for (i in platformData.nodes) {
        var thisNodeData = platformData.nodes[i];
        var thisNodeState = "complete"
        var requiredDecks = thisNodeData.decks;
        for (deck in requiredDecks) {
            if (!checkDeck(requiredDecks[deck])) thisNodeState = "incomplete";
        }
        nodeStates.push({
            sequence: thisNodeData.sequence,
            nodeId: i,
            state: thisNodeState
        });
    }
}

/* Refresh Node States when decks are completed */
function refreshNodeStates() {
    for (i in platformData.nodes) {
        var thisNodeData = platformData.nodes[i];
        var thisNodeState = "complete"
        var requiredDecks = thisNodeData.decks;
        for (deck in requiredDecks) {
            console.log(checkDeck(requiredDecks[deck]));
            if (!checkDeck(requiredDecks[deck])) thisNodeState = "incomplete";
        }
        setNodeState(thisNodeData.sequence, thisNodeState);
    }
    drawNodes();
}

/* Get the State of a Node */
function getNodeState(sequence) {
    return jQuery.grep(nodeStates, function (a) {
        return (a.sequence == sequence);
    })[0].state;
}

/* Set the State of a Node */
function setNodeState(sequence, state) {
    jQuery.grep(nodeStates, function (a) {
        return (a.sequence == sequence);
    })[0].state = state;
}

/* =============================================================================================== */
/* Node Display Routines */
/* =============================================================================================== */

/* Show the Node as per the State */
function showNode(nodeId, nodeState) {
    var nodeData = storyConfig.nodes[nodeId]
    var nodePic, nodeClass;
    if (nodeState == "complete") {
        nodeClass = "complete-node";
        nodePic = (nodeData.complete == "" ? storyConfig.nodestyle.complete : nodeData.complete)
    } else {
        if (nodeState == "active") {
            nodeClass = "active-node";
            nodePic = (nodeData.active == "" ? storyConfig.nodestyle.active : nodeData.active)
        } else {
            nodePic = storyConfig.nodestyle.incomplete;
            nodeClass = "incomplete-node";
            nodePic = (nodeData.incomplete == "" ? storyConfig.nodestyle.incomplete : nodeData.incomplete)
        }
    }
    $('#story-node-' + nodeId).html('<img src="' + storyConfig.imgsrc + "/" + nodePic + '" alt=""/>');
    $('#story-node-' + nodeId).removeClass('complete-node incomplete-node active-node').addClass(nodeClass);
    $('#portrait-panel-' + nodeId).removeClass('complete-node incomplete-node active-node').addClass(nodeClass);
}

/* Draw all the nodes with their current States and set the Active Node */
function drawNodes() {
    var activeMarked = false;
    for (i in platformData.nodes) {
        var thisNodeState = getNodeState(platformData.nodes[i].sequence);
        if (i == (platformData.nodes.length - 1)) {
            thisNodeState = "incomplete"
        }
        if (thisNodeState == "incomplete" && !activeMarked) {
            thisNodeState = "active";
            activeMarked = true;
        }
        showNode(i, thisNodeState);
    }
}

/* =============================================================================================== */
/* Page Display Routines */
/* =============================================================================================== */

/* Set the Layout as per the Orientation of Device */
function setDesign() {

    if (isPortrait()) {
        $('#story-nameplate').css({
            left: storyConfig.nameplate.portraitpx + "%",
            top: storyConfig.nameplate.portraitpy + "%",
            width: storyConfig.nameplate.portraitwidth + "%"
        });

        /* Set the Story Presenter */
        $('#story-presenter').css({
            left: storyConfig.presenter.portraitpx + "%",
            top: storyConfig.presenter.portraitpy + "%",
            width: storyConfig.presenter.portraitwidth + "%"
        });

        $('#story-wrapper').css({
            'background-image': 'url(' + storyConfig.imgsrc + "/" + storyConfig.portraitBackground + ')',
            height: "100vh"
        });
    } else {
        /* Set the Story Nameplate */
        $('#story-nameplate').css({
            left: storyConfig.nameplate.px + "%",
            top: storyConfig.nameplate.py + "%",
            width: storyConfig.nameplate.width + "%"
        });

        /* Set the Story Presenter */
        $('#story-presenter').css({
            left: storyConfig.presenter.px + "%",
            top: storyConfig.presenter.py + "%",
            width: storyConfig.presenter.width + "%"
        });

        $('#story-wrapper').css({
            'background-image': 'url(' + storyConfig.imgsrc + "/" + storyConfig.background + ')',
            height: window.innerWidth * 9 / 16
        });
    }

}

/* Add the Nodes in the Landscape View */
function createLandscapeView() {
    for (i in platformData.nodes) {
        var thisNodeData = platformData.nodes[i];
        var thisNodeConfig = getNodeConfig(thisNodeData.sequence);

        $('#story-nodes').append('<a href="#" tabindex="0" data-toggle="popover" class="story-node" id="story-node-' + i + '" style="top:' + thisNodeConfig.py + '%;left:' + thisNodeConfig.px + '%;width:' + (thisNodeConfig.width + ((thisNodeConfig.width == "auto") ? "" : "%")) + ';"></a>');

        if (storyConfig.formal) {
            var $thisNode = $('#story-node-' + i);
            $thisNode.append("<div class='node-display-wrapper'><div class='node-display-content'><div class='node-display-title'>" + getNodeData(thisNodeData.sequence).title + "</div><div class='node-display-text'>" + getNodeData(thisNodeData.sequence).subtitle + "</div></div></div>")
            $thisNode.find('.node-display-wrapper').css({
                textAlign: storyConfig.nodestyle.align,
                height: $thisNode.innerHeight() * 0.8 + "px"
            });
        }
    }
    if (storyConfig.formal) {
        $('.node-display-title').css({
            fontSize: storyConfig.nodestyle.titleSize,
            color: storyConfig.nodestyle.titleColor
        });
        $('.node-display-text').css({
            fontSize: storyConfig.nodestyle.descSize,
            color: storyConfig.nodestyle.descColor
        });
    }
    bindNodes();
}

/* Add the Nodes in the Portrait View and bind the decks directly */
function createPortraitView() {

    for (i in platformData.nodes) {
        var thisNodeData = platformData.nodes[i];
        var thisNodeConfig = getNodeConfig(thisNodeData.sequence);

        $(".panel-group").append('<div class="panel panel-default portrait-panel" id="portrait-panel-' + i + '"><div class="panel-heading">' +
            '<h4 class="panel-title">' +
            '<a data-toggle="collapse" data-parent="#accordion" href="#collapse-' + i + '" class="">' + ((thisNodeData.title == "") ? thisNodeConfig.title : thisNodeData.title) + '</a>' +
            '</h4>' +
            '</div>' +
            '<div id="collapse-' + i + '" class="panel-collapse collapse">' +
            '</div>' +
            '</div>'
        );

        var leftBlock, rightBlock = "";

        if (storyConfig.formal) {
            leftBlock = (thisNodeData.description == "" ? thisNodeConfig.description : thisNodeData.description);
        } else {
            leftBlock = ('<img src="' + storyConfig.imgsrc + "/" + thisNodeConfig.photo + '" class="story-zone-photo-portrait"/>') + (thisNodeData.description == "" ? thisNodeConfig.description : thisNodeData.description);
        }

        for (j in thisNodeData.decks) {
            console.log(thisNodeData.decks[j]);
            var deckStatus = "";
            rightBlock += '<a href="#" class="zone-portrait-deck zone-portrait-button zone-button ' + deckStatus + '" id="portraitdeck-' + j + '-' + thisNodeData.decks[j] + '">' + getDeck(thisNodeData.decks[j]).name + '</a>'
        }

        finalHtml = '<div class="panel-body"><div class="row"><div class="col-sm-4">' + leftBlock + '</div><div class="col-sm-8">' + rightBlock + '</div></div></div>';

        $("#collapse-" + i).append(finalHtml);

    }
    if (!platformData.sequential) {
        $('.portrait-panel.incomplete-node > .panel-heading').css({
            'pointer-events': 'auto'
        })
    }

    bindZoneSections($('.zone-portrait-deck'), "left");

}

/* Open the Story Zone in the Landscape view and bind the Decks  */
function landscapeOpen(sequence) {
    console.log(sequence);
    if(sequence==0)
      sequence = sequence+1

    var thisNode = getNodeData(sequence);
    var thisNodeConfig = getNodeConfig(sequence);
    var $storyZone = $('#story-zone');
    $storyZone.empty();

    if (window.innerWidth > 1050) {
        $('#story-nameplate').animate({
            width: storyConfig.nameplate.reduced + "%"
        });
    } else {
        if (!isPortrait()) {
            $('#story-nameplate').fadeOut();
        }
    }
    $('<a id="story-zone-close" href="#" class="btn btn-lg">Close</a>').appendTo($storyZone);

    var $deck, $buttonBank;
    if (storyConfig.formal) {

        $("<div class='story-zone-name-formal'><div class='node-display-wrapper'><div class='node-display-content'><div class='zone-display-title'>" + getNodeData(seq).title + "</div><div class='zone-display-text'>" + getNodeData(seq).subtitle + "</div></div></div></div>").appendTo($storyZone);
        $('.zone-display-title').css({
            fontSize: storyConfig.nodestyle.titleSize,
            color: storyConfig.nodestyle.titleColor
        });
        $('.zone-display-text').css({
            fontSize: storyConfig.nodestyle.descSize,
            color: storyConfig.nodestyle.descColor
        });
        $('<div class="story-zone-tale-formal">' + (thisNode.description == "") ? thisNodeConfig.description : thisNode.description + '</div>').appendTo($storyZone);

        $buttonBank = $('<div id="button-bank-formal"></div>').appendTo($storyZone);

    } else {
        $('<img src="' + storyConfig.imgsrc + "/" + thisNodeConfig.photo + '" class="story-zone-photo"/>').appendTo($storyZone);
        $('<div class="story-zone-name">' + ((thisNode.title == "") ? thisNodeConfig.name : thisNode.title) + '</div>').appendTo($storyZone);
        $('<div class="story-zone-tale">' + ((thisNode.description == "") ? thisNodeConfig.description : thisNode.description) + '</div>').appendTo($storyZone);

        $buttonBank = $('<div id="button-bank"></div>').appendTo($storyZone);
    }

    for (i in thisNode.decks) {
        var deckStatus = "";
        $deck = $('<a href="#" class="zone-deck zone-button ' + deckStatus + '" id="deck-' + i + '-' + thisNode.decks[i] + '">' + getDeck(thisNode.decks[i]).name + '</a>').appendTo($buttonBank);
    }

    bindZoneSections($('.zone-deck'), "left");

    $storyZone.fadeIn();
}

/* Open the Story Zone in the Portrait view */
function portraitOpen() {
    $('#accordion').css({
        "pointer-events": "none",
        opacity: 0
    });
    var $storyZone = $('#story-zone');
    $storyZone.empty();
    $('<a id="story-zone-close" href="#" class="btn btn-lg">Close</a>').appendTo($storyZone);
    $('#story-zone-close').on('click', portraitClose);
    $storyZone.fadeIn();
}

/* Close the Story Zone in the Portrait view */
function portraitClose() {
    $("#story-zone").fadeOut();
    $('#accordion').css({
        "pointer-events": "auto",
        opacity: 1
    });
}

/* Bind the Nodes in the Landscape View */
function bindNodes() {
    var storyNodes = $('.story-node');

    if (storyConfig.nodestyle.popovers) {

        storyNodes.popover('destroy');
        storyNodes.popover({
            placement: function () {
                var thisNode = getNodeConfig(getSequence(this.$element));
                var direction;
                switch (true) {
                case (thisNode.py < 40):
                    direction = "bottom";
                    break;
                case (thisNode.py > 40 && thisNode.py < 60 && thisNode.px < 50):
                    direction = "right";
                    break;
                case (thisNode.py > 40 && thisNode.py < 60 && thisNode.px > 50):
                    direction = "left";
                    break;
                default:
                    direction = "top";
                }
                return direction
            },
            trigger: "hover",
            html: true,
            title: function () {
                seq = getSequence(this);
                if (storyConfig.formal) {
                    return ((getNodeData(seq).title == "") ? getNodeConfig(seq).name : (getNodeData(seq).title + " : " + getNodeData(seq).subtitle)).toUpperCase();
                } else {
                    return ((getNodeData(seq).title == "") ? getNodeConfig(seq).name : getNodeData(seq).title).toUpperCase();
                }
            },
            content: function () {
                var seq = getSequence(this);
                var photo = (getNodeConfig(seq).photo == "") ? '' : '<img class="popover-photo" src="' + storyConfig.imgsrc + "/" + getNodeConfig(seq).photo + '"/>';
                var status = $(this).attr("class").split(" ")[1].split("-")[0];
                var desc;
                if (status != "incomplete") {
                    if (storyConfig.formal) {
                        desc = (getNodeData(seq).description == "") ? getNodeConfig(seq).description : getNodeData(seq).description;
                    } else {
                        desc = (getNodeData(seq).subtitle == "") ? getNodeConfig(seq).subtitle : getNodeData(seq).subtitle;
                    }

                    if (status == "final" || !platformData.sequential) {
                        return photo + desc;
                    } else {
                        return photo + desc + '<br/><div class="popover-content-block ' + status + '-popover-content">' + status.toUpperCase() + '</div>';
                    }
                } else {
                    return photo + '<br/><div class="popover-content-block ' + status + '-popover-content">' + status.toUpperCase() + '</div>';
                }

            }
        });

    }

    storyNodes.hover(
        function () {
            $(this).css({
                "box-shadow": storyConfig.nodestyle.hover
            })
        },
        function () {
            $(this).css({
                "box-shadow": "none"
            })
        }
    );

    storyNodes.unbind('click').on('click', function () {
        $('[data-toggle="popover"]').popover('hide');
        var seq = getSequence(this);
        if (!$(this).hasClass('incomplete-node')) {
            storyNodes.css({
                "pointer-events": "none",
                opacity: 0
            });
            landscapeOpen(seq);
            $('#story-zone-close').on('click', closeStoryZone);
        } else {
            alert("This chapter has not been unlocked yet");
        }
    })
}

/* Bind the Deck Links for Popover and Clicks  */
function bindZoneSections(zoneDecks, direction) {

    zoneDecks.popover("destroy");

    zoneDecks.popover({
        placement: direction,
        trigger: "hover",
        html: true,
        title: function () {
            return getDeck($(this).attr("id").split("-")[2]).name;
        },
        content: function () {
            var deckId = $(this).attr("id").split("-")[2];
            var desc = getDeck(deckId).deckDesc;
            var status = checkDeck(deckId) ? "complete" : "incomplete";
            return desc + '<br/><div class="popover-content-block ' + status + '-popover-content">' + status.toUpperCase() + '</div>';
        }
    });

    zoneDecks.unbind("click").on('click', function () {
        if (isPortrait()) portraitOpen();
        showDeck(getSequence(this));
    });

}

/* Update the Wrapper when the states change  */
function updateWrapper() {
    refreshNodeStates();
    bindNodes();
    bindZoneSections($('.zone-deck'), "left");
    bindZoneSections($('.zone-portrait-deck'), "left");
}

/* =============================================================================================== */
/* Story Display Routines */
/* =============================================================================================== */

/* Open a Deck in the Story Zone */
// TODO: THIS IS TEST CODE. IT HAS TO BE INTEGRATED WITH AMPLAYFIER AND THIS CODE HAS TO BE REMOVED.
function showDeck(deckId) {
    console.log ("deckId")
    console.log (deckId)

    // This is the function to call if the Deck has been completed
    completeDeck(deckId);

    var thisDeck = getDeck(deckId);
    var $storyZone = $('#story-zone');

    // This is the code for the playbar
    $('<div class="story-zone-playbar"><a href="#" class="prev-slide btn btn-warning pull-left playbar-btn"> < </a><a href="#" class="next-slide btn btn-info  pull-left playbar-btn"> > </a><div class="projector-nav"></div><a id="story-block-close" href="#" class="btn btn-danger pull-right playbar-btn">Exit Deck</a><a href="#" class="btn btn-primary fullscreener pull-right playbar-btn">Full Screen</a></div>').appendTo($storyZone);

    // This is the div where the deck gets shown
    var $projector = $('<div class="projector projection"></div>').appendTo($storyZone);

    // This is the code to exit the Decl
    $('#story-block-close').unbind().on('click', closeDeck);

    // This is the test carousel code
    for (var j = 1; j < thisDeck.slides + 1; j++) {
        $projector.append('<div><img src="img/decks/' + deckId + '/Slide' + j + '.JPG"/></div>')
    }
    $projector.slick({
        autoplay: false,
        arrows: true,
        infinite: false,
        appendArrows: $('.projector-nav'),
        prevArrow: '<button type="button" class="btn btn-warning playbar-btn"> < </button>',
        nextArrow: '<button type="button" class="btn btn-info playbar-btn"> > </button>'
    });

    // This is the test fullscreen code
    $('.fullscreener').click(function () {
        $('#story-wrapper').fadeOut();
        $('#full-wrapper').slideDown(function () {
            var $fullProjector = $('<div class="fullprojector fullprojection"></div>').appendTo($(this));
            var $fullCloser = $('<div class="fullcloser fullprojection"><button type="button" class="btn btn-danger btn-lg" style="color: black"> Close </button></div>').appendTo($(this));

            for (var j = 1; j < thisDeck.slides + 1; j++) {
                $fullProjector.append('<div><img src="img/decks/' + deckId + '/Slide' + j + '.JPG"/></div>')
            }
            $fullProjector.slick({
                autoplay: false,
                arrows: true,
                infinite: false,
                prevArrow: '<button type="button" class="btn btn-warning btn-lg" style="color: black"> Previous </button>',
                nextArrow: '<button type="button" class="btn btn-warning btn-lg pull-right" style="color: black"> Next </button>'
            });

            $fullCloser.on('click', function () {
                $('#full-wrapper').fadeOut();
                $('#story-wrapper').fadeIn();
                $('.fullprojection').remove();
            })

        });
    })

}

function closeStoryZone() {
    var storyNodes = $('.story-node');
    $("#story-zone").fadeOut();
    storyNodes.css({
        "pointer-events": "auto",
        opacity: 1
    });
    if (!isPortrait()) {
        $('#story-nameplate').animate({
            width: storyConfig.nameplate.width + "%"
        });
    }

}

function closeDeck() {
    $('.projection').remove();
    $('.story-zone-playbar').remove();

}


/* =============================================================================================== */
/* Parser and Helper Routines */
/* =============================================================================================== */

/* Check if the current orientation is Portrait */
function isPortrait() {
    return (window.innerHeight > window.innerWidth)
}

/* Get Sequence Number of node where event happens */
function getSequence(obj) {
    return $(obj).attr("id").split("-")[2];
}

/* Get Configuration for a given Node  */
function getNodeConfig(sequence) {
    return jQuery.grep(storyConfig.nodes, function (a) {
        return (a.sequence == sequence);
    })[0];
}

/* Get Author Customizations (description and decks) for a given Node  */
function getNodeData(sequence) {
    return jQuery.grep(platformData.nodes, function (a) {
        return (a.sequence == sequence);
    })[0];
}

/* Get Deck by Id */
function getDeck(id) {
    return jQuery.grep(wrapperDecks, function (a) {
        return (a.deckId== id);
    })[0];
}

/* Check if a Deck has been completed */
function checkDeck(id) {
    var userDataDeck = jQuery.grep(deckStates, function (a) {
        return (a.deckId == id);
    })[0];
    if (userDataDeck.state) return true;
}

/* Mark a Deck as complete */
function completeDeck(id) {
  console.log (id)
    jQuery.grep(deckStates, function (a) {
        return (a.deckId == id);
    })[0].state = true;
    updateWrapper();
}

window.initPage = initPage;
