// var inputJSON = [
//     {
//         "quoid": "GQdvHc9cNznWjM8if",
//         "scores": [
//             {"userid": "1", "score": "1"},
//             {"userid": "2", "score": "4"},
//             {"userid": "3", "score": "3"},
//             {"userid": "4", "score": "3"},
//             {"userid": "5", "score": "3"},
//             {"userid": "6", "score": "3"},
//             {"userid": "7", "score": "3"}
//         ]
//     },
//     {
//         "quoid": "Q2",
//         "scores": [
//             {"userid": "1", "score": "2"},
//             {"userid": "2", "score": "3"},
//             {"userid": "3", "score": "3"},
//             {"userid": "4", "score": "1"},
//             {"userid": "5", "score": "1"},
//             {"userid": "6", "score": "1"},
//             {"userid": "7", "score": "1"}
//         ]
//     },
//     {
//         "quoid": "Q3",
//         "scores": [
//             {"userid": "1", "score": "2"},
//             {"userid": "2", "score": "2"},
//             {"userid": "3", "score": "2"},
//             {"userid": "4", "score": "3"},
//             {"userid": "5", "score": "4"},
//             {"userid": "6", "score": "4"},
//             {"userid": "7", "score": "4"}
//         ]
//     },
//     {
//         "quoid": "Q4",
//         "scores": [
//             {"userid": "1", "score": "1"},
//             {"userid": "2", "score": "1"},
//             {"userid": "3", "score": "2"},
//             {"userid": "4", "score": "4"},
//             {"userid": "5", "score": "3"},
//             {"userid": "6", "score": "4"},
//             {"userid": "7", "score": "3"}
//         ]
//     },
//     {
//         "quoid": "Q5",
//         "scores": [
//             {"userid": "1", "score": "4"},
//             {"userid": "2", "score": "1"},
//             {"userid": "3", "score": "3"},
//             {"userid": "4", "score": "2"},
//             {"userid": "5", "score": "2"},
//             {"userid": "6", "score": "1"},
//             {"userid": "7", "score": "4"}
//         ]
//     },
//     {
//         "quoid": "Q6",
//         "scores": [
//             {"userid": "1", "score": "1"},
//             {"userid": "2", "score": "1"},
//             {"userid": "3", "score": "3"},
//             {"userid": "4", "score": "3"},
//             {"userid": "5", "score": "4"},
//             {"userid": "6", "score": "3"},
//             {"userid": "7", "score": "4"}
//         ]
//     }
// ]
// deckList = platforms.findOne({_id:"TnikmYGFF9zzRnXDo"}).quodecks
// userList = []
// var i, j, len, ref;
// ref = Meteor.users.find({platform: "TnikmYGFF9zzRnXDo"}).fetch();
//   for (j = 0, len = ref.length; j < len; j++) {
//     i = ref[j];
//     userList.push(i._id);
// }
//

// var inputJSON = Meteor.call("getQuodeckScore", deckList, userList,function(err,res){
//   if (!err){
//     console.log ("No Error")
//     console.log (res)
//   }
// });
// window.inputJSON = inputJSON;
// console.log("11111111111111111111111111")
// console.log(inputJSON)
// console.log("11111111111111111111111111")

var leaderboardJSON = {
    "name": "Basic Leaderboard",
    "schema": [],
    "data": [
        {"userid": "1", "totalScore": "0", "quoScores": []},
        {"userid": "2", "totalScore": "0", "quoScores": []},
        {"userid": "3", "totalScore": "0", "quoScores": []},
        {"userid": "4", "totalScore": "0", "quoScores": []},
        {"userid": "5", "totalScore": "0", "quoScores": []},
        {"userid": "6", "totalScore": "0", "quoScores": []},
        {"userid": "7", "totalScore": "0", "quoScores": []},
        {"userid": "gameMaster", "totalScore": "0", "quoScores": []}
    ]
}
window.leaderboardJSON = leaderboardJSON;
