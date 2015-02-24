var storyConfig = {
    name: "The Amplayfier Blueprints",
    imgsrc: "img/prisonbreak",
    background: "background.jpg",
    portraitBackground: "backgroundportrait.jpg",
    offline: true,
    formal: false,
    zone: {
        px: 12,
        py: 8,
        background: "",
        magnification: 1.2
    },
    presenter: {
        image: "presenter.png",
        px: 70,
        py: 3,
        width: 40,
        portraitpx: -20,
        portraitpy: 65,
        portraitwidth: 75
    },
    nameplate: {
        image: "nameplate.png",
        px: 62,
        py: 65,
        width: 40,
        reduced: 40,
        portraitpx: 43,
        portraitpy: 82,
        portraitwidth: 60
    },
    nodestyle: {
        incomplete: "node-incomplete.png",
        complete: "node-complete.png",
        active: "node-active.png",
        hover: "",
        popovers: true,
        align: "",
        titleSize: "",
        titleColor: "",
        descSize: "",
        descColor: ""
    },
    nodes: [
        {
            title: "Start the Mission ",
            incomplete: "",
            complete: "start-complete.png",
            active: "start-active.gif",
            photo: "beach.jpg",
            description: "Get an introduction to the game",
            deckable: true,
            sequence: 0,
            px: 66,
            py: 30,
            width: 5
            },
        {
            title: "Meet the Insider",
            incomplete: "",
            complete: "insider-complete.png",
            active: "insider-active.gif",
            photo: "insider.jpg",
            description: "What is it",
            deckable: true,
            sequence: 1,
            px: 57,
            py: 5,
            width: 5
            },
        {
            title: "Bug The Hotel",
            incomplete: "",
            complete: "bug-complete.png",
            active: "bug-active.gif",
            photo: "rooftop.jpg",
            description: "Why is it needed",
            deckable: true,
            sequence: 2,
            px: 47,
            py: 31,
            width: 5
            },
        {
            title: "Eavesdropping",
            incomplete: "",
            complete: "eaves-complete.png",
            active: "eaves-active.gif",
            photo: "eaves.jpg",
            description: "What is it for",
            deckable: true,
            sequence: 3,
            px: 6,
            py: 28,
            width: 5
            },
        {
            title: "Research Laboratory",
            incomplete: "",
            complete: "scientist-complete.png",
            active: "scientist-active.gif",
            photo: "research.jpg",
            description: "Where can I use it",
            deckable: true,
            sequence: 4,
            px: 34,
            py: 6,
            width: 5
            },
        {
            title: "Extraction Point",
            incomplete: "",
            complete: "node-complete.png",
            active: "final-active.gif",
            photo: "evacuation.jpg",
            description: "",
            deckable: false,
            sequence: 5,
            px: 13,
            py: 68,
            width: 5
            }
        ]
};

window.storyConfig = storyConfig;
