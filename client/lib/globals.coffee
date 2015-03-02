@setPlatform = (pname)->
	@platformName = pname

@setCurrentGameId = (id)->
	@currentGameId = id

@setCurrentIntegratedGameId = (id)->
	@currentIntegratedGameId = id
	@currentIntegratedGame = id





@setCurrentDeckId = (deckId)->
	console.log "setting deckId...."
	console.log deckId

	@currentDeckId = deckId


@setCurrentSlideId = (templateId)->
	console.log "setting templateId...."
	console.log templateId
	@currentTemplateId = templateId

@setCurrentPanelId = (panelId)->
	console.log "setting templateId...."
	console.log panelId
	@currentPanelId = panelId


@setCurrentSlideType = (type)->
	@currentSlideType = true

@callStartAttempt = (type)->
	if type is false
		startAttempt()


@getQuestionsFromBank = (integratedGameId)->
	console.log integratedGameId
	gameData.findOne({igId:integratedGameId}).questions

@triggerInitGame = ()->
	document.getElementsByTagName('iframe')[0].contentWindow.$("body").trigger("loadGame");

@getImageInGame = ()->
	console.log "getImageInGame"
	403

@getTextInGame = (a,k)->
	console.log k
	# 403
	if customizationDecks.findOne({intGameId:currentIntegratedGameId,custKey:k})?
		customizationDecks.findOne({intGameId:currentIntegratedGameId,custKey:k}).custVal
	else
		403
