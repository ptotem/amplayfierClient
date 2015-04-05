var platformData = {
        introduction: "",
        endMessage: "",
        sequential: true,
        nodes: [
            {
                title:"The Lonely Cove ",
                subtitle: "Land on the Secret Island and get your mission brief",
                description: "The Amplayfier is a technology of incredible power, which can define our future. Steal the blueprints and get them to us...",
                sequence: 0,
                decks: [1]
            },
            {
                title:"The Abandoned Shack",
                subtitle: "Meet the Insider and he will guide you on what you have to do ",
                description: "The Insider is a suspicious sorts, he will need you to convince him that you are one of us...",
                sequence: 1,
                decks: [2]
            },
            {
                title:"The Hotel Rooftop",
                subtitle: "Read the Insider's dossier and bug the hotel guest rooms appropriately",
                description: "Spend some time reading the dossier and then bug the correct guest rooms",
                sequence: 2,
                decks: [2]
            },
            {
                title:"The Communications Center",
                subtitle: "Overhear the conversations of the buyers to know where they intend to use the Amplayfier",
                description: "Use the quiet room on top of the communications center to spy on the buyers",
                sequence: 3,
                decks: [3]
            },
            {
                title:"Steal the Blueprints",
                subtitle: "If you are prepared, steal the blueprints",
                description: "The Amplayfier Blueprints are hidden in one of the laboratories. Enter the complex and find it.",
                sequence: 4,
                decks: [4]
            },
            {
                title:"Evacuation Point",
                subtitle: "Congratulations! You have the blueprints. Make it to the evacuation point and you are done.",
                description: "You have finished the game. Now collect the reward.",
                sequence: 5,
                decks: []
            }
        ]
    }

var wrapperDecks = [
    {
        _id: '1',
        name: "Start the Mission",
        deckDesc: "You have just landed on the beach. The boatman will direct you now.",
        slides: 2
    },
    {
        _id: '2',
        name: "Read the Insider Dossier",
        deckDesc: "The insider dossier contains details of what the Amplayfier is. Read it to prepare for your mission.",
        slides: 1
    },
    {
        _id: '3',
        name: "Spy on the Buyers",
        deckDesc: "The buyers are talking. Listen in to learn more.",
        slides: 3
    },
    {
        _id: '4',
        name: "The Futurists",
        deckDesc: "Read up on the Futurists",
        slides: 1
    }
];

var userdata = {
    decks: [
        {
            deckId: "123",
            complete: false
        },
        {
            deckId: "123",
            complete: false
        },
        {
            deckId: "123",
            complete: false
        },
        {
            deckId: "123",
            complete: false
        }
    ]
};

window.userdata = userdata;
window.platformData = platformData;
window.wrapperDecks = wrapperDecks;
