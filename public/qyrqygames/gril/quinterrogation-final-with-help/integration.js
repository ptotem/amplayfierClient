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
defaultImages  ={}
defaultImages.path = "img/";
defaultImages["qt-logo"] = "game_logo.png";
defaultImages["qt-background"] = "background.jpg";
defaultImages["qt-button-start"] = "start_game.png";
defaultImages["qt-button-start-hover"] = "start_game_hover.png";
defaultImages["qt-statement-back"] = "speech_bubble_1.png";
defaultImages["qt-options-back"] = "speech_bubble_2.png";
defaultImages["qt-player"] = "player.png";
defaultImages["qt-ai"] = "ai.png";
defaultImages["qt-button-say-this"] = "say_button.png";
defaultImages["qt-button-know-more"] = "know_more.png";
defaultImages["qt-arrow-left"] = "leftOpt.png";
defaultImages["qt-arrow-right"] = "rightOpt.png";
defaultImages["qt-meter-bar-empty"] = "meterbar_bg.png";
defaultImages["qt-meter-bar-filled"] = "meter_filled.png";
defaultImages["qt-bottom-overlay"] = "bot_overlay.png";
defaultImages["qt-message-box-back"] = "message_box_bg.jpg";
defaultImages["qt-button-play-again"] = "play_again.png";
defaultImages["qt-button-play-again-hover"] = "play_again_hover.png";

defaultText = {};
defaultText["qt-text-meter"] = "mood";
defaultText["qt-text-instruction-header"] = "Instructions";
defaultText["qt-text-instructions"] = "The main objective of this game is to get the client's '" + getText("qt-text-meter") +
    "' above the limit specified in red. <br /><br />" +
    "To get the meter up, you have to respond to the client with an appropriate statement. " +
    "Each client responds to each statement differently. " +
    "You have to select the best possible response for each statement the client makes. <br /><br />" +
    "If by the end of this interrogation, you do not fulfill the objective, you will lose the client.";



window.defaultImages = defaultImages;
