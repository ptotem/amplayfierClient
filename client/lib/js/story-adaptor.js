var i;

/* =============================================================================================== */
/* Initialization Routine */
/* =============================================================================================== */

/* Initialize the Page */
function initPage() {

    /* Set the Title of the Platform */
    //$('title').text(storyConfig.name);

    /* Set the Story Nameplate */
    //$('#story-nameplate').attr('src', storyConfig.imgsrc + "/" + storyConfig.nameplate.image);

    /* Set the Story Presenter */
    //$('#story-presenter').attr('src', storyConfig.imgsrc + "/" + storyConfig.presenter.image);

    /* Set a suitable background tint to the page */
    //$('#main-oc-container').css('background-color', storyConfig.background.color);

    /* Set the Wrapper Design */
    setDesign(isPortrait() ? "portrait" : "landscape");
    $(window).on('resize', setDesign(isPortrait() ? "portrait" : "landscape"));

    /* Show the screen */
    setTimeout(function () {
        initDeckStates();
        //createView();
        initNodeStates();
        //drawNodes();
        $('body').fadeIn('fast');
        showNotification("welcome");
    }, 1000);


}

/* Set the Layout as per the Orientation of Device */
function setDesign(orientation) {

    /* Set the Story Orientation */
    $('#story-wrapper').removeClass('portrait-mode').removeClass('lanndscape-mode').addClass(orientation + '-mode');

    /* Set the Story Background */
    //$('#story-content').css({
    //    'background-image': 'url(' + storyConfig.imgsrc + "/" + storyConfig.background.image + ')'
    //});

    /* Set the Story Nameplate */
    $('#story-nameplate').css({
        left: storyConfig.nameplate[orientation].left + "%",
        bottom: storyConfig.nameplate[orientation].bottom + "%",
        width: storyConfig.nameplate[orientation].width + "%"
    });

    /* Set the Story Presenter */
    $('#story-presenter').css({
        left: storyConfig.presenter[orientation].left + "%",
        bottom: storyConfig.presenter[orientation].bottom + "%",
        width: storyConfig.presenter[orientation].width + "%"
    });

    /* Set the Story Overlays */
    $('#story-overlays').empty();
    for (i in storyConfig.overlays) {
        var overlay = storyConfig.overlays[i];
        $('#story-overlays').append('<img src="' + storyConfig.imgsrc + '/' + overlay.image + '" class="story-overlay" style="left:' + overlay[orientation].left + '%;bottom:' + overlay[orientation].bottom + '%;width:' + overlay[orientation].width + '%;z-index:' + (overlay.onTop ? 9999999 : 0) + '"/>');
    }

    /* Set the Story Notifications */
    $('#notifications-splash').css({
        width: storyConfig.notifications[orientation].width + "%",
        left: storyConfig.notifications[orientation].left + "%",
        bottom: storyConfig.notifications[orientation].bottom + "%"
    });

    //for (i in platformData.nodes) {
    //    var thisNodeConfig = getNodeConfig(platformData.nodes[i].sequence);
    //    $('#story-node-' + i).css({
    //        top: thisNodeConfig[orientation].py + '%',
    //        left: thisNodeConfig[orientation].px + '%',
    //        width: thisNodeConfig[orientation].width + '%'
    //    });
    //
    //}

    /* Set the Adjustments for squarer screens  */
    if (isSquarer()) $('#story-wrapper').addClass('setSmaller');
}

/* =============================================================================================== */
/* State and Node Management Variables and Routines */
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
        var thisNodeState = "complete";
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

/* Show the Node as per the State */
function showNode(nodeId, nodeState) {
    var nodeConfig = storyConfig.nodes[nodeId];
    var nodeData = platformData.nodes[nodeId];
    var $thisNode = $('#story-node-' + nodeId);
    var nodePic, nodeClass;
    if (nodeState == "complete") {
        nodeClass = "complete-node";
        nodePic = (nodeConfig.complete == "" ? storyConfig.nodestyle.complete : nodeConfig.complete)
    } else {
        if (nodeState == "active") {
            nodeClass = "active-node";
            nodePic = (nodeConfig.active == "" ? storyConfig.nodestyle.active : nodeConfig.active)
        } else {
            nodePic = storyConfig.nodestyle.incomplete;
            nodeClass = "incomplete-node";
            nodePic = (nodeConfig.incomplete == "" ? storyConfig.nodestyle.incomplete : nodeConfig.incomplete)
        }
    }
    $thisNode.html('<img src="' + storyConfig.imgsrc + "/" + nodePic + '" alt=""/>');
    $thisNode.removeClass('complete-node incomplete-node active-node').addClass(nodeClass);
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
    if (platformData.sequential) $('.incomplete-node').hide();
}


/* =============================================================================================== */
/* View Routines */
/* =============================================================================================== */

/* Add the Nodes in the View */
function createView() {
    for (i in platformData.nodes) {
        var thisNodeData = platformData.nodes[i];
        var thisNodeConfig = getNodeConfig(thisNodeData.sequence);
        var orientation = isPortrait() ? "portrait" : "landscape";

        //$('#story-nodes').append('<a href="#" tabindex="0" class="story-node" id="story-node-' + i + '" style="top:' + thisNodeConfig[orientation].py + '%;left:' + thisNodeConfig[orientation].px + '%;width:' + thisNodeConfig[orientation].width + '%;"></a>');

    }
    bindNodes();
}

/* Bind the Nodes in the Landscape View */
function bindNodes() {
    var storyNodes = $('.story-node');

    storyNodes.popover('destroy');
    storyNodes.popover({
        placement: function () {
            return ((getNodeConfig(getSequence(this.$element)).px < 50) ? "right" : "left")
        },
        container: 'body',
        trigger: "hover",
        html: true,
        title: function () {
            seq = getSequence(this);
            return ((getNodeData(seq).title == "") ? getNodeConfig(seq).name : getNodeData(seq).title).toUpperCase();

        },
        content: function () {
            var seq = getSequence(this);
            var photo = (getNodeConfig(seq).photo == "") ? '' : '<img class="popover-photo" src="' + storyConfig.imgsrc + "/" + getNodeConfig(seq).photo + '"/>';
            var status = $(this).attr("class").split(" ")[1].split("-")[0];
            if (status != "incomplete") {
                var desc = getNodeData(seq).description
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

    storyNodes.unbind('click').on('click', function (e) {
        e.stopPropagation();
        $('[data-toggle="popover"]').popover('hide');
        showPinboard(this);
    });
}

/* Show the Pinboard */
function showPinboard(node) {
    var seq = getSequence(node);
    var thisNode = getNodeData(seq);
    var photo = (getNodeConfig(seq).photo == "") ? '' : '<img src="' + storyConfig.imgsrc + "/" + getNodeConfig(seq).photo + '"/>';
    var status = $(node).attr("class").split(" ")[1].split("-")[0];

    $('#pin-banner-img').html(photo);
    $('#pin-banner-desc .banner-content h1').html(thisNode.title);
    $('#pin-banner-desc .banner-content h4').html(thisNode.description);
    $('#pin-banner-desc .banner-content .banner-status').html(status.toUpperCase());
    $('#modal-pinboard').empty();

    for (i in thisNode.decks) {
        var thisDeck = getDeck(thisNode.decks[i]);
        var deckId = thisDeck._id;
        var deckTitle = thisDeck.name;
        var deckDesc = thisDeck.deckDesc;
        var deckType = thisDeck.deckType;

        // This is only required for mockup
        var randomht = ((Math.ceil(Math.random() * 12) + 9) * 10);
        //-------------

        var deckImage = 'http://lorempixel.com/320/' + randomht + '/'; // Replace with actual images based on deckType
        var deckStatus = checkDeck(deckId) ? "complete" : "incomplete";


        $('<article class="white-panel listing-deck" id="listing-deck-' + deckId + '"><div class="row"><div class="col-sm-12"><img src="' + deckImage + '" class="' + ((thisNode.decks.length > 2) ? "small-pincard" : "large-pincard") + '"><h4>' + deckTitle + '</h4><p>' + deckDesc + '</p></div></div><div class="row"><div class="col-sm-12"><div class="text-center popover-content-block ' + deckStatus + '-popover-content">' + deckStatus.toUpperCase() + '</div></div></div></article>').appendTo($('#modal-pinboard'));
    }

    $('#nodeModal').modal('show');

    var pinCols = (thisNode.decks.length > 2) ? 3 : thisNode.decks.length;
    if (isPortrait()) {
        pinCols = 2;
    }

    $('#modal-pinboard').pinterest_grid({
        no_columns: pinCols,
        padding_x: 10,
        padding_y: 10,
        margin_bottom: 50,
        single_column_breakpoint: 700
    });

    bindDecks(node);
}

/* Open the Decks from the Pinboard  */
function bindDecks(node) {
    $('.listing-deck').unbind('click').on('click', function () {
        var deckId = $(this).attr("id").split("-")[2];
        var thisDeck = getDeck(deckId);

        // This is the function to call if the Deck has been completed. Replace with actual call.
        completeDeck(deckId, node);

        switch (thisDeck.deckType) {
        case "powerpoint":
            $('#viewPPTModal').modal('show');
            $('.fullscreener').on('click', function () {
                toggleFull('#carousel-viewPPT-fullscreen');
            })
            break;
        case "video":
            $('#viewVideoModal').modal('show');
            break;
        case "game":
            $('#viewGameModal').modal('show');
            break;
        default:

        }

    });
}

/* =============================================================================================== */
/* Data Setter and Notification Routines */
/* =============================================================================================== */

/* Mark a Deck as complete */
function completeDeck(id, node) {
    jQuery.grep(deckStates, function (a) {
        return (a.deckId == id);
    })[0].state = true;
    refreshNodeStates();
    showPinboard(node);
    showNotification("complete", ["Arijit", id]);
}

function showNotification(name, params) {
    var note = jQuery.grep(storyConfig.notifications.items, function (a) {
        return (a.name == name);
    })[0];
    var noteTitle = note.title;
    var noteMsg = note.msg;
    if (params != undefined && params.length > 0) {
        for (i in params) {
            noteTitle = noteTitle.replace(('%' + (parseInt(i) + 1)).toString(), params[i]);
            noteMsg = noteMsg.replace(('%' + (parseInt(i) + 1)).toString(), params[i]);
        }
    }
    $('#notifications-splash').html("<div class='pull-right note-closer'>&times;</div>" + "<h1>" + noteTitle + "</h1><p>" + noteMsg + "</p>").fadeIn(function () {
        if (!isSquarer()) $(this).delay(8000).fadeOut();
    });
    $('#notifications-splash .note-closer').unbind('click').on('click', function () {
        $('#notifications-splash').hide();
    })

}

/* =============================================================================================== */
/* Parser and Helper Routines */
/* =============================================================================================== */

/* Check if the current orientation is Portrait */
function isPortrait() {
    return (window.innerHeight > window.innerWidth)
}

/* Check if the resolution is squarer */
function isSquarer() {
    return ((window.innerWidth / window.innerHeight) < (16 / 9))
}

/* Get Sequence Number of node where event happens */
function getSequence(obj) {
    return parseInt($(obj).attr("id").split("-")[2]);
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
        return (a._id == id);
    })[0];
}

/* Check if a Deck has been completed */
function checkDeck(id) {
    return true;
    //var userDataDeck = jQuery.grep(deckStates, function (a) {
    //    return (a.deckId == id);
    //})[0];
    //if (userDataDeck.state) return true;
}

/* Masonry Manager */
(function ($, window, document, undefined) {
    var pluginName = 'pinterest_grid',
        defaults = {
            padding_x: 10,
            padding_y: 10,
            no_columns: 3,
            margin_bottom: 50,
            single_column_breakpoint: 700
        },
        columns,
        $article,
        article_width;

    function Plugin(element, options) {
        this.element = element;
        this.options = $.extend({}, defaults, options);
        this._defaults = defaults;
        this._name = pluginName;
        this.init();
    }

    Plugin.prototype.init = function () {
        var self = this,
            resize_finish;

        $(window).resize(function () {
            clearTimeout(resize_finish);
            resize_finish = setTimeout(function () {
                self.make_layout_change(self);
            }, 11);
        });

        self.make_layout_change(self);

        setTimeout(function () {
            $(window).resize();
        }, 500);
    };

    Plugin.prototype.calculate = function (single_column_mode) {
        var self = this,
            tallest = 0,
            row = 0,
            $container = $(this.element),
            container_width = $container.width();
        $article = $(this.element).children();

        if (single_column_mode === true) {
            article_width = $container.width() - self.options.padding_x;
        } else {
            article_width = ($container.width() - self.options.padding_x * self.options.no_columns) / self.options.no_columns;
        }

        $article.each(function () {
            $(this).css('width', article_width);
        });

        columns = self.options.no_columns;

        $article.each(function (index) {
            var current_column,
                left_out = 0,
                top = 0,
                $this = $(this),
                prevAll = $this.prevAll(),
                tallest = 0;

            if (single_column_mode === false) {
                current_column = (index % columns);
            } else {
                current_column = 0;
            }

            for (var t = 0; t < columns; t++) {
                $this.removeClass('c' + t);
            }

            if (index % columns === 0) {
                row++;
            }

            $this.addClass('c' + current_column);
            $this.addClass('r' + row);

            prevAll.each(function (index) {
                if ($(this).hasClass('c' + current_column)) {
                    top += $(this).outerHeight() + self.options.padding_y;
                }
            });

            if (single_column_mode === true) {
                left_out = 0;
            } else {
                left_out = (index % columns) * (article_width + self.options.padding_x);
            }

            $this.css({
                'left': left_out,
                'top': top
            });
        });

        this.tallest($container);
        $(window).resize();
    };

    Plugin.prototype.tallest = function (_container) {
        var column_heights = [],
            largest = 0;

        for (var z = 0; z < columns; z++) {
            var temp_height = 0;
            _container.find('.c' + z).each(function () {
                temp_height += $(this).outerHeight();
            });
            column_heights[z] = temp_height;
        }

        largest = Math.max.apply(Math, column_heights);
        _container.css('height', largest + (this.options.padding_y + this.options.margin_bottom));
    };

    Plugin.prototype.make_layout_change = function (_self) {
        if ($(window).width() < _self.options.single_column_breakpoint) {
            _self.calculate(true);
        } else {
            _self.calculate(false);
        }
    };

    $.fn[pluginName] = function (options) {
        return this.each(function () {
            if (!$.data(this, 'plugin_' + pluginName)) {
                $.data(this, 'plugin_' + pluginName,
                    new Plugin(this, options));
            }
        });
    }

})(jQuery, window, document);

/* =============================================================================================== */
/* Full Screen Window Routines */
/* =============================================================================================== */

function cancelFullScreen(elm) {
    $(elm).hide();
    var el = document;

    var requestMethod = el.cancelFullScreen || el.webkitCancelFullScreen || el.mozCancelFullScreen || el.exitFullscreen;
    if (requestMethod) { // cancel full screen.
        requestMethod.call(el);
    } else if (typeof window.ActiveXObject !== "undefined") { // Older IE.
        var wscript = new ActiveXObject("WScript.Shell");
        if (wscript !== null) {
            wscript.SendKeys("{F11}");
        }
    }

    $('.modal-backdrop').show();
    $('.main-story-content').show();
    $('#viewPPTModal').focus();
}

function requestFullScreen(elm) {

    $('.modal-backdrop').hide();
    $('.main-story-content').hide();
    $(elm).fadeIn();

    var el = document.body; // Make the body go full screen.

    // Supports most browsers and their versions.
    var requestMethod = el.requestFullScreen || el.webkitRequestFullScreen || el.mozRequestFullScreen || el.msRequestFullscreen;

    if (requestMethod) { // Native full screen.
        requestMethod.call(el);
    } else if (typeof window.ActiveXObject !== "undefined") { // Older IE.
        var wscript = new ActiveXObject("WScript.Shell");
        if (wscript !== null) {
            wscript.SendKeys("{F11}");
        }
    }
    return false
}

function toggleFull(elm) {

    $(document).on('keyup.cancelFullScreenMode', function (e) {
        if (e.keyCode == 27) {
            cancelFullScreen(elm);
            $(document).unbind('keyup.cancelFullScreenMode');
        }
    });

    var isInFullScreen = (document.fullScreenElement && document.fullScreenElement !== null) || (document.mozFullScreen || document.webkitIsFullScreen);

    if (isInFullScreen) {
        cancelFullScreen(elm);
    } else {
        requestFullScreen(elm);
    }
    return false;


}

window.initPage = initPage;