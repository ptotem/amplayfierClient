var config = {};

//----------------------------------------------------
// Set Game Config
//----------------------------------------------------
var loadInitConfig = function(){
    config.maxTime=getIntNew(getText("mcq-text-max-time"));
    config.trueImg='true.png';
    config.falseImg='false.png';
    config.timed= getBoolean(getText("mcq-text-timer"));
    config.replayable= getBoolean(getText("mcq-text-replayable"));
    config.questionCount=getInt(getText("mcq-text-question-count"));

    config.mainPage = {
        type: "environment",
        states: [
            {
                name: "default",
                representation: "<img src='"+getImg("mcq-background")+"'/>"
            }
        ],
        locations: [
            {name: "gameheader", states: [
                {name: "default", representation: getText("mcq-text-name")}
            ]
            },        
            {name: "result", states: [
                {name: "correct", representation: "<img src='"+getImg("mcq-correct")+"'/>"},
                {name: "incorrect", representation: "<img src='"+getImg("mcq-incorrect")+"'/>"},
                {name: "timeup", representation: "<img src='"+getImg("mcq-time-up")+"'/>"},
                {name: "default", representation: ""},
            ]
            },
            {name: "score", states: [
                {name: "final", representation: getText("mcq-text-you-scored")+ " <br/><span id='scoreBlock'></span>%"},
                {name: "default", representation: ""}
            ]
            },
            {name: "timer", states: [
                {name: "default", representation: ""}
            ]
            },
            {name: "replay", states: [
                {name: "active", representation: "<a href='#' onclick='initGame()'><img src='"+getImg("mcq-play-again")+"'/></a>"},
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
}