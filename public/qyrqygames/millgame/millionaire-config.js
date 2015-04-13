var config = {};
config.base = {
    type: "environment",
    states: [
        {name: "default", representation: "<img id='kbc-back' src='" + getImg("kbc-background") + "'/>"}
    ],
    locations: [
        {name: "logo", sequence: 0, states: [
            {name: "default", representation: "<img src='" + getImg("kbc-logo") + "' />"}
        ]},
        {name: "help", states: [
            {name: "default", representation: "<img /><span>Help</span>"}
        ]}
    ]
};

config.qholder = {
    type: "environment",
    states: [
        {name: "default", representation: ""}
    ],
    locations: [
        {name: "character", sequence: 0, states: [
            {name: "default", representation: "<img src='"+getImg("kbc-character")+"' />"}
        ]}
    ]
};


config.messagebox = {
    type: "environment",
    states: [
        {name: "startpage", representation:
            "<div id='game-back'><img src='"+getImg("kbc-background")+"' /></div>" +
            "<div id='game-logo'><img src='"+getImg("kbc-logo")+"' /></div>" +
            "<div id='startgame' class='startpage-button'>" +
                "<img src='"+getImg("kbc-button-start")+"' />" +
                "<span>Start</span>" +
            "</div>" +
            "<div id='showinst' class='startpage-button'>" +
                "<img src='"+getImg("kbc-button-instruction")+"' />" +
                "<span>Instructions</span>" +
            "</div>"},

        {name: "instruction", representation:
            '<div id="game-back"><img src='+getImg("kbc-background")+' /></div>' +
                '<div id="game-logo-inst"><img src='+getImg("kbc-logo")+' /></div>' +
                '<div id="instructions">' +
                    '<div id="inst-header"><span>'+getText("kbc-text-instruction-header")+'</span></div>' +
                    '<div id="inst-content" >' +
                        '<span class="content mCustomScrollbar">' + getText("kbc-text-instructions") + '</span>' +
                    '</div>' +
                '</div>' +
                '<div id="startgame-inst" class="startpage-button">' +
                    '<img src="'+getImg("kbc-button-start")+'" />' +
                    '<span>Start</span>' +
                '</div>'},

        {name: "endgame", representation:
            "<div id='game-back'><img src='"+getImg("kbc-background")+"' /></div>" +
            "<div id='endmessage'></div>" +
            "<div id='playagain' class='startpage-button'>" +
                "<img src='"+getImg("kbc-button-play-again")+"' />" +
                "<span>Play Again</span>" +
            "</div>"},
        {name: "default", representation: "<img src='"+getImg("kbc-background")+"' />"}
    ],
    locations: [
    ]
};

config.ladder = {
    type: "environment",
    states: [
        {name: "default", representation: ""}
    ],
    locations: [
        {name: "ladder10", sequence: 9, states: [
            {name: "complete", representation: "<span class='completed'>" + getText("kbc-text-ladder10") + "</span>"},
            {name: "default", representation: "<span>" + getText("kbc-text-ladder10") + "</span>"}

        ]},
        {name: "ladder9", sequence: 8, states: [
            {name: "complete", representation: "<span class='completed'>" + getText("kbc-text-ladder09") + "</span>"},
            {name: "default", representation: "<span>" + getText("kbc-text-ladder09") + "</span>"}
        ]},
        {name: "ladder8", sequence: 7, states: [
            {name: "complete", representation: "<span class='completed'>" + getText("kbc-text-ladder08") + "</span>"},
            {name: "default", representation: "<span>" + getText("kbc-text-ladder08") + "</span>"}
        ]},
        {name: "ladder7", sequence: 6, states: [
            {name: "complete", representation: "<span class='completed'>" + getText("kbc-text-ladder07") + "</span>"},
            {name: "default", representation: "<span>" + getText("kbc-text-ladder07") + "</span>"}

        ]},
        {name: "ladder6", sequence: 5, states: [
            {name: "complete", representation: "<span class='completed'>" + getText("kbc-text-ladder06") + "</span>"},
            {name: "default", representation: "<span>" + getText("kbc-text-ladder06") + "</span>"}

        ]},
        {name: "ladder5", sequence: 4, states: [
            {name: "complete", representation: "<span class='completed'>" + getText("kbc-text-ladder05") + "</span>"},
            {name: "default", representation: "<span>" + getText("kbc-text-ladder05") + "</span>"}

        ]},
        {name: "ladder4", sequence: 3, states: [
            {name: "complete", representation: "<span class='completed'>" + getText("kbc-text-ladder04") + "</span>"},
            {name: "default", representation: "<span>" + getText("kbc-text-ladder04") + "</span>"}

        ]},
        {name: "ladder3", sequence: 2, states: [
            {name: "complete", representation: "<span class='completed'>" + getText("kbc-text-ladder03") + "</span>"},
            {name: "default", representation: "<span>" + getText("kbc-text-ladder03") + "</span>"}

        ]},
        {name: "ladder2", sequence: 1, states: [
            {name: "complete", representation: "<span class='completed'>" + getText("kbc-text-ladder02") + "</span>"},
            {name: "default", representation: "<span>" + getText("kbc-text-ladder02") + "</span>"}

        ]},
        {name: "ladder1", sequence: 0, states: [
            {name: "complete", representation: "<span class='completed'>" + getText("kbc-text-ladder01") + "</span>"},
            {name: "default", representation: "<span>" + getText("kbc-text-ladder01") + "</span>"}

        ]}
    ]
};

config.lifelinepanel = {
    type: "environment",
    states: [
//        {name: "default", representation: ""}
        {name: "lifeline3", representation: "<div id='lifeline3' class='lifeline-panel'>" +
                                                "<div id='change-text' class='lifeline-text'>" +
                                                    "<span>This lifeline changes this question for another.</span>" +
                                                "</div>" +
                                                "<div id='ok' class='button'>OK</div>" +
                                                "<div id='cancel' class='button'>Cancel</div>" +
                                            "</div>"},
        {name: "lifeline2", representation: "<div id='lifeline2' class='lifeline-panel'>" +
                                                "<div id='half-text'  class='lifeline-text'>" +
                                                    "<span>This lifeline removes two 'Wrong' answers.</span>" +
                                                "</div>" +
                                                "<div id='ok' class='button'>OK</div>" +
                                                "<div id='cancel' class='button'>Cancel</div>" +
                                            "</div>"},
        {name: "lifeline1", representation: "<div id='lifeline1' class='lifeline-panel'>" +
                                                "<div id='poll-text'  class='lifeline-text'>" +
                                                    "<span>This Lifeline shows you the Audience's opinion for this question in a graph format.</span>" +
                                                "</div>" +
                                                "<canvas id='poll-chart'></canvas>" +
                                                "<div id='ok' class='button'>OK</div>" +
                                                "<div id='cancel' class='button'>Cancel</div>" +
                                                "<div id='close' class='button'>Close</div>" +
                                            "</div>"},
        {name: "default", representation: "<div id='default'>Choose any of the Lifeline to help you win the game.</div>"}
    ],
    locations: []
};

config.lifelines = {
    type: "environment",
    states: [
        {name: "default", representation: ""}

    ],
    locations: [
        {name: "lifeline1img", sequence: 0, states: [
            {name: "complete", representation: "<img class='complete' src='" + getImg("kbc-lifeline1-img-disabled") + "'/>"},
            {name: "default", representation: "<img class='default' src='" + getImg("kbc-lifeline1-img") + "'/>"}
        ]},
        {name: "lifeline2img", sequence: 0, states: [
            {name: "complete", representation: "<img class='complete' src='" + getImg("kbc-lifeline2-img-disabled") + "'/>"},
            {name: "default", representation: "<img class='default' src='" + getImg("kbc-lifeline2-img") + "'/>"}
        ]},
        {name: "lifeline3img", sequence: 0, states: [
            {name: "complete", representation: "<img class='complete' src='" + getImg("kbc-lifeline3-img-disabled") + "'/>"},
            {name: "default", representation: "<img class='default' src='" + getImg("kbc-lifeline3-img") + "'/>"}
        ]},
        {name: "text", sequence: 0, states: [
            {name: "lifeline3", representation: "<span id='ll3'>Change Question</span>"},
            {name: "lifeline2", representation: "<span id='ll2'>50-50</span>"},
            {name: "lifeline1", representation: "<span id='ll1'>Poll</span>"},
            {name: "default", representation: ""}
        ]}


    ]
};


config.player = {
    type: "entity",
    states: [
        {name: "default", representation: "<img src='' />"}
    ]
};

config.howtoData = [
    {loc: "question", description: "<span>This is where Questions are shown.</span>", sequence: 0},
    {loc: "options", description: "<span>This is where the Options are shown. Only 1 answer out of these 4 is correct.</span>", sequence: 1},
    {loc: "knowmore", description: "<span>This provides you information about the shown Question.</span>", sequence: -1},
    {loc: "lifeline1img", description: "<span>These are your Lifelines to help you during the game. You can use them only once so use them wisely.</span>", sequence: 3},
    {loc: "ladder", description: "<span>These are the levels you need to cross to win the game.</span>", sequence: 4},
    {loc: "player", description: "<span>This is your current position.</span>", sequence: 5}
]
