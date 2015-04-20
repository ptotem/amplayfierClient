Template.mainWrapper.rendered = ->
  setTitle(storyConfig.name)
  window.storyConfig.imgsrc = Meteor.settings.public.mainLink + window.storyConfig.imgsrc
  initPage()
  setTimeout(()->
    $('.story-node').popover({trigger:'hover',html: true})

  ,1000)

Template.mainWrapper.created = ()->
  s = platforms.findOne().storyConfig
  window.storyConfig = JSON.parse(s);

Template.mainWrapper.helpers
  getPrecTop : (top)->

    return top - 1.5
  getPrecLeft:(left1)->
    left1 - 0.5

  getNamePlate : ()->
    Meteor.settings.public.mainLink+storyConfig.imgsrc + "/" + storyConfig.nameplate.image
  getStoryPresenter: ()->
    Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + storyConfig.presenter.image
  getBackColor: ()->
    storyConfig.background.color || "#000000"
  getBackImg: ()->
    Meteor.settings.public.mainLink+storyConfig.imgsrc + "/" + storyConfig.background.image
  nodes : ()->
#    platforms.findOne().nodes
     sc.nodes
  storyHeading:()->
#    storyConfig.name
    sc.name
  getNodeStatusPic:(seq)->

    if seq isnt 0
      if !userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq-1})?
#        return Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + sc.nodes[seq].incomplete
        return Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + platforms.findOne().nodes[seq].incomplete

    if userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq})?

#      Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + sc.nodes[seq].complete
      Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + platforms.findOne().nodes[seq].complete

    else
#      Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + sc.nodes[seq].active
      Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + platforms.findOne().nodes[seq].active
  getNodeUrl:(pic)->
      "<img class='popover-photo' src='"+Meteor.settings.public.mainLink+storyConfig.imgsrc + "/" + pic + "' />"
  getPlacement:(px)->
    if px < 50
      "right"
    else
      "left"
  getNodeStatus:(seq)->
    if seq isnt 0
      if !userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq-1})?
        return "<div class='popover-content-block incomplete-popover-content'>Incomplete</div>"
    #        return Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + platforms.findOne().nodes[seq].incomplete

    if userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq})?

      "<div class='popover-content-block complete-popover-content'>Complete</div>"
    else
      "<div class='popover-content-block active-popover-content'>Active</div>"

  getNodeStatusClass:(seq)->
    if seq isnt 0
      if !userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq-1})?
        return "my-incomplete-node"
    #        return Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + platforms.findOne().nodes[seq].incomplete

    if userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq})?

      "my-complete-node"
    else
      "my-active-node"




Template.mainWrapper.events
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
    node = platforms.findOne().nodes[seq]
    nodePhoto = storyConfig.imgsrc + "/" + node.photo
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
#    setTimeout(()->
#      $('#modal-pinboard').slick({rows:1})
#    ,2000)

#    Blaze.renderWithData(Template.individualNewStoryZone,{seq:seq,nodePhoto:nodePhoto,nodeTitle:nodeTitle,nodeDescription:nodeDescription},document.getElementById('story-zone'))

  'click .zone-deck':(e)->

    deckId = $(e.currentTarget).attr("id").split("-")[2]

    setDeckId(deckId)
    if platforms.findOne().profiles?
      for p in platforms.findOne().profiles
        if p.name is Meteor.user().profile
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
    if $('.active').has('iframe').length is 0
      setTime(getTime());
      minTime = $('.center-panel:visible').find(".slide-wrapper").attr("min-time");
      maxTime = $('.center-panel:visible').find(".slide-wrapper").attr("max-time");
      points = $('.center-panel:visible').find(".slide-wrapper").attr("points");
      setCurrentSlideScore(minTime, maxTime, points);
    endAttempt()
    $('.modal').modal('hide')



