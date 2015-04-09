function getImg(str){
	if(parent.getImageInGame(parent.currentIntegratedGameId,str) === 403)
		return defaultImages.path+defaultImages[str];
	else
		return parent.getImageInGame(parent.currentIntegratedGameId,str);
}

function getText(str) {
	if(parent.getTextInGame(parent.currentIntegratedGameId,str) === 403)
		return defaultText[str];
	else
		return parent.getTextInGame(parent.currentIntegratedGameId,str);
}

function getInt(str){
	if (!str.match(/[^$,.\d]/)){
		return parseInt(str);
	}else{
		return 4;
	}
}

function getBoolean(str){
	console.log(str);
	if(str.toLowerCase()=== "true" || str.toLowerCase() === "false"){
		return JSON.parse(str.toLowerCase());
	} else{
		return true;
	}

}

window.getBoolean = getBoolean;
window.getInt =getInt;

window.getImg = getImg;
window.getText = getText;

//this is the object which contains path for default text and images
defaultImages  = {};
defaultImages.path = "assets/img/";
defaultImages["mcq-background"] = "back.jpg";
defaultImages["mcq-correct"] = "correct.png";
defaultImages["mcq-incorrect"] = "incorrect.png";
defaultImages["mcq-time-up"] = "timeup.png";
defaultImages["mcq-play-again"] = "replay.png";


defaultText = {};
defaultText["mcq-text-name"] = "QUIZZOMETER";
defaultText["mcq-text-max-time"] = "10";
defaultText["mcq-text-you-scored"] = "You Scored";
defaultText["mcq-text-timer"] = "true";
defaultText["mcq-text-replayable"] = "true";
defaultText["mcq-text-question-count"] = "4";


window.defaultImages = defaultImages;
