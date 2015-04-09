var config = {};

//----------------------------------------------------
// Set Game Config
//----------------------------------------------------

config.maxTime= getText("ft-text-max-time");
config.statementBack='statement-back.png';
config.trueImg=getImg("ft-true");
config.falseImg=getImg("ft-false");
config.timed=getText("ft-text-timer");
config.replayable=getText("ft-text-replayable");
config.questionCount=getText("ft-text-question-count");

config.mainPage = {
    type: "environment",
    states: [
        {
            name: "default",
            representation: "<img src='"+getImg("ft-background")+"'/>"
        }
    ],
    locations: [
        {name: "gameheader", states: [
            {name: "default", representation: getText("ft-text-name")}
        ]
        }, 
        {name: "result", states: [
            {name: "correct", representation: "<img src='"+getImg("ft-correct")+"'/>"},
            {name: "incorrect", representation: "<img src='"+getImg("ft-incorrect")+"'/>"},
            {name: "timeup", representation: "<img src='"+getImg("ft-time-up")+"'/>"},
            {name: "default", representation: ""},
        ]
        },
        {name: "score", states: [
            {name: "final", representation: getText("ft-text-you-scored")+" <br/><span id='scoreBlock'></span>%"},
            {name: "default", representation: ""}
        ]
        },
        {name: "timer", states: [
            {name: "default", representation: ""}
        ]
        },
        {name: "replay", states: [
            {name: "active", representation: "<a href='#' onclick='initGame()'><img src='"+getImg("ft-play-again")+"'/></a>"},
            {name: "default", representation: ""}
        ]
        }
    ]
};

config.progressBar = {
    type: "environment",
    states: [
        {
            name: "default",
            representation: ""
        }
    ],
    locations: function(){
        var locArray=[];
        for(var i=0;i<config.questionCount;i++){
            locArray.push({name: "progressBarUnit"+i, states: [
                {name: "correct", representation: "<div class='correctProgress'></div>"},
                {name: "incorrect", representation: "<div class='incorrectProgress'></div>"},
                {name: "default", representation: ""},
        ]
        })
        }
        return locArray;
    }()
};




