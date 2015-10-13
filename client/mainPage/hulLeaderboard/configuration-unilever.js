var gameMaster = false;

// This is true if the calculations are discrete like in the case of Kurukshetra
var additiveScores = false;



function setAppConfiguration(){
    var quodecks = platforms.findOne().quodecks
    var appConfiguration = [
    {
        "leaderboard": "Market Share", //Market Share
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
        "leaderboard": "Brand Penetration", //Brand Penetration
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
                    {"score": "1", "value": ["0"]},
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
        "leaderboard": "Brand Equity Score", //Brand Equity Score
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
        "leaderboard": "Topline Growth", //Topline Growth
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
        "leaderboard": "Gross Margin", //Gross Margin
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
        "leaderboard": "A&P", //A&P
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
        "leaderboard": "Net Margin", //Net Margin
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

    return appConfiguration
}

window.setAppConfiguration = setAppConfiguration;