Template.wrapperSideBar.rendered = ->
    $('.side-bar-link').popover({trigger:'hover',html: true,delay: { "show": 500, "hide": 100 }})


Template.wrapperSideBar.events
  'click .notification-link':(e)->
    showModal('notificationModal',{},'main-wrapper-page')
  'click .document-link':(e)->
    showModal('documentModal',{},'main-wrapper-page')
  'click .reward-link':(e)->
    showModal('rewardModal',{},'main-wrapper-page')

  'click .badge-link':(e)->
    showModal('badgeModal',{},'main-wrapper-page')



Template.notificationModal.helpers
  notiPassKey:()->
    {ukey:platforms.findOne()._id}


Template.rewardModal.helpers
  rewards:()->
    systemRewards.find().fetch()
Template.badgeModal.helpers
  sysBadges1:()->
   systemBadges.find({}).fetch()[0..4]
  sysBadges2:()->
   systemBadges.find({}).fetch()[5..9]


Template.mainWrapper.events
  'click .remove-modal':(e)->

    $('.modal').modal('hide')
    $('.modal').remove()

Template.badgeModal.rendered = ->
  $($('.badge-item')[0]).addClass('col-md-offset-1')
  $($('.badge-item')[5]).addClass('col-md-offset-1')

