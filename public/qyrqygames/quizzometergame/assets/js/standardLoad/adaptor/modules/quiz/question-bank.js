var questionbank = {};
var initQuestionBank = function(){
    questionbank.questions = [
        {
            statement: "What is the capital of India",
            weight: 1,
            image: "delhi.jpg",

            opta: "Delhi",
            optacorrect: "true",
            optapoints: "100",

            optb: "Calcutta",
            optbcorrect: "false",
            optbpoints: "0",

            optc: "Mumbai",
            optccorrect: "false",
            optcpoints: "0",

            optd: "New York",
            optdcorrect: "false",
            optdpoints: "0"

        },
        {
            statement: "Gateway of India is located in which city",
            weight: 1,
            image: "gateway.jpg",

            opta: "Delhi",
            optacorrect: "false",
            optapoints: "0",

            optb: "Calcutta",
            optbcorrect: "false",
            optbpoints: "0",

            optc: "Mumbai",
            optccorrect: "true",
            optcpoints: "100",

            optd: "Chennai",
            optdcorrect: "false",
            optdpoints: "0"


        },
        {
            statement: "The Guindy National Park is located in which city",
            weight: 1,
            image: "",

            opta: "Delhi",
            optacorrect: "false",
            optapoints: "0",

            optb: "Calcutta",
            optbcorrect: "false",
            optbpoints: "0",

            optc: "Mumbai",
            optccorrect: "true",
            optcpoints: "100",

            optd: "Chennai",
            optdcorrect: "false",
            optdpoints: "0"


        }

    ];

    questionbank.questions=parent.getQuestionsFromBank(parent.currentIntegratedGame);
}