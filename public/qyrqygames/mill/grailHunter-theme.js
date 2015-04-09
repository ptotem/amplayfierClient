


window.theme ={};
theme.background = getImg("gh-background");
theme.cityBackground = 'citybackground.jpg';
theme.quizBackground = 'quizback.jpg';
theme.quizImgDefault = 'defaultq.jpg';
theme.player = getImg("gh-player");
theme.travelImg = getImg("gh-travel");
theme.grailfail = getImg("gh-grail-fail");
theme.defeatImg = getImg("gh-lose");
theme.notificationBack =  getImg("gh-notification");

theme.city = 'city';

theme.health = 'life';
theme.healthImg = getImg("gh-life");

theme.money = 'gold';
theme.moneyImg = getImg("gh-gold");

theme.searchItem = 'Grail';
theme.searchItemImg = getImg("gh-win");

theme.cities = [
    {name: getText("gh-city-name0"), left: 40, top: 50, width: "32px", height: "32px"},
    {name: getText("gh-city-name1"), left: 15, top: 40, width: "32px", height: "32px"},
    {name: getText("gh-city-name2"), left: 55, top: 30, width: "32px", height: "32px"},
    {name: getText("gh-city-name3"), left: 30, top: 35, width: "32px", height: "32px"},
    {name: getText("gh-city-name4"), left: 75, top: 16, width: "32px", height: "32px"},
    {name: getText("gh-city-name5"), left: 20, top: 20, width: "32px", height: "32px"},
    {name:getText("gh-city-name6"), left: 60, top: 70, width: "32px", height: "32px"},
    {name: getText("gh-city-name7"), left: 70, top: 45, width: "32px", height: "32px"}
];

theme.cards = {
    questioner: [getImg("gh-quest6"),getText("gh-quest6-name")],
    lowHealthOutMoneyIn: [getImg("gh-quest2"),getText("gh-quest2-name")],
    highHealthOutMoneyIn: [getImg("gh-quest5"),getText("gh-quest5-name")],
    fixedHealthOutMoneyIn: [getImg("gh-quest7"),getText("gh-quest7-name")],
    lowMoneyOutHealthIn: [getImg("gh-quest8"),getText("gh-quest8-name")],
    highMoneyOutHealthIn: [getImg("gh-quest3"),getText("gh-quest3-name")],
    fixedMoneyOutHealthIn: [getImg("gh-quest4"),getText("gh-quest4-name")],
    MoneyOutMoneyIn: [getImg("gh-quest1"),getText("gh-quest1-name")]
};
