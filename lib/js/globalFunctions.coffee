@setToken = (t)->
  @token = t
@hideAllPullouts = ()->
  []
@setIntegratedPreviewGame = (game_id)->
  @currentGameadded = (integratedGames.findOne(game_id).game)
  @currentIntegratedGame = game_id


@setTitle = (t)->
    document.title = t  ;
    $('head').append('<link rel="icon" sizes="16x16 32x32" href="/assets/images/favicon.ico?v=2">')
@setDeck  =(deck_id)->
  @deck = deck_id
@setFolder = (fldrId)->
  @folder = fldrId
@setTenant = (tid)->
  @tenantId = tid
@setStoryWrapperId = (swid)->
  @storyWrapperId = swid
@setDiscEdit  =(discount_id)->
  @editDisc = discount_id
@createNotification = (text,type)->
  # type indicates the type of notification
  # 0 -> failure
  # 1 -> success
  #2 -> warning
  toastr.clear()
  if type is 0
    toastr.error(text)
  if type is 1
    toastr.success(text)
  if type is 2
    toastr.warning(text)
@timeStampToDate = (tm)->
  new Date(tm).toDateString()
@timeStampToTime = (tm)->
  new Date(tm).toTimeString()


@showModal = (templateName,templateArgs,docId)->
    $(".modal").remove()
    Blaze.renderWithData(Template[templateName],templateArgs,document.getElementById(docId))
    $(".modal").modal()


@getImageFromAsset  =(aid)->
  if assetFiles.findOne(aid)?
    assetFiles.findOne(aid).url()

@executeInteractionsforDeck = ()->
#  dep.depend()

  for stat in currentSlide.interactions
    h = new hieroDSL(stat.name)
    h.executeStatement();
  $(".wrapper").trigger("myload")
@editTemplate  = (templateId)->


  console.log "-----------------------------------------------------------------" + templateId
  template = htemplates.findOne(templateId)
  if template.gameTemplate?
    @intGame = template.intGame
  @templateId = templateId
  if template.slides.length isnt 0
    @currentSlide = panels.findOne(template.slides[0])
  else
    @currentSlide = -1
  # if !Session.get("stopInteractions")?
  #   setTimeout(()->
  #
  #     executeInteractions();
  #   ,1500)
  if Session.get("playerOn")?
    setTimeout(()->
      executeInteractions()
      $(".component").attr("contenteditable",false)
      deactivateAllComponents()
    ,100)

  dep.changed()
@setCurrentSlide = (slideId)->
  if slideId is -1
    @currentSlide is -1
  else
  # if deck?
     # timeScores.insert({user_id:Meteor.userId(),end_time:new Date().getTime(),deck_id:deck,panel_id:@currentSlide._id})
    @currentSlide = panels.findOne(slideId)
    Session.set("activeLayer",currentSlide.layers[0].id)
    # if deck?
    #   timeScores.insert({user_id:Meteor.userId(),start_time:new Date().getTime(),deck_id:deck,panel_id:@currentSlide._id})
    if Session.get("playerOn")?
      setTimeout(()->
        executeInteractions()

      ,100)

    dep.changed()
@fixBackground = (templateId)->
  if htemplates.findOne(templateId).slides.length is 0
    $(".slide-wrapper").css("background-image","url('/assets/images/clicktoaddpanel.png')")
    $(".slide-wrapper").css("cursor","pointer")
  else
    $(".slide-wrapper").css("background-image","url('/assets/images/grid-bkg1.png')")


@deactivateAllComponents = ()->



  $(".component").removeClass("active")
  if Session.get("playerOn")?
    $(".component").each (index,element)->
      $(element).find(".actual-text").attr("contenteditable","false")
@executeInteractions = ()->

  if Session.get('playerOn')?
    # $(".component").hide()

    deactivateAllComponents()
  for stat in currentSlide.interactions

    h = new hieroDSL(stat.name)
    h.executeStatement();
  $(".preview-deck-player").trigger("hieroload")

@centerIcon = ->
  $('.component-with-icon').each (index, element)  ->
    imgcompwidth= $(element).width()
    imgcompheight= $(element).height()
    top = ($(element).height()/2 - 20 )
    left = ($(element).width()/2 - 20 )
    $(element).find('.add-newimage').css('top',top)
    $(element).find('.add-newimage').css('left',left)

@convertPptxToDeck = (fid)->
        # pptxFiles.update({_id:fid},{$set:{processed:true}})
        Meteor.call("convertPptxToImage",fid,-1,Meteor.userId(),(err,res)->
          if res is "true"
            Meteor.call("convertImgToDeck",fid,-1,Meteor.userId(),deck,(err,res)->
              if res is "true"
                # removeWaiters()
                createNotification(successMessages.deckCreatedSuccess,1)
              else
                # removeWaiters()
                createNotification(serverMessages[res],0)
            )
          else
            # removeWaiters()
            createNotification(serverMessages[res],0)

        )




@decodeEmail = (email) ->
  email.replace /\|.*@/g, '@'

@encodeEmail = (userEmail,pn) ->
	userEmail.substr(0, userEmail.indexOf('@')) + '|' + pn + userEmail.substr(userEmail.indexOf('@'))

@evaluateLicense = (user) ->
  console.log "---------"
  console.log("Code for restricting the user based on their license type will come here.")
