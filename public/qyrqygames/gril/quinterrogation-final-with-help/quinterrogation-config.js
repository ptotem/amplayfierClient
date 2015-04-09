var config = {};

config.base = {
    type: "environment",
    states: [
        {name: "default", representation: "<img src=''/>"}
    ],
    locations: [
        {name: "qt-bot-overlay", states: [
            {name: "qt-bot-overlay-img", representation: "<img class='qt-bot-overlay-img' src='' />"}
        ]},
        {name: "help", states: [
            {name: "default", representation: "<img /><span>Help</span>"}
        ]}
    ]
}
config.meterBar = {
    type: "environment",
    states: [
        {name: "default", representation: ""}
    ],
    locations: [
        {name: "qt-meter-empty"},
        {name: "limit"},
        {name: "qt-meter-filled"},
        {name: "qt-meter-indicator", states: [
            {name: "qt-meter-indicator-text", representation: "<span></span>"}
        ]}
    ]
};


config.meterOverlay = {
    type: "environment",
    states: [
        {name: "default"}
    ],
    locations: [
        {name: "qt-meter-overlay"}
    ]
}

config.player = {
    type: "entity",
    states: [
        {name: "default", representation: "<img id='qt-player-img' src='' />"}
    ]
};

config.ai = {
    type: "entity",
    states: [
        {name: "default", representation: "<img id='qt-ai-img' src='' />"}
    ]
};

config.howtoData = [
    {loc: "qt-player-img", description: "<span>This is 'You', the Interrogator.</span>", sequence: 0},
    {loc: "qt-ai-img", description: "<span>This is your 'Opponent', whom you are Interrogating.</span>", sequence: 1},
    {loc: "statement-area", description: "<span>This is what your 'Opponent' says.</span>", sequence: 2},
    {loc: "options-area", description: "<span>These are the statements you can make.</span>", sequence: 3},
    {loc: "rightOpt", description: "<span>This helps you navigate through your statements.</span>", sequence: 4},
    {loc: "qt-say-button", description: "<span>This button 'says' the displayed message.</span>", sequence: 5},
    {loc: "meterBar", description: "<span>This bar shows your 'Opponent's' "+getText("qt-text-meter")+".</span>", sequence: 6},
    {loc: "qt-know-more", description: "<span>This provides you information about the shown 'Opponent's' statement.</span>", sequence: 7}
]