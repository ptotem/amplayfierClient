Template.storyWrapperTest.rendered = ->
  setTitle(storyConfig.name)
  window.storyConfig.imgsrc = Meteor.settings.public.mainLink + window.storyConfig.imgsrc
#  $("#story-wrapper").fadeIn(2000)

  $('#pinBoot').pinterest_grid({
    no_columns: 4,
    padding_x: 10,
    padding_y: 10,
    margin_bottom: 50,
    single_column_breakpoint: 700
  });
  $('.story-node[seq="7"]').removeClass('inactive-node')
  $('.story-node[seq="14"]').removeClass('inactive-node')
  $('.story-node[seq="16"]').removeClass('inactive-node')

Template.storyWrapperTest.created = ()->
  s = platforms.findOne().storyConfig
  window.storyConfig = JSON.parse(s);



Template.storyWrapperTest.helpers
  nodes : ()->
    platforms.findOne().nodes
  storyHeading:()->
    storyConfig.name
  getNodeStatusPic:(seq)->
    if seq isnt 0
      if !userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq-1})?
        return Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + platforms.findOne().nodes[seq].incomplete

    if userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq})?

      Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + platforms.findOne().nodes[seq].complete
    else
      Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + platforms.findOne().nodes[seq].active



Template.storyWrapperTest.events
  'click .pepsi-home':(e)->
    $('#story-wrapper').fadeOut(1000)
    $(".wrapper-story").fadeIn(1500)



  'click .story-node':(e)->
    $('.story-node').css({
      "pointer-events": "none",

#      opacity: 0

    });
    $('.story-zone-wrapper').show()
    $('.story-zone-wrapper').css({
        'z-index':1,
        'background-color': 'rgba(0,0,0,'+0.5+')'
    })
#    $('#story-zone').empty()
    seq = $(e.currentTarget).attr('seq')
    node = platforms.findOne().nodes[seq]
    nodePhoto = storyConfig.imgsrc + "/" + node.photo
    nodeTitle = node.title
    nodeDescription = node.description
    Blaze.renderWithData(Template.individualStoryZone,{seq:seq,nodePhoto:nodePhoto,nodeTitle:nodeTitle,nodeDescription:nodeDescription},document.getElementById('story-zone'))
    $('#story-zone').fadeIn()
  'keyup #chat-user-search':(e)->
    searchBar($(e.currentTarget).val(),".chat-row")


  'click .redeem-reward':(e)->
    if this.stock is 0
      createNotification("Sorry out of stock",0)
    if this.value > currency.getValue()
      createNotification("You do not have enough credits",0)
    Meteor.call('redeemReward',Meteor.userId(),this._id,(err,res)->
      if res
        createNotification("Reward is redeemed, you would have got an email",1)

    )

  'click .btn-logout':(e)->
    Meteor.logout()
  'click .user-edit-btn':(e)->
    $('.modal').modal('hide')
    $('.user-edit-form').remove()
    Blaze.renderWithData(Template['userEditForm'], {}, document.getElementById('story-wrapper'))
    $(".modal").modal()

#  'click .fullscreener':(e)->
#    Blaze.renderWithData(Template.homePage,{deckId:currentDisplayedDeckId},document.getElementsByClassName("projector")[0])
  'click #noti-link':(e)->
    setTimeout(()->
      markAllNotiRead(Meteor.userId())
    ,2000)



  'click #story-block-close':(e)->
    if $('.active').has('iframe').length is 0
      setTime(getTime());
      minTime = $('.center-panel:visible').find(".slide-wrapper").attr("min-time");
      maxTime = $('.center-panel:visible').find(".slide-wrapper").attr("max-time");
      points = $('.center-panel:visible').find(".slide-wrapper").attr("points");
      setCurrentSlideScore(minTime, maxTime, points);
    endAttempt()

    $('.projection').remove();
    $('.story-zone-playbar').remove();




  'click .zone-deck':(e)->


    deckId = $(e.currentTarget).attr("id").split("-")[2]


    setDeckId(deckId)
    if platforms.findOne().profiles?
      for p in platforms.findOne().profiles
        if p.name is Meteor.user().profile
          console.log p.name
          for v in p.variants
            if v[deckId]?
              setVariantToShow(v[deckId])



    if !variantToShow?
      setVariantToShow('Basic')



    # variantToShow = v[deckId]

    #    markModuleAsComplete(deckId,Meteor.userId(),tenantId,"true")


    setCurrentDeckId(deckId)
    initDeck()
    #    $('#story-zone').append('')
    Blaze.renderWithData(Template.homePage,{deckId:deckId},document.getElementById("story-zone"))


  'click #dashboard-launcher':(e)->
    initDash()
