var questionbank = {};
questionbank.questions = [
    {
        statement: "How many roads must a man walk down?",
//        image:'img/quizback.jpg',
        weight: 1,
        options: [
            {option: 1, name: "42", correct: true, points: 100},
            {option: 2, name: "None", correct: false, points: 0},
            {option: 3, name: "Only One", correct: true, points: 60},
            {option: 4, name: "Only Two", correct: false, points: 0}
        ],
        slide_id:321
    },
    {
        statement: "How many broads must a man talk down?",
        weight: 1,
        options: [
            {option: 1, name: "Infinite", correct: true, points: 100},
            {option: 2, name: "None", correct: false, points: 0},
            {option: 3, name: "Only One", correct: false, points: 0},
            {option: 4, name: "Only Two", correct: false, points: 0}
        ],
        slide_id:123
    }
];
questionbank.questions=parent.getQuestionsFromBank(parent.currentIntegratedGame);
