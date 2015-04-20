Template.mainWrapper.rendered = ->
  setTitle(storyConfig.name)
  window.storyConfig.imgsrc = Meteor.settings.public.mainLink + window.storyConfig.imgsrc
  initPage()
  setTimeout(()->
    $('.story-node').popover({trigger:'hover',html: true})

  ,4000)

Template.mainWrapper.created = ()->
  s = platforms.findOne().storyConfig
  window.storyConfig = JSON.parse(s);

Template.mainWrapper.helpers
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
  getNodeUrl:(pic)->
      "<img class='popover-photo' src='"+Meteor.settings.public.mainLink+storyConfig.imgsrc + "/" + pic + "' />"
  getPlacement:(px)->
    if px < 50
      "right"
    else
      "left"
  getNodeStatus:(seq)->
    if userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq})?

      "<div class='popover-content-block complete-popover-content'>Complete</div>"
    else
      "<div class='popover-content-block incomplete-popover-content'>Incomplete</div>"
