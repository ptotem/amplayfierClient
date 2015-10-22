var gameMaster = false;

// This is true if the calculations are discrete like in the case of Kurukshetra
var additiveScores = false;



function setAppConfiguration(gameName){
    var quodecks = platforms.findOne().quodecks
    var appConfiguration = [];
    if(gameName !== "Kurukshetra"){
        appConfiguration = [
            {
                "leaderboard": "Market Share (%)", //Market Share
                "initScore": "15",
                "quoConfig": [
                    {
                        "quoid": quodecks[0],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["0.1"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[0]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[1],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-0.2"]},
                            {"score": "2", "value": ["0.1"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[1]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[2],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["0.3"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[2]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[3],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0.3"]},
                            {"score": "2", "value": ["0.3"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[3]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[4],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0.2"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[4]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[5],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-0.3"]},
                            {"score": "2", "value": ["-0.1"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[5]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[6],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-0.3"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[6]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[7],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-0.3"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[7]+"-0"}
                        ],
                        "gameMaster": []
                    }
                ]
            },
            {
                "leaderboard": "Brand Penetration (%)", //Brand Penetration
                "initScore": "30",
                "quoConfig": [
                    {
                        "quoid": quodecks[0],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["3","1","0","-1"]},
                            {"score": "2", "value": ["0.4","1","2","2"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[0]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[1],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["1"]},
                            {"score": "2", "value": ["0.4"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[0]+"-1::"+quodecks[1]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[2],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0", "0"]},
                            {"score": "2", "value": ["0.2","-0.5"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[0]+"-2::"+quodecks[2]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[3],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["1"]},
                            {"score": "2", "value": ["1"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[0]+"-3::"+quodecks[2]+"-1::"+quodecks[3]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[4],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[4]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[5],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["0.5"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[5]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[6],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-0.5"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[6]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[7],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-1"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[7]+"-0"}
                        ],
                        "gameMaster": []
                    }
                ]
            },
            {
                "leaderboard": "Brand Equity Score (Index)", //Brand Equity Score
                "initScore": "37",
                "quoConfig": [
                    {
                        "quoid": quodecks[0],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["1"]},
                            {"score": "2", "value": ["2"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[0]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[1],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-1"]},
                            {"score": "2", "value": ["-1"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[1]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[2],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["-1"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[2]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[3],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["1"]},
                            {"score": "2", "value": ["1"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[3]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[4],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["1"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[4]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[5],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[5]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[6],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-1"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[6]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[7],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[7]+"-0"}
                        ],
                        "gameMaster": []
                    }
                ]
            },
            {
                "leaderboard": "Topline (Rs. Cr.)", //Topline Growth
                "initScore": "100",
                "quoConfig": [
                    {
                        "quoid": quodecks[0],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["1.08","1.02","1.01","1"]},
                            {"score": "2", "value": ["1.10","1.01","1.01","1.01"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "multCompound", "multiplier": quodecks[0]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[1],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["1.01"]},
                            {"score": "2", "value": ["1"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "multCompound", "multiplier": quodecks[0]+"-1::"+quodecks[1]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[2],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["1","1"]},
                            {"score": "2", "value": ["1.03","0.97"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "multCompound", "multiplier": quodecks[0]+"-2::"+quodecks[2]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[3],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["1.03","1.02","1.01"]},
                            {"score": "2", "value": ["1.06","1.05","1.03"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "multCompound", "multiplier": quodecks[0]+"-3::"+quodecks[2]+"-1:"+quodecks[3]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[4],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["1.02"]},
                            {"score": "2", "value": ["1"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "multCompound", "multiplier": quodecks[3]+"-1::"+quodecks[4]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[5],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["1.02","0.99","0.99"]},
                            {"score": "2", "value": ["1","1.005","1.01"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "multCompound", "multiplier": quodecks[3]+"-2::"+quodecks[5]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[6],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0.97"]},
                            {"score": "2", "value": ["0.99"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "multCompound", "multiplier": quodecks[5]+"-1::"+quodecks[6]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[7],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0.97"]},
                            {"score": "2", "value": ["1.002"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "multCompound", "multiplier": quodecks[5]+"-2::"+quodecks[7]+"-0"}
                        ],
                        "gameMaster": []
                    }
                ]
            },
            {
                "leaderboard": "Gross Margin (%)", //Gross Margin
                "initScore": "40",
                "quoConfig": [
                    {
                        "quoid": quodecks[0],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-8","0","0","0"]},
                            {"score": "2", "value": ["0","-0.2","-0.2","-0.2"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[0]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[1],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[0]+"-1::"+quodecks[1]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[2],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["0.5"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[0]+"-2::"+quodecks[2]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[3],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-0.3"]},
                            {"score": "2", "value": ["-0.3"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[0]+"-3::"+quodecks[3]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[4],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0.3"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[4]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[5],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-1","-0.5"]},
                            {"score": "2", "value": ["0","0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[5]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[6],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[5]+"-1::"+quodecks[6]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[7],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["1"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[7]+"-0"}
                        ],
                        "gameMaster": []
                    }
                ]
            },
            {
                "leaderboard": "A&P (%)", //A&P
                "initScore": "12",
                "quoConfig": [
                    {
                        "quoid": quodecks[0],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-4"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[0]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[1],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["1"]},
                            {"score": "2", "value": ["1"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[1]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[2],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["1"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[2]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[3],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[3]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[4],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["1"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[4]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[5],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["-0.5"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[5]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[6],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[6]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[7],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[7]+"-0"}
                        ],
                        "gameMaster": []
                    }
                ]
            },
            {
                "leaderboard": "Net Margin (%)", //Net Margin
                "initScore": "28",
                "quoConfig": [
                    {
                        "quoid": quodecks[0],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-4"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[0]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[1],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-1"]},
                            {"score": "2", "value": ["-1"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[1]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[2],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["-0.5"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[2]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[3],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-0.3"]},
                            {"score": "2", "value": ["-0.3"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[3]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[4],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-0.7"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[4]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[5],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["-1","-0.5"]},
                            {"score": "2", "value": ["-0.5", "0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[5]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[6],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["0"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[5]+"-1::"+quodecks[6]+"-0"}
                        ],
                        "gameMaster": []
                    },
                    {
                        "quoid": quodecks[7],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["1"]},
                            {"score": "2", "value": ["0"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal, and, or, not
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "", "value": "addSimple", "multiplier": quodecks[7]+"-0"}
                        ],
                        "gameMaster": []
                    }
                ]
            }

        ];
    }else{
        quodecks = quodecks.splice(1,6)
        appConfiguration = [
            {
                "leaderboard": "Revenue",
                "initScore": "0",
                "quoConfig": [
                    {
                        "quoid": quodecks[0],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["100", "50", "50", "0"]},
                            {"score": "2", "value": ["100", "50", "25", "25"]},
                            {"score": "3", "value": ["75", "50", "50", "25"]},
                            {"score": "4", "value": ["50", "50", "50", "50"]}
                        ],
                        "criteria": [
                            // Inputvars should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
                            {"sequence": 1, "name": "C1", "inputvars": [0], "logic": "minTotal", "args": "350"},
                            {"sequence": 2, "name": "C2", "inputvars": [1], "logic": "minTotal", "args": "250"},
                            {"sequence": 3, "name": "C3", "inputvars": [2], "logic": "minTotal", "args": "150"},
                            {"sequence": 4, "name": "C4", "inputvars": [3], "logic": "minTotal", "args": "50"},
                            {"sequence": 5, "name": "C5", "inputvars": [], "logic": "and", "args": ["C1", "C2", "C3", "C4"]},
                            {"sequence": 6, "name": "C6", "inputvars": [], "logic": "not", "args": "C5"}
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "C1", "value": "asIs", "multiplier": "1"},
                            {"inputvar": 1, "criteria": "C2", "value": "asIs", "multiplier": "1"},
                            {"inputvar": 2, "criteria": "C3", "value": "asIs", "multiplier": "1"},
                            {"inputvar": 3, "criteria": "C4", "value": "asIs", "multiplier": "1"}
                        ],
                        "gameMaster": [
                            // Game Master Payoff defined the same way as payoff
                            {"inputvar": 0, "criteria": "C6", "value": "150", "multiplier": "1"}
                        ]
                    },
                    {
                        "quoid": quodecks[1],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["100", "75", "0", "0"]},
                            {"score": "2", "value": ["75", "75", "25", "0"]},
                            {"score": "3", "value": ["75", "50", "50", "0"]},
                            {"score": "4", "value": ["25", "50", "50", "50"]}
                        ],
                        "criteria": [
                            // Variables should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
                            {"sequence": 1, "name": "C1", "inputvars": [0], "logic": "minTotal", "args": "350"},
                            {"sequence": 2, "name": "C2", "inputvars": [1], "logic": "minTotal", "args": "250"},
                            {"sequence": 3, "name": "C3", "inputvars": [2], "logic": "minTotal", "args": "150"},
                            {"sequence": 4, "name": "C4", "inputvars": [3], "logic": "minTotal", "args": "50"},
                            {"sequence": 5, "name": "C5", "inputvars": [], "logic": "and", "args": ["C1", "C2", "C3", "C4"]},
                            {"sequence": 6, "name": "C6", "inputvars": [], "logic": "not", "args": "C5"}
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "C1", "value": "asIs", "multiplier": "1"},
                            {"inputvar": 1, "criteria": "C2", "value": "asIs", "multiplier": "1"},
                            {"inputvar": 2, "criteria": "C3", "value": "asIs", "multiplier": "1"},
                            {"inputvar": 3, "criteria": "C4", "value": "asIs", "multiplier": "1"}
                        ],
                        "gameMaster": [
                            // Game Master Payoff defined the same way as payoff
                            {"inputvar": 0, "criteria": "C6", "value": "150", "multiplier": "1"}
                        ]
                    },
                    {
                        "quoid": quodecks[2],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["100", "75", "0", "0"]},
                            {"score": "2", "value": ["75", "75", "25", "0"]},
                            {"score": "3", "value": ["75", "50", "50", "0"]},
                            {"score": "4", "value": ["25", "50", "50", "50"]}
                        ],
                        "criteria": [
                            // Variables should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
                            {"sequence": 1, "name": "C1", "inputvars": [0], "logic": "minTotal", "args": "350"},
                            {"sequence": 2, "name": "C2", "inputvars": [1], "logic": "minTotal", "args": "250"},
                            {"sequence": 3, "name": "C3", "inputvars": [2], "logic": "minTotal", "args": "150"},
                            {"sequence": 4, "name": "C4", "inputvars": [3], "logic": "minTotal", "args": "50"},
                            {"sequence": 5, "name": "C5", "inputvars": [], "logic": "and", "args": ["C1", "C2", "C3", "C4"]},
                            {"sequence": 6, "name": "C6", "inputvars": [], "logic": "not", "args": "C5"}
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "C1", "value": "asIs", "multiplier": "1"},
                            {"inputvar": 1, "criteria": "C2", "value": "asIs", "multiplier": "1"},
                            {"inputvar": 2, "criteria": "C3", "value": "asIs", "multiplier": "1"},
                            {"inputvar": 3, "criteria": "C4", "value": "asIs", "multiplier": "1"}
                        ],
                        "gameMaster": [
                            // Game Master Payoff defined the same way as payoff
                            {"inputvar": 0, "criteria": "C6", "value": "150", "multiplier": "1"}
                        ]
                    },
                    {
                        "quoid": quodecks[3],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["Arjun", "Shikhandi", "0"]},
                            {"score": "2", "value": ["Arjun", "", "50"]},
                            {"score": "3", "value": ["", "Shikhandi", "100"]},
                            {"score": "4", "value": ["", "", "200"]}
                        ],
                        "criteria": [
                            // Variables should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
                            {"sequence": 1, "name": "C1", "inputvars": [2], "logic": "minTotal", "args": "350"},
                            {
                                "sequence": 2,
                                "name": "C2",
                                "inputvars": [0, 1],
                                "logic": "unionAnd",
                                "args": ["Arjun", "Shikhandi"]
                            },
                            {"sequence": 3, "name": "C3", "inputvars": [], "logic": "and", "args": ["C1", "C2"]},
                            {"sequence": 4, "name": "C4", "inputvars": [], "logic": "not", "args": "C3"}
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 2, "criteria": "C1", "value": "asIs", "multiplier": "1"},
                            {"inputvar": 0, "criteria": "C3", "value": "250", "multiplier": "1"},
                            {"inputvar": 1, "criteria": "C3", "value": "150", "multiplier": "1"}
                        ],
                        "gameMaster": [
                            // Game Master Payoff defined the same way as payoff
                            {"inputvar": 0, "criteria": "C4", "value": "250", "multiplier": "1"}
                        ]
                    },
                    {
                        "quoid": quodecks[4],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["Yudishthir", "Arjun", "0"]},
                            {"score": "2", "value": ["Yudishthir", "", "100"]},
                            {"score": "3", "value": ["", "Arjun", "200"]},
                            {"score": "4", "value": ["", "", "300"]}
                        ],
                        "criteria": [
                            // Variables should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
                            {
                                "sequence": 1,
                                "name": "C1",
                                "inputvars": [0, 1],
                                "logic": "unionAnd",
                                "args": ["Yudishthir", "Arjun"]
                            },
                            {"sequence": 2, "name": "C2", "inputvars": [], "logic": "not", "args": "C1"}
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "C1", "value": "100", "multiplier": "1"},
                            {"inputvar": 1, "criteria": "C1", "value": "50", "multiplier": "1"},
                            {"inputvar": 2, "criteria": "C1", "value": "asIs", "multiplier": "1"}
                        ],
                        "gameMaster": [
                            // Game Master Payoff defined the same way as payoff
                            {"inputvar": 0, "criteria": "C2", "value": "250", "multiplier": "1"}
                        ]
                    },
                    {
                        "quoid": quodecks[5],
                        "mapping": [
                            // Reflect the range of scores which can come back from the Quo and the corresponding values
                            {"score": "1", "value": ["", "", "0"]},
                            {"score": "2", "value": ["Bheem", "", "150"]},
                            {"score": "3", "value": ["", "Break", "300"]},
                            {"score": "4", "value": ["", "", "500"]}
                        ],
                        "criteria": [
                            // Variables should be the index of the columns in the mapping values
                            // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
                            {"sequence": 1, "name": "C1", "inputvars": [0, 1], "logic": "unionAnd", "args": ["Bheem", "Break"]},
                            {"sequence": 2, "name": "C2", "inputvars": [2], "logic": "not", "args": "C1"}
                        ],
                        "payoff": [
                            // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                            {"inputvar": 0, "criteria": "C1", "value": "250", "multiplier": "1"},
                            {"inputvar": 2, "criteria": "C1", "value": "asIs", "multiplier": "1"},
                            {"inputvar": 2, "criteria": "C2", "value": "asIs", "multiplier": "-1"}
                        ],
                        "gameMaster": [
                            // Game Master Payoff defined the same way as payoff
                            {"inputvar": 0, "criteria": "C2", "value": "500", "multiplier": "1"}
                        ]
                    }
                ]
            }
        ];
    }
    return appConfiguration
}

window.setAppConfiguration = setAppConfiguration;

function generateLeaderboardConfig(userList, gameName){
    var leaderboards = [];
    if(gameName !== "Kurukshetra"){
        leaderboards = [
                            {name: "Topline (Rs. Cr.)",baseSCore: "100"},
                            {name: "Market Share (%)",baseSCore: "15"},
                            {name: "Brand Penetration (%)",baseSCore: "30"},
                            {name: "Brand Equity Score (Index)",baseSCore: "37"},
                            {name: "Gross Margin (%)",baseSCore: "40"},
                            {name: "A&P (%)",baseSCore: "12"},
                            {name: "Net Margin (%)",baseSCore: "28"},
                        ];
    }else{
        leaderboards = [
                            {name: "Revenue",baseSCore: "0"}
                       ];
    }

    leaderboardJSON = [];
    for(var i =0;i<leaderboards.length;i++){
        var lj = {};
        lj.name = leaderboards[i].name;
        lj.schema = [];
        if(gameName === "Kurukshetra"){
            lj.criterias = []
        }
        lj.data = []
        for(var j=0;j<userList.length;j++){
            if(gameName === "Kurukshetra"){
                lj.data.push({userid: userList[j], totalScore: leaderboards[i].baseSCore, quoScores: [], selectedAnswers: [], criterias: []})
            }else{
                lj.data.push({userid: userList[j], totalScore: leaderboards[i].baseSCore, quoScores: []})
            }
        }
        if(gameName === "Kurukshetra"){
            lj.data.push({"userid": "gameMaster", "totalScore": "0", "quoScores": []})
        }
        leaderboardJSON.push(lj)
    }

    return leaderboardJSON;
}
window.generateLeaderboardConfig = generateLeaderboardConfig;


function getGameParams(gameName){
    var leaderboards;
    if(gameName !== "Kurukshetra"){
        leaderboards = [
                            {name: "Topline (Rs. Cr.)",baseSCore: "100"},
                            {name: "Market Share (%)",baseSCore: "15"},
                            {name: "Brand Penetration (%)",baseSCore: "30"},
                            {name: "Brand Equity Score (Index)",baseSCore: "37"},
                            {name: "Gross Margin (%)",baseSCore: "40"},
                            {name: "A&P (%)",baseSCore: "12"},
                            {name: "Net Margin (%)",baseSCore: "28"},
                        ];
    }else{
        leaderboards = [
                            {name: "Revenue",baseSCore: "0"}
                       ];
    }    
    return leaderboards;
}
window.getGameParams = getGameParams;