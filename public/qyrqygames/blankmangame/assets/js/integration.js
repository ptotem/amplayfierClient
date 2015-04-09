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
		return 5;
	}
}

function getIntNew(str){
    
	if (!str.match(/[^$,.\d]/)){
		return parseInt(str);
	}else{
		return 60;
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
defaultImages["bm-background"] = "back.jpg";
defaultImages["bm-correct"] = "correct.png";
defaultImages["bm-incorrect"] = "incorrect.png";
defaultImages["bm-time-up"] = "timeup.png";
defaultImages["bm-play-again"] = "replay.png";
defaultImages["bm-true"] = "true.png";
defaultImages["bm-false"] = "false.png";


defaultText = {};
defaultText["bm-text-name"] = "BLANKMAN";
defaultText["bm-text-max-time"] = "60";
defaultText["bm-text-you-scored"] = "You Scored";
defaultText["bm-text-timer"] = "true";
defaultText["bm-text-replayable"] = "true";
defaultText["bm-text-question-count"] = "5";


window.defaultImages = defaultImages;
