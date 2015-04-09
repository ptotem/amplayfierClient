var config = {};
config.land = {
    type: "environment",
    states: [
        {name: "default", representation: "<img src=' " + theme.background + "'/>"}
    ],
    locations: function () {
        var allLocations = [];
        for (var i = 0; i < 8; i++) {
	cityImg = getImg("gh-city"+i)
            allLocations.push({name: theme.cities[i].name.toLowerCase(), positioned: true, sequence: i, left: theme.cities[i].left, top: theme.cities[i].top, width: theme.cities[i].width, height: theme.cities[i].height, states: [
                {name: "default", representation: "<img src='"+cityImg+"'/>" + theme.cities[i].name}
            ]});
        }
        return allLocations;
    }()
};
config.city = {
    type: "environment",
    states: [
        {name: "default", representation: ""}
    ],
    locations: [
        {name: "cardblock", sequence: 0, states: [
            {name: "default", representation: "<img src='img/" + theme.cityBackground + "'/>"}
        ]},
        {name: "buttonblock", sequence: 0, states: [
            {name: "default", representation: "<div id='cityname'></div><div id='grailhunt' class='gamebtn'>Search for the " + theme.searchItem + " here for 500 " + theme.money + "</div><div id='travel' class='gamebtn'>Lose 20 " + theme.health + " to travel to another " + theme.city + "</div>"}
        ]}
    ]
};
config.overlay = {
    type: "environment",
    states: [
        {name: "default", representation: ""}
    ],
    locations: [
        {name: "grail", sequence: 0, states: [
            {name: "default", representation: "<img src='" + theme.searchItemImg + "'/>"}
        ]},
        {name: "life", sequence: 0, states: [
            {name: "default", representation: "<img src='" + theme.healthImg + "' id='lifering'/><div class='value'></div>"}
        ]},
        {name: "gold", sequence: 0, states: [
            {name: "default", representation: "<img src='" + theme.moneyImg + "' id='goldring'/><div class='value'></div>"}
        ]}
    ]

};
config.playdeck = {
    type: "entity",
    states: [
        {name: "default", representation: ""}
    ]
};
config.cards = {
    type: "entity",
    items: [
        {
            name: theme.cards.questioner[0].split("/")[1].split(".")[0],
            count: 2,
            states: [
                {name: "default", representation: "<img src='" + theme.cards.questioner[0] + "'/><br/><br/><strong style='color:darkred'>" + theme.cards.questioner[1] + "</strong><br/>Answer a question to get directions"}
            ],
            attributes: {
                question: true
            }

        },
        {
            name: theme.cards.lowHealthOutMoneyIn[0].split("/")[1].split(".")[0],
            count: 2,
            states: [
                {name: "default", representation: "<img src='" + theme.cards.lowHealthOutMoneyIn[0] + "'/><br/><br/><strong style='color:darkred'>" + theme.cards.lowHealthOutMoneyIn[1] + "</strong><br/>Lose 0 to 20 " + theme.health + " to gain 100-200 " + theme.money}
            ],
            attributes: {
                costCurrency: theme.health,
                minCost: 0,
                maxCost: 20,
                gainCurrency: theme.money,
                minGain: 100,
                maxGain: 200,
                question: false
            }

        },
        {
            name: theme.cards.highHealthOutMoneyIn[0].split("/")[1].split(".")[0],
            count: 2,
            states: [
                {name: "default", representation: "<img src='" + theme.cards.highHealthOutMoneyIn[0] + "'/><br/><br/><strong style='color:darkred'>" + theme.cards.highHealthOutMoneyIn[1] + "</strong><br/>Lose 20 to 50 " + theme.health + " to gain 100-500 " + theme.money}
            ],
            attributes: {
                costCurrency: theme.health,
                minCost: 20,
                maxCost: 50,
                gainCurrency: theme.money,
                minGain: 100,
                maxGain: 500,
                question: false
            }

        },
        {
            name: theme.cards.fixedHealthOutMoneyIn[0].split("/")[1].split(".")[0],
            count: 2,
            states: [
                {name: "default", representation: "<img src='" + theme.cards.fixedHealthOutMoneyIn[0] + "'/><br/><br/><strong style='color:darkred'>" + theme.cards.fixedHealthOutMoneyIn[1] + "</strong><br/>Lose 30 " + theme.health + " to gain 200 " + theme.money}
            ],
            attributes: {
                costCurrency: theme.health,
                minCost: 30,
                maxCost: 30,
                gainCurrency: theme.money,
                minGain: 200,
                maxGain: 200,
                question: false
            }

        },
        {
            name: theme.cards.lowMoneyOutHealthIn[0].split("/")[1].split(".")[0],
            count: 2,
            states: [
                {name: "default", representation: "<img src='" + theme.cards.lowMoneyOutHealthIn[0] + "'/><br/><br/><strong style='color:darkred'>" + theme.cards.lowMoneyOutHealthIn[1] + "</strong><br/>Lose 50 " + theme.health + " to gain 300-500 " + theme.money}
            ],
            attributes: {
                costCurrency: theme.money,
                minCost: 0,
                maxCost: 50,
                gainCurrency: theme.health,
                minGain: 0,
                maxGain: 30,
                question: false
            }

        },
        {
            name: theme.cards.highMoneyOutHealthIn[0].split("/")[1].split(".")[0],
            count: 2,
            states: [
                {name: "default", representation: "<img src='" + theme.cards.highMoneyOutHealthIn[0] + "'/><br/><br/><strong style='color:darkred'>" + theme.cards.highMoneyOutHealthIn[1] + "</strong><br/>Spend 150 " + theme.money + " to gain 100 " + theme.health}
            ],
            attributes: {
                costCurrency: theme.money,
                minCost: 100,
                maxCost: 300,
                gainCurrency: theme.health,
                minGain: 100,
                maxGain: 200,
                question: false
            }

        },
        {
            name: theme.cards.fixedMoneyOutHealthIn[0].split("/")[1].split(".")[0],
            count: 2,
            states: [
                {name: "default", representation: "<img src='" + theme.cards.fixedMoneyOutHealthIn[0] + "'/><br/><br/><strong style='color:darkred'>" + theme.cards.fixedMoneyOutHealthIn[1] + "</strong><br/>Spend 50 " + theme.money + " to gain 0-100 " + theme.health}
            ],
            attributes: {
                costCurrency: theme.money,
                minCost: 50,
                maxCost: 50,
                gainCurrency: theme.health,
                minGain: 50,
                maxGain: 100,
                question: false
            }

        },
        {
            name: theme.cards.MoneyOutMoneyIn[0].split("/")[1].split(".")[0],
            count: 2,
            states: [
                {name: "default", representation: "<img src='" + theme.cards.MoneyOutMoneyIn[0] + "'/><br/><br/><strong style='color:darkred'>" + theme.cards.MoneyOutMoneyIn[1] + "</strong><br/>Spend 100 " + theme.money + " to gain 0-500 " + theme.money}
            ],
            attributes: {
                costCurrency: theme.money,
                minCost: 100,
                maxCost: 100,
                gainCurrency: theme.money,
                minGain: 0,
                maxGain: 500,
                question: false
            }

        }
    ]
};
config.quiz = {
    type: "environment",
    states: [
        {name: "default", representation: "<img src='img/" + theme.quizBackground + "'/>"}
    ],
    locations: [
        {name: "question-image", sequence: 0, states: [
            {name: "default", representation: "<img src='img/" + theme.quizImgDefault + "'/>"}
        ]},
        {name: "statement", sequence: 0, states: [
            {name: "correct", representation: "<div id='correct-area'>That is Correct!!</div>"},
            {name: "wrong", representation: "<div id='wrong-area'>Uh-huh! Not Really!</div>"},
            {name: "default", representation: "<div id='statement-area'></div>"}
        ]},
        {name: "options", sequence: 0, states: [
            {name: "correct", representation: "<div id='grail-statement'>The " + theme.searchItem + " is in a " + theme.city + " to the <span id='grail-direction'></span> of here</div>"},
            {name: "wrong", representation: "<div id='penalty-statement'>You pay for the error with 20 " + theme.health + "</div>"},
            {name: "default", representation: ""}
        ]},
        {name: "knowmore", sequence: 0, states: [
            {name: "default", representation: "<div id='knowmore-area'>Know More</div>"}
        ]}
    ]
};
config.player = {
    type: "entity",
    states: [
        {name: "default", representation: "<img src='" + theme.player + "'/>"}
    ]
};
config.notification = {
    type: "environment",
    states: [
        {name: "default", representation: "<img src='"+theme.notificationBack+"'/><div id='notification-content'></div>"}
    ]
};
config.messages = {
    travel: "<img src='" + theme.travelImg + "'/>Select a " + theme.city + " to travel to",
    grailfail: "<img src='" + theme.grailfail + "'/>That was a waste of " + theme.money + ", my friend!",
    unaffordable: "You cannot afford it",
    grailhere: "The " + theme.searchItem + " is somewhere in this " + theme.city,
    dead: "<img src='" + theme.defeatImg + "'/>Welcome to the sweet embrace of death and defeat",
    victory: "You found the " + theme.searchItem + " and completed your quest"
};
