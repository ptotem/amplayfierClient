var arrowR = "/assets/images/right_arrow.png";
var arrowL = "/assets/images/left_arrow.png";
//
window.badgesVTO = [
	{
		sequence: 1,
		content: 
			{ 
				text: "You can earn upto 10 badges on the app. The badges that you are yet to earn are grey in color.",
				highlightElems: [
					".row:nth-child(1) .badge-item:nth-child(1)",
					".row:nth-child(2) .badge-item:nth-child(5)"
				],
				fadeElem: ".badge-item",
				arrows: [
					{
						img: "<img src='" + arrowR + "' class='arr flipY' />",
						left: 108,
						top: 45
					},
					{
						img: "<img src='" + arrowR + "' class='arr rot-230' />",
						left: -35,
						top: 0
					}
				],
				pos: {
					left: 40,
					top: 30
				}
			},
		button: "Got it!"
	},
	{
		sequence: 2,
		content: 
			{ 
				text: "Information about the cards are available at the back. Go ahead, hover your cursor over the cards to know more about themand how to get it! Remember, every badge you earn also gets you credits. This badge gives you 1000 credits. So you can collect credits with every badge and redeem them for exciting rewards.",
				highlightElems: [
				],
				fadeElem: "",
				arrows: [
					{
						img: "<img src='" + arrowR + "' class='arr rot-45' />",
						left: 110,
						top: 25
					}
				],
				pos: {
					left: 32,
					top: 60
				}
			},
		button: "Got it!"
	}
];

window.notificationsVTO = [
	{
		sequence: 1,
		content: 
			{ 
				text: "Notifications act as an archive of your activity on the system. You could also receive app notifications from the administrator regarding various events such as challenges.",
				highlightElems: [
					".list-group-item:nth-child(1)"
				],
				fadeElem: ".list-group-item",
				arrows: [
					{
						img: "<img src='" + arrowR + "' class='arr rot-45_' />",
						left: 40,
						top: -80
					}
				],
				pos: {
					left: 30,
					top: 45
				}
			},
		button: "Got it!"
	}
];

window.rewardsVTO = [
	{
		sequence: 1,
		content: 
			{ 
				text: "The reward center gives you a list of all the rewards that you can redeem using your app credits. If you remember, you earn credits every time you get a badge.",
				highlightElems: [
					".lib-item:nth-child(1)"
				],
				fadeElem: ".lib-item",
				arrows: [
					{
						img: "<img src='" + arrowL + "' class='arr rot-90' />",
						left: 35,
						top: -75
					}
				],
				pos: {
					left: 3,
					top: 70
				}
			},
		button: "Got it!"
	},
	{
		sequence: 2,
		content: 
			{ 
				text: "You can check what each reward actually is, and how many credits it would cost for you to redeem it.",
				highlightElems: [
					""
				],
				fadeElem: "",
				arrows: [
					{
						img: "<img src='" + arrowL + "' class='arr rot-20' />",
						left: -7,
						top: -110
					},
					{
						img: "<img src='" + arrowR + "' class='arr rot-45_' />",
						left: 20,
						top: -160
					}
				],
				pos: {
					left: 41,
					top: 75
				}
			},
		button: "Got it!"
	},
	{
		sequence: 3,
		content: 
			{ 
				text: "You can redeem a reward by clicking on the Redeem button next to it.",
				highlightElems: [
					""
				],
				fadeElem: "",
				arrows: [
					{
						img: "<img src='" + arrowR + "' class='arr rot-105_' />",
						left: 40,
						top: -90
					}
				],
				pos: {
					left: 68,
					top: 60
				}
			},
		button: "Got it!"
	}
];

window.documentsVTO = [
	{
		sequence: 1,
		content: 
			{ 
				text: "You can access, view and download documents that are required for you to get on top in this game.",
				highlightElems: [
					"#documents-collection .lib-item:nth-child(1)"
				],
				fadeElem: "#documents-collection .lib-item",
				arrows: [
					{
						img: "<img src='" + arrowL + "' class='arr rot-90' />",
						left: 25,
						top: -60
					}
				],
				pos: {
					left: 3,
					top: 37
				}
			},
		button: "Got it!"
	}
];

window.leaderboardVTO = [
	{
		sequence: 1,
		content: 
			{ 
				text: "The Leaderboard gives you the rank and score of the top 5 players on the app.",
				highlightElems: [
					"#leaderboard .row:nth-child(2)",
					"#leaderboard .row:last-child"
				],
				fadeElem: "#leaderboard .row",
				arrows: [
					{
						img: "<img src='" + arrowL + "' class='arr rot-45' />",
						left: -14,
						top: -186
					},
					{
						img: "<img src='" + arrowR + "' class='arr' />",
						left: 105,
						top: -195
					}
				],
				pos: {
					left: 28,
					top: 60
				}
			},
		button: "Got it!"
	},
	{
		sequence: 2,
		content: 
			{ 
				text: "You also get your rank and score compared with the leaders.",
				highlightElems: [

				],
				fadeElem: "",
				arrows: [
					{
						img: "<img src='" + arrowL + "' class='arr rot-105_' />",
						left: 28,
						top: 50
					}
				],
				pos: {
					left: 71,
					top: 70
				}
			},
		button: "Got it!"
	}
];

(function($) {
	
	$.fn.virtualTour = function(virtualTourData) {
		$('.txt-hldr').remove();
		var data = virtualTourData;
		
		console.log(data);
		console.log(this);
		
		var addClass = function(i) {
			if(data[i].content.highlightElems.length>0)
				for(var j in data[i].content.highlightElems) {
					$(data[i].content.highlightElems[j]).removeClass('transp no-click').addClass('opaque');
					console.log(data[i].content.highlightElems[j]);
				}
		};
		
		var addCSS = function(i) {
			$('.contentblock'+i).css({
				left: data[i].content.pos.left + "%",
				top: data[i].content.pos.top + "%"
			});
		};
		
		var addArrow = function(i) {
			for(var j in data[i].content.arrows) {
				$('.contentblock'+i).append(data[i].content.arrows[j].img);
				$('.contentblock'+i+' .arr').eq(j).css({
					left: data[i].content.arrows[j].left + "%",
					top: data[i].content.arrows[j].top + "%"
				})
			}
		};
		
		var addButton = function(i) {
			$('#nxt-btn').remove();
			$(".contentblock"+i).append('<br /><span id="nxt-btn" class="btn btn-warning btn-md">' + data[i].button + '</span>');
			$("#nxt-btn").unbind('click').on('click', function () {
				resetEverything(i);
			});
		};
		
		var resetEverything = function(i) {
			for(var j in data[i].content.highlightElems)
				$(data[i].content.highlightElems[j]).removeClass('opaque');
			$(data[i].content.fadeElem).removeClass('transp no-click');
			$('.txt-holdr').remove();
			$('.remove-modal').trigger('click');
			$('.vt-link').trigger('click');
		};
		
		
		for(var i in data) {
			$(this).append('<div class="contentblock' + i + ' txt-holdr opaque">' + data[i].content.text + '</div>');
			if(data[i].content.fadeElem!=="")
				$(data[i].content.fadeElem).addClass('transp no-click');
			addCSS(i);
			addArrow(i);
			addButton(i);
			addClass(i);
		}
		
		return this;
	};
	
})(jQuery)

