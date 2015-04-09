function getImg(str){
	if(parent.getImageInGame(parent.currentIntegratedGame,str) === 403)
		return defaultImages.path+defaultImages[str];
	else
		return parent.getImageInGame(parent.currentIntegratedGame,str);
}

function getText(str) {
	if(parent.getTextInGame(parent.currentIntegratedGame,str) === 403)
		return defaultText[str];
	else
		return parent.getTextInGame(parent.currentIntegratedGame,str);
}

window.getImg = getImg;
window.getText = getText;

//this is the object which contains path for default text and images
defaultImages  = {};
defaultImages.path = "assets/img/";
defaultImages["ft-background"] = "back.jpg";
defaultImages["ft-correct"] = "correct.png";
defaultImages["ft-incorrect"] = "incorrect.png";
defaultImages["ft-time-up"] = "timeup.png";
defaultImages["ft-play-again"] = "replay.png";
defaultImages["ft-true"] = "true.png";
defaultImages["ft-false"] = "false.png";


defaultText = {};
defaultText["ft-text-name"] = "MINDTOSS";
defaultText["ft-text-max-time"] = 10;
defaultText["ft-text-you-scored"] = "You Scored";
defaultText["ft-text-timer"] = true;
defaultText["ft-text-replayable"] = true;
defaultText["ft-text-question-count"] = 4;


window.defaultImages = defaultImages;
