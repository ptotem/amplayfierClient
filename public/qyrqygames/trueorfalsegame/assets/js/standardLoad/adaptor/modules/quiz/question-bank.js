var questionbank = {};
var initQuestionBank = function(){
    questionbank.questions = [
        {
            statement: "Delhi is the capital of India",
            weight: 1,

            opta: "<img src='assets/img/true.png'/>",
            optacorrect: "true",
            optapoints: "100",

            optb: "<img src='assets/img/false.png'/>",
            optbcorrect: "false",
            optbpoints: "0",

            optc: "",
            optccorrect: "",
            optcpoints: "0",

            optd: "",
            optdcorrect: "",
            optdpoints: "0"

        },
        {
            statement: "Gateway of India is located in Pune",
            weight: 1,

            opta: "<img src='assets/img/true.png'/>",
            optacorrect: "false",
            optapoints: "0",

            optb: "<img src='assets/img/false.png'/>",
            optbcorrect: "true",
            optbpoints: "100",

            optc: "",
            optccorrect: "",
            optcpoints: "0",

            optd: "",
            optdcorrect: "",
            optdpoints: "0"

        },
        {
            statement: "India Gate is located in Delhi",
            weight: 1,

            opta: "<img src='assets/img/true.png'/>",
            optacorrect: "true",
            optapoints: "100",

            optb: "<img src='assets/img/false.png'/>",
            optbcorrect: "false",
            optbpoints: "0",

            optc: "",
            optccorrect: "",
            optcpoints: "0",

            optd: "",
            optdcorrect: "",
            optdpoints: "0"

        }

    ];

    questionbank.questions=parent.getQuestionsFromBank(parent.currentIntegratedGame);
}