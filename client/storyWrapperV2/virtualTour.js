var arrow = "/assets/images/right_arrow.png";

window.virtualTourObjects = [

    {
        sequence: 1,
        content: [
            {
                _id: "",
                text: "Welcome. Let’s take a quick look at what you can do on this game based app. Click the next button to continue!",
                lx: 35,
                ly: 13,
                arrow: {},
                trigger: []
            }
        ],
        button: "Next"
    },
    {
        sequence: 2,
        content: [
            {
                _id: "",
                text: "Welcome, let’s take a quick look at what you can do on this game based app.",
                lx: 35,
                ly: 17,
                arrow: {},
                trigger: []
            },
            {
                _id: ["#story-node-26"],
                text: "The main play area is on the right. You can access games and decks on the app by clicking on a chapter. The active chapter or checkpoint will always be highlighted.",
                lx: 54,
                ly: 56,
                arrow: {
                    img: "<img src='" + arrow + "' class='arr' />",
                    lx: 103,
                    ly: 0
                },
                trigger: []
            }
        ],
        button: "Got it!"
    },
    {
        sequence: 3,
        content: [
            {
                _id: "",
                text: "Welcome, let’s take a quick look at what you can do on this game based app.",
                lx: 35,
                ly: 17,
                arrow: {},
                trigger: []
            },
            {
                _id: ["#story-node-26"],
                text: "The main play area is on the right. You can access games and decks on the app by clicking on a chapter. The active chapter or checkpoint will always be highlighted.",
                lx: 54,
                ly: 56,
                arrow: {
                    img: "<img src='" + arrow + "' class='arr' />",
                    lx: 103,
                    ly: 0
                },
                trigger:[]
            },
            {
                _id: [],
                text: "This is the app’s menu. You can use the menu buttons to go through your badges, leaderboards, notifications and much more.",
                lx: 12,
                ly: 43,
                arrow: {
                    img: "<img src='" + arrow + "' class='arr flipY' />",
                    lx: -23,
                    ly: -40
                },
                trigger:[]
            }
        ],
        button: "Next"
    },
    {
        sequence: 4,
        content: [
            {
                _id: ".badge-link",
                text: "Let’s check out the badges you can earn on the app. To do this, click on the Badges Corner icon on the menu bar.",
                lx: 35,
                ly: 17,
                arrow: {
                  img: "<img src='" + arrow + "' class='arr' />",
                  lx: 103,
                  ly: 0
                },
                trigger: [
                  {
                    _id: ".badge-link",
                    do: "hover",
                    removeCls: "collapsed"
                  }
                ]
            }
        ],
        button: "Next"
    },

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
        if(obj_.content[i]._id.length!==0)
            for(var j in obj_.content[i]._id)
                $(obj_.content[i]._id[j]).css({zIndex: 92});

        $("#blurmebro").append('<p class="txt-holdr content-block_' + i + '">' + obj_.content[i].text + '</p>');

        if(obj_.button!=="") {
            $(".content-block_"+i).append('<br /><span id="nxt-btn" class="btn btn-warning btn-md">' + obj_.button + '</span>');
            $("#nxt-btn").unbind('click').on('click', function () {
                for(var i in obj_.content)
                  if(obj_.content[i]._id.length!==0)
                      for(var j in obj_.content[i]._id)
                          $(obj_.content[i]._id[j]).css({zIndex: "auto"});
                initVirtualTour(count + 1);
            });
        }


        if(obj_.content[i].arrow.length!==0) {
            $(".content-block_" + i).prepend(obj_.content[i].arrow.img);
            $(".content-block_" + i + " .arr").css({
                top: obj_.content[i].arrow.ly + "%",
                left: obj_.content[i].arrow.lx + "%"
            });
        }

        var trig = obj_.content[i].trigger;

        console.log (trig);
        
        if(trig.length>0)
          for(var j in obj_.content[i].trigger)
            $(trig[j]._id).removeClass(trig[j].removeCls).trigger(trig[j].do);

        $(".content-block_" + i).css({
            top: obj_.content[i].ly + "%",
            left: obj_.content[i].lx + "%"
        });
    }
}
