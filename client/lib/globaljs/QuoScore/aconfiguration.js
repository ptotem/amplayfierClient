var gameMaster = true;
window.gameMaster = gameMaster;
// qDecks = platforms.findOne().quodecks
// var configuration = [
//     {
//         "quoid": qDecks[0],
//         "mapping": [
//             // Reflect the range of scores which can come back from the Quo and the corresponding values
//             {"score": "1", "value": ["75", "50", "25", "0"]},
//             {"score": "2", "value": ["75", "25", "25", "25"]},
//             {"score": "3", "value": ["50", "50", "50", "0"]},
//             {"score": "4", "value": ["50", "50", "25", "25"]}
//         ],
//         "criteria": [
//             // Inputvars should be the index of the columns in the mapping values
//             // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
//             {"sequence": 1, "name": "C1", "inputvars": [0], "logic": "minTotal", "args": "350"},
//             {"sequence": 2, "name": "C2", "inputvars": [1], "logic": "minTotal", "args": "250"},
//             {"sequence": 3, "name": "C3", "inputvars": [2], "logic": "minTotal", "args": "150"},
//             {"sequence": 4, "name": "C4", "inputvars": [3], "logic": "minTotal", "args": "50"},
//             {"sequence": 5, "name": "C5", "inputvars": [], "logic": "and", "args": ["C1", "C2", "C3", "C4"]},
//             {"sequence": 6, "name": "C6", "inputvars": [], "logic": "not", "args": "C5"}
//         ],
//         "payoff": [
//             // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
//             {"inputvar": 0, "criteria": "C1", "value": "asIs", "multiplier": "1"},
//             {"inputvar": 1, "criteria": "C2", "value": "asIs", "multiplier": "1"},
//             {"inputvar": 2, "criteria": "C3", "value": "asIs", "multiplier": "1"},
//             {"inputvar": 3, "criteria": "C4", "value": "asIs", "multiplier": "1"}
//         ],
//         "gameMaster": [
//             // Game Master Payoff defined the same way as payoff
//             {"inputvar": 0, "criteria": "C6", "value": "150", "multiplier": "1"}
//         ]
//     },
//     {
//         "quoid": qDecks[1],
//         "mapping": [
//             // Reflect the range of scores which can come back from the Quo and the corresponding values
//             {"score": "1", "value": ["75", "50", "0", "0"]},
//             {"score": "2", "value": ["75", "25", "25", "0"]},
//             {"score": "3", "value": ["50", "50", "0", "25"]},
//             {"score": "4", "value": ["25", "50", "25", "25"]}
//         ],
//         "criteria": [
//             // Variables should be the index of the columns in the mapping values
//             // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
//             {"sequence": 1, "name": "C1", "inputvars": [0], "logic": "minTotal", "args": "350"},
//             {"sequence": 2, "name": "C2", "inputvars": [1], "logic": "minTotal", "args": "250"},
//             {"sequence": 3, "name": "C3", "inputvars": [2], "logic": "minTotal", "args": "150"},
//             {"sequence": 4, "name": "C4", "inputvars": [3], "logic": "minTotal", "args": "100"},
//             {"sequence": 5, "name": "C5", "inputvars": [], "logic": "and", "args": ["C1", "C2", "C3", "C4"]},
//             {"sequence": 6, "name": "C6", "inputvars": [], "logic": "not", "args": "C5"}
//         ],
//         "payoff": [
//             // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
//             {"inputvar": 0, "criteria": "C1", "value": "asIs", "multiplier": "1"},
//             {"inputvar": 1, "criteria": "C2", "value": "asIs", "multiplier": "1"},
//             {"inputvar": 2, "criteria": "C3", "value": "asIs", "multiplier": "1"},
//             {"inputvar": 3, "criteria": "C4", "value": "asIs", "multiplier": "1"}
//         ],
//         "gameMaster": [
//             // Game Master Payoff defined the same way as payoff
//             {"inputvar": 0, "criteria": "C6", "value": "150", "multiplier": "1"}
//         ]
//     },
//     {
//         "quoid": qDecks[2],
//         "mapping": [
//             // Reflect the range of scores which can come back from the Quo and the corresponding values
//             {"score": "1", "value": ["75", "50", "0", "0"]},
//             {"score": "2", "value": ["75", "25", "25", "0"]},
//             {"score": "3", "value": ["50", "50", "0", "25"]},
//             {"score": "4", "value": ["25", "50", "25", "25"]}
//         ],
//         "criteria": [
//             // Variables should be the index of the columns in the mapping values
//             // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
//             {"sequence": 1, "name": "C1", "inputvars": [0], "logic": "minTotal", "args": "350"},
//             {"sequence": 2, "name": "C2", "inputvars": [1], "logic": "minTotal", "args": "250"},
//             {"sequence": 3, "name": "C3", "inputvars": [2], "logic": "minTotal", "args": "150"},
//             {"sequence": 4, "name": "C4", "inputvars": [3], "logic": "minTotal", "args": "100"},
//             {"sequence": 5, "name": "C5", "inputvars": [], "logic": "and", "args": ["C1", "C2", "C3", "C4"]},
//             {"sequence": 6, "name": "C6", "inputvars": [], "logic": "not", "args": "C5"}
//         ],
//         "payoff": [
//             // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
//             {"inputvar": 0, "criteria": "C1", "value": "asIs", "multiplier": "1"},
//             {"inputvar": 1, "criteria": "C2", "value": "asIs", "multiplier": "1"},
//             {"inputvar": 2, "criteria": "C3", "value": "asIs", "multiplier": "1"},
//             {"inputvar": 3, "criteria": "C4", "value": "asIs", "multiplier": "1"}
//         ],
//         "gameMaster": [
//             // Game Master Payoff defined the same way as payoff
//             {"inputvar": 0, "criteria": "C6", "value": "150", "multiplier": "1"}
//         ]
//     },
//     {
//         "quoid": qDecks[3],
//         "mapping": [
//             // Reflect the range of scores which can come back from the Quo and the corresponding values
//             {"score": "1", "value": ["Arjun", "Shikhandi", "0"]},
//             {"score": "2", "value": ["Arjun", "", "50"]},
//             {"score": "3", "value": ["", "Shikhandi", "100"]},
//             {"score": "4", "value": ["", "", "200"]}
//         ],
//         "criteria": [
//             // Variables should be the index of the columns in the mapping values
//             // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
//             {"sequence": 1, "name": "C1", "inputvars": [2], "logic": "minTotal", "args": "750"},
//             {
//                 "sequence": 2,
//                 "name": "C2",
//                 "inputvars": [0, 1],
//                 "logic": "unionAnd",
//                 "args": ["Arjun", "Shikhandi"]
//             },
//             {"sequence": 3, "name": "C3", "inputvars": [], "logic": "and", "args": ["C1", "C2"]},
//             {"sequence": 4, "name": "C4", "inputvars": [], "logic": "not", "args": "C3"}
//         ],
//         "payoff": [
//             // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
//             {"inputvar": 2, "criteria": "C1", "value": "asIs", "multiplier": "1"},
//             {"inputvar": 0, "criteria": "C3", "value": "250", "multiplier": "1"},
//             {"inputvar": 1, "criteria": "C3", "value": "150", "multiplier": "1"}
//         ],
//         "gameMaster": [
//             // Game Master Payoff defined the same way as payoff
//             {"inputvar": 0, "criteria": "C4", "value": "250", "multiplier": "1"}
//         ]
//     },
//     {
//         "quoid": qDecks[0],
//         "mapping": [
//             // Reflect the range of scores which can come back from the Quo and the corresponding values
//             {"score": "1", "value": ["Yudishthir", "Arjun", "0"]},
//             {"score": "2", "value": ["Yudishthir", "", "100"]},
//             {"score": "3", "value": ["", "Arjun", "200"]},
//             {"score": "4", "value": ["", "", "300"]}
//         ],
//         "criteria": [
//             // Variables should be the index of the columns in the mapping values
//             // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
//             {"sequence": 1, "name": "C1", "inputvars": [0, 1], "logic": "unionAnd", "args": ["Yudishthir", "Arjun"]},
//             {"sequence": 2, "name": "C2", "inputvars": [], "logic": "not", "args": "C1"}
//         ],
//         "payoff": [
//             // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
//             {"inputvar": 0, "criteria": "C1", "value": "100", "multiplier": "1"},
//             {"inputvar": 1, "criteria": "C1", "value": "50", "multiplier": "1"},
//             {"inputvar": 2, "criteria": "C1", "value": "asIs", "multiplier": "1"}
//         ],
//         "gameMaster": [
//             // Game Master Payoff defined the same way as payoff
//             {"inputvar": 0, "criteria": "C2", "value": "250", "multiplier": "1"}
//         ]
//     },
//     {
//         "quoid": qDecks[1],
//         "mapping": [
//             // Reflect the range of scores which can come back from the Quo and the corresponding values
//             {"score": "1", "value": ["", "", "0"]},
//             {"score": "2", "value": ["Bheem", "", "150"]},
//             {"score": "3", "value": ["", "Break", "300"]},
//             {"score": "4", "value": ["", "", "500"]}
//         ],
//         "criteria": [
//             // Variables should be the index of the columns in the mapping values
//             // Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
//             {"sequence": 1, "name": "C1", "inputvars": [0, 1], "logic": "unionAnd", "args": ["Bheem", "Break"]},
//             {"sequence": 2, "name": "C2", "inputvars": [2], "logic": "not", "args": "C1"}
//         ],
//         "payoff": [
//             // Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
//             {"inputvar": 0, "criteria": "C1", "value": "250", "multiplier": "1"},
//             {"inputvar": 2, "criteria": "C1", "value": "asIs", "multiplier": "1"},
//             {"inputvar": 2, "criteria": "C2", "value": "asIs", "multiplier": "-1"}
//         ],
//         "gameMaster": [
//             // Game Master Payoff defined the same way as payoff
//             {"inputvar": 0, "criteria": "C2", "value": "350", "multiplier": "1"}
//         ]
//     }
// ];
// // window.configuration = configuration;
