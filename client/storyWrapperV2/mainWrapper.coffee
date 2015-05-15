Template.mainWrapper.rendered = ->

  $(window).resize (evt) ->
    setTitle(storyConfig.name)
#    window.storyConfig.imgsrc = Meteor.settings.public.mainLink + window.storyConfig.imgsrc
    window.platformData.nodes = platforms.findOne().nodes
    initPage()
    setTimeout(()->
      $('.story-node').popover({trigger:'hover',html: true})
     
    ,1000)
   

  setTitle(storyConfig.name)
  window.storyConfig.imgsrc = Meteor.settings.public.mainLink + window.storyConfig.imgsrc
  window.platformData.nodes = platforms.findOne().nodes
  initPage()
  setTimeout(()->
    $('.story-node').popover({trigger:'hover',html: true})
    # showNotification("40",'PepsiCo OnBoarding','Welcome to the PepsiCo Sales Onboarding Platform. Click on the moving PepsiCo logo to start.')
    $('#story-nameplate-cover').fadeOut(3000);

  ,1000)


Template.mainWrapper.created = ()->
  s = platforms.findOne().wrapperJson
  window.storyConfig = s

Template.mainWrapper.helpers
  isPortrait:()->
     window.innerHeight > window.innerWidth
  hud:()->
    platforms.findOne().wrapperJson.infobox
  game:()->
    platforms.findOne().wrapperJson.gamecontainer
  hasGame:()->
    platforms.findOne().wrapperJson.hasgame is true

  getHudImage:()->
    Meteor.settings.public.mainLink+storyConfig.imgsrc + "/" + storyConfig.infobox.image

  getPrecTop : (top)->

    return top 
  getPrecLeft:(left1)->
    left1 

  getNamePlate : ()->
    Meteor.settings.public.mainLink+storyConfig.imgsrc + "/" + storyConfig.nameplate.image
  getStoryPresenter: ()->
    Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + storyConfig.presenter.image
  getBackColor: ()->
    storyConfig.background.color || "#000000"
  getBackImg: ()->
    Meteor.settings.public.mainLink+storyConfig.imgsrc + "/" + storyConfig.background.image
  nodes : ()->
   platforms.findOne().nodes
     # sc.nodes
  storyHeading:()->
    storyConfig.name
#    sc.name
  getNodeStatusPic:(seq)->

    if seq isnt 1
      if !userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq-1})?
#        return Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + sc.nodes[seq].incomplete
        n = _.where(platforms.findOne().nodes,{sequence:seq})[0]
        if parseInt(platforms.findOne().nodes.length) is 1
          return Meteor.settings.public.mainLink +  storyConfig.imgsrc + "/" + n.active
        else          

            return Meteor.settings.public.mainLink +  storyConfig.imgsrc + "/" + n.incomplete
    #  

        

    if userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq})?

#      Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + sc.nodes[seq].complete
      n = _.where(platforms.findOne().nodes,{sequence:seq})[0]
      Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + n.complete

    else
#      Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + sc.nodes[seq].active
      n = _.where(platforms.findOne().nodes,{sequence:seq})[0]
      Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + n.active
  getNodeUrl:(pic)->
      
      # n = _.where(platforms.findOne().nodes,{sequence:seq})[0]
      "<img class='popover-photo' src='"+Meteor.settings.public.mainLink+storyConfig.imgsrc + "/" + this['node-photo'] + "' />"
  getPlacement:(px)->
    if px < 50
      "right"
    else
      "left"
  getNodeStatus:(seq)->
    if seq isnt 0
      if !userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq-1})?
        if parseInt(platforms.findOne().nodes.length) is 1
          return  "<div class='popover-content-block active-popover-content'>Active</div>"
        else          

          return "<div class='popover-content-block incomplete-popover-content'>Incomplete</div>"
    #        return Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + platforms.findOne().nodes[seq].incomplete

    if userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq})?

      "<div class='popover-content-block complete-popover-content'>Complete</div>"
    else
      "<div class='popover-content-block active-popover-content'>Active</div>"

  getNodeStatusClass:(seq)->
    if seq isnt 1
      if !userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq-1})?
         if parseInt(platforms.findOne().nodes.length) is 1
          return   "my-active-node"
        else          

            return "my-incomplete-node"
    #  
        
    #        return Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + platforms.findOne().nodes[seq].incomplete

    if userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq})?

      "my-complete-node"
    else
      "my-active-node"




Template.mainWrapper.events
  'click #oc-right-toggle':(e)->
    $(e.currentTarget).parents('#oc-wrapper').toggleClass('oc-lg-hidden-right oc-lg-open-right')
    $('.chat-bar').css('padding-top',0)
    $('.oc-sidebar').css('width','280px')

  'click #license-img':(e)->
    showModal('licenseTempModal',{},'main-wrapper-page')

  'click .story-node':(e)->

    showModal('nodeTemp',{},'main-wrapper-page')
#    $('[data-toggle="popover"]').popover('hide');
#    $('.story-node').css({
#      "pointer-events": "none",
#      opacity: 0
#    });
#    if window.innerWidth > 1050
#      $('#story-nameplate').animate width: storyConfig.nameplate.reduced + '%'
#    else
#      if !isPortrait()
#        $('#story-nameplate').fadeOut()
#    $('#story-zone').empty()
    seq = parseInt($(e.currentTarget).attr('seq'))
    # node = platforms.findOne().nodes[seq]
    node = _.where(platforms.findOne().nodes,{sequence:seq})[0]
    nodePhoto =  storyConfig.imgsrc + "/" + node['node-photo']
    nodeTitle = node.title
    nodeDescription = node.description
    if seq isnt 0
      if !userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq-1})?
        s = "INCOMPLETE"
    #        return Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + platforms.findOne().nodes[seq].incomplete
    console.log seq
    if userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq})?

        s = "COMPLETE"
    else
      s = "INCOMPLETE"




    showModal('nodeTemp',{status:s,seq:seq,nodePhoto:nodePhoto,nodeTitle:nodeTitle,nodeDescription:nodeDescription},'main-wrapper-page')
    setTimeout(()->
      $('#modal-pinboard').slick({rows:1})
    ,2000)

#    Blaze.renderWithData(Template.individualNewStoryZone,{seq:seq,nodePhoto:nodePhoto,nodeTitle:nodeTitle,nodeDescription:nodeDescription},document.getElementById('story-zone'))

  'click .zone-deck':(e)->

    deckId = $(e.currentTarget).attr("id").split("-")[2]

    setDeckId(deckId)
    if platforms.findOne().profiles?
      for p in platforms.findOne().profiles
        if p.name is Meteor.user().profile
          if p.variants?
            for v in p.variants
              if v[deckId]?
                setVariantToShow(v[deckId])
    if !variantToShow?
      setVariantToShow('Basic')
    setCurrentDeckId(deckId)
    initDeck()
    #    $('#story-zone').append('')
    showModal('homePage',{},'main-wrapper-page')
#    Blaze.renderWithData(Template.homePage,{deckId:deckId},document.getElementById("story-zone"))

  'click .exit-deck':(e)->
#    TODO change isnt to is ..done for demo
    if $('.active').has('iframe').length isnt  0
      setTime(getTime());
      minTime = $('.center-panel:visible').find(".slide-wrapper").attr("min-time");
      maxTime = $('.center-panel:visible').find(".slide-wrapper").attr("max-time");
      points = $('.center-panel:visible').find(".slide-wrapper").attr("points");
      setCurrentSlideScore(minTime, maxTime, points);
    if $('.slide-container.active').length is 1
      setTime(getTime());
      minTime = $('.center-panel:visible').find(".slide-wrapper").attr("min-time");
      maxTime = $('.center-panel:visible').find(".slide-wrapper").attr("max-time");
      points = $('.center-panel:visible').find(".slide-wrapper").attr("points");
      setCurrentSlideScore(minTime, maxTime, points);
    setTimeout(()->
      endAttempt()
    ,2000)
    
    # endAttempt()
    cancelFullScreen("#viewPPTModal")

    $('.projection').remove();
    $('.story-zone-playbar').remove();
    $('.modal').modal('hide')
    

    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})


  'click .fullscreener':(e)->
    toggleFull("#viewPPTModal")
