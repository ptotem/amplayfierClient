function getImg(str){
//    return defaultImages.path+defaultImages[str]
    if(parent.getImageInGame(parent.currentIntegratedGame,str) === 403)
        return defaultImages.path+defaultImages[str]
    else
        return parent.getImageInGame(parent.currentIntegratedGame,str)
}

function getText(str){
//    return defaultText[str]
    if(parent.getTextInGame(parent.currentIntegratedGame,str) === 403)
        return defaultText[str]
    else
        return parent.getTextInGame(parent.currentIntegratedGame,str)
}

window.getImg= getImg
window.getText = getText

//this is the object which contains path for default text and images
defaultImages = {}
defaultImages.path = "img/"
defaultImages["kbc-background"] = "background.jpg";
defaultImages["kbc-logo"] = "game_logo.png";
defaultImages["kbc-button-start"] = "kbc-start-button.png";
defaultImages["kbc-button-start-hover"] = "kbc-start-button-hover.png";
defaultImages["kbc-button-instruction"] = "kbc-start-button.png";
defaultImages["kbc-button-instruction-hover"] = "kbc-start-button-hover.png";
defaultImages["kbc-button-play-again"] = "kbc-start-button.png";
defaultImages["kbc-button-play-again-hover"] = "kbc-start-button-hover.png";
defaultImages["kbc-button-know-more"] = "knowmore.png";
defaultImages["kbc-button-know-more-hover"] = "knowmore-hover.png";
defaultImages["kbc-character"] = "character.png";
defaultImages["kbc-answer-back"] = "kbc-answer-texture.png";
defaultImages["kbc-answer-hover-back"] = "kbc-answer-hover-texture.png";
defaultImages["kbc-answer-correct-back"] = "kbc-answer-right-texture.png";
defaultImages["kbc-lifeline1-img"] = "poll.png";
defaultImages["kbc-lifeline1-img-disabled"] = "poll-disabled.png";
defaultImages["kbc-lifeline2-img"] = "50-50.png";
defaultImages["kbc-lifeline2-img-disabled"] = "50-50-disabled.png";
defaultImages["kbc-lifeline3-img"] = "change.png";
defaultImages["kbc-lifeline3-img-disabled"] = "change-disabled.png";
defaultImages["kbc-ladder-current"] = "kbc-player-texture.png";


defaultText = {};
defaultText["kbc-text-ladder01"] = "$1,000";
defaultText["kbc-text-ladder02"] = "$2,000";
defaultText["kbc-text-ladder03"] = "$5,000";
defaultText["kbc-text-ladder04"] = "$10,000";
defaultText["kbc-text-ladder05"] = "$20,000";
defaultText["kbc-text-ladder06"] = "$50,000";
defaultText["kbc-text-ladder07"] = "$100,000";
defaultText["kbc-text-ladder08"] = "$200,000";
defaultText["kbc-text-ladder09"] = "$500,000";
defaultText["kbc-text-ladder10"] = "$1,000,000";

defaultText["kbc-text-instruction-header"] = "Instructions";
defaultText["kbc-text-instructions"] = "<p>The main objective of this game is to answer all questions correctly and get "+getText("kbc-ladder10-text")+". To achieve this you also have three lifelines to help you reach your goal.</p>" +
    "<p>1. Poll: This lifeline shows you the Audience's opinion for this question in a graph format.</p> " +
    "<p>2. 50-50: This lifeline removes two 'Wrong' answers.</p> " +
    "<p>3. Change Question: This lifeline changes this question for another.</p> "





window.defaultImages = defaultImages;
