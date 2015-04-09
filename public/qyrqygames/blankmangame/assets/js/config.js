var config = {};

//----------------------------------------------------
// Set Game Config
//----------------------------------------------------
var loadInitConfig = function(){
    config.maxTime= getIntNew(getText("bm-text-max-time"));
    config.trueImg='true.png';
    config.falseImg='false.png';
    config.timed= getBoolean(getText("bm-text-timer"));
    config.replayable= getBoolean(getText("bm-text-replayable"));
    config.questionCount= getInt(getText("bm-text-question-count"));

    config.mainPage = {
        type: "environment",
        states: [
            {
                name: "default",
                representation: "<img src='"+getImg("bm-background")+"'/>"
            }
        ],
        locations: [
            {name: "gameheader", states: [
                {name: "default", representation: getText("bm-text-name")}
            ]
            },        
            {name: "answerbox", states: [
                {name: "default", representation: "<input type='text'/><img id='blankmanSubmit' src='assets/img/enter.png'/>"}
            ]
            },        
            {name: "result", states: [
                {name: "correct", representation: "<img src='"+getImg("bm-correct")+"'/>"},
                {name: "incorrect", representation: "<img src='"+getImg("bm-incorrect")+"'/>"},
                {name: "timeup", representation: "<img src='"+getImg("bm-time-up")+"'/>"},
                {name: "default", representation: ""},
            ]
            },
            {name: "score", states: [
                {name: "final", representation: getText("bm-text-you-scored") +" <br/><span id='scoreBlock'></span>%"},
                {name: "default", representation: ""}
            ]
            },
            {name: "timer", states: [
                {name: "default", representation: ""}
            ]
            },
            {name: "replay", states: [
                {name: "active", representation: "<a href='#' onclick='initGame()'><img src='"+getImg("bm-play-again")+"'/></a>"},
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




