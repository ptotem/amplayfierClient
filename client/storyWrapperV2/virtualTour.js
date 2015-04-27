window.virtualTourObjects = [

    {
        sequence: 1,
        content: [
            {
                _id: "",
                text: "Welcome. Let’s take a quick look at what you can do on this game based app. Click the next button to continue!",
                lx: 35,
                ly: 13
            }
        ],
        button: "Next"
    },
    {
        sequence: 2,
        content: [
            {
                _id: "",
                text: "Let’s take a quick look at what you can do on this game based app.",
                lx: 35,
                ly: 17
            },
            {
                _id: "#story-node-26",
                text: "The main play area is on the right. You can access games and decks on the app by clicking on a chapter. The active chapter or checkpoint will always be highlighted.",
                lx: 51,
                ly: 43
            },
            {
                _id: "",
                text: "This is the app’s menu. You can use the menu buttons to go through your badges, leaderboards, notifications and much more.",
                lx: 7,
                ly: 43
            }
        ],
        button: "Next"
    },
    {
        sequence: 3,
        content: [
            {
                _id: "#story-node-8",
                text: "The app has a number of games and decks. You need to go through each deck and then play the games to get a score. This score will help you earn rewards, badges and a certificate – the licence to sell.",
                lx: 50,
                ly: 50
            },
            {
                _id: "#story-node-17",
                text: "The app has a number of games and decks. You need to go through each deck and then play the games to get a score. This score will help you earn rewards, badges and a certificate – the licence to sell.",
                lx: 10,
                ly: 10
            }
        ],
        button: "Next"
    }
];

window.setUpVirtualTour = function() {
    $("#story-wrapper").append('<div id="blurmebro"></div>');
    initVirtualTour(0);
}

window.initVirtualTour = function(count) {
    $("#blurmebro").empty();
    var obj_ = virtualTourObjects[count];

    for(var i in obj_.content) {
        $("#nxt-btn").remove();
        if(obj_.content[i]._id!=="")
            $(obj_.content[i]._id).css({zIndex: 92});

        $("#blurmebro").append('<p class="txt-holdr content-block_' + i + '">' + obj_.content[i].text + '</p>');
        if(obj_.button!=="") {
            $(".content-block_"+i).append('<br /><span id="nxt-btn" class="btn btn-warning btn-md">' + obj_.button + '</span>');
            $("#nxt-btn").unbind('click').on('click', function () {
                initVirtualTour(count + 1)
            });
        }

        $(".content-block_" + i).css({
            //width: "30%",
            top: obj_.content[i].ly + "%",
            left: obj_.content[i].lx + "%"
        });
    }
}