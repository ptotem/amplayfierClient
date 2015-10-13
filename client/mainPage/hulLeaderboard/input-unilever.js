var inputJSON = [
    {
        "quoid": "Q1",
        "scores": [
            {"userid": "1", "score": "1"},
            {"userid": "2", "score": "2"},
            {"userid": "3", "score": "1"}
        ]
    },
    {
        "quoid": "Q2",
        "scores": [
            {"userid": "1", "score": "2"},
            {"userid": "2", "score": "1"},
            {"userid": "3", "score": "1"}
        ]
    },
    {
        "quoid": "Q3",
        "scores": [
            {"userid": "1", "score": "2"},
            {"userid": "2", "score": "2"},
            {"userid": "3", "score": "2"}
        ]
    },
    {
        "quoid": "Q4",
        "scores": [
            {"userid": "1", "score": "2"},
            {"userid": "2", "score": "2"},
            {"userid": "3", "score": "2"}
        ]
    },
    {
        "quoid": "Q5",
        "scores": [
            {"userid": "1", "score": "2"},
            {"userid": "2", "score": "2"},
            {"userid": "3", "score": "2"}
        ]
    },
    {
        "quoid": "Q6",
        "scores": [
            {"userid": "1", "score": "2"},
            {"userid": "2", "score": "2"},
            {"userid": "3", "score": "2"}
        ]
    },
    {
        "quoid": "Q7",
        "scores": [
            {"userid": "1", "score": "2"},
            {"userid": "2", "score": "2"},
            {"userid": "3", "score": "2"}
        ]
    },
    {
        "quoid": "Q8",
        "scores": [
            {"userid": "1", "score": "2"},
            {"userid": "2", "score": "2"},
            {"userid": "3", "score": "2"}
        ]
    }
];



var leaderboardJSON = [
// Initialize the leaderboards from the config file. Initial total score = initScore.
    {
        "name": "L1",
        "schema": [],
        "data": [
            {"userid": "1", "totalScore": "100", "quoScores": []},
            {"userid": "2", "totalScore": "100", "quoScores": []},
            {"userid": "3", "totalScore": "100", "quoScores": []}
        ]
    },
    {
        "name": "L2",
        "schema": [],
        "data": [
            {"userid": "1", "totalScore": "40", "quoScores": []},
            {"userid": "2", "totalScore": "40", "quoScores": []},
            {"userid": "3", "totalScore": "40", "quoScores": []}
        ]
    },
    {
        "name": "L3",
        "schema": [],
        "data": [
            {"userid": "1", "totalScore": "0.34", "quoScores": []},
            {"userid": "2", "totalScore": "0.34", "quoScores": []},
            {"userid": "3", "totalScore": "0.34", "quoScores": []}
        ]
    },
    {
        "name": "L4",
        "schema": [],
        "data": [
            {"userid": "1", "totalScore": "0.34", "quoScores": []},
            {"userid": "2", "totalScore": "0.34", "quoScores": []},
            {"userid": "3", "totalScore": "0.34", "quoScores": []}
        ]
    },
    {
        "name": "L5",
        "schema": [],
        "data": [
            {"userid": "1", "totalScore": "0.34", "quoScores": []},
            {"userid": "2", "totalScore": "0.34", "quoScores": []},
            {"userid": "3", "totalScore": "0.34", "quoScores": []}
        ]
    },
    {
        "name": "L6",
        "schema": [],
        "data": [
            {"userid": "1", "totalScore": "0.34", "quoScores": []},
            {"userid": "2", "totalScore": "0.34", "quoScores": []},
            {"userid": "3", "totalScore": "0.34", "quoScores": []}
        ]
    },
    {
        "name": "L7",
        "schema": [],
        "data": [
            {"userid": "1", "totalScore": "0.34", "quoScores": []},
            {"userid": "2", "totalScore": "0.34", "quoScores": []},
            {"userid": "3", "totalScore": "0.34", "quoScores": []}
        ]
    }
]

function generateLeaderboardConfig(userList){
    var leaderboards = [
                            {name: "Market Share",baseSCore: "15"},
                            {name: "Brand Penetration",baseSCore: "30"},
                            {name: "Brand Equity Score",baseSCore: "37"},
                            {name: "Topline Growth",baseSCore: "100"},
                            {name: "Gross Margin",baseSCore: "40"},
                            {name: "A&P",baseSCore: "12"},
                            {name: "Net Margin",baseSCore: "28"},

                        ];
    leaderboardJSON = [];
    for(var i =0;i<leaderboards.length;i++){
        var lj = {};
        lj.name = leaderboards[i].name;
        lj.schema = [];
        lj.data = []
        for(var j=0;j<userList.length;j++){
            lj.data.push({userid: userList[j], totalScore: leaderboards[i].baseSCore, quoScores: []})
        }
        leaderboardJSON.push(lj)
    }
    return leaderboardJSON;
}
window.generateLeaderboardConfig = generateLeaderboardConfig;