Template.wrapperSideBar.rendered = ->
    $('.side-bar-link').popover({trigger:'hover',html: true,delay: { "show": 500, "hide": 100 }})


Template.wrapperSideBar.events
  'click .notification-link':(e)->
    showModal('notificationModal',{},'main-wrapper-page')
  'click .document-link':(e)->
    showModal('documentModal',{},'main-wrapper-page')
  'click .reward-link':(e)->
    showModal('rewardModal',{},'main-wrapper-page')



Template.notificationModal.helpers
  notiPassKey:()->
    {ukey:platforms.findOne()._id}


Template.rewardModal.helpers
  rewards:()->
    systemRewards.find().fetch()


Template.mainWrapper.events
  'click .remove-modal':(e)->

    $('.modal').modal('hide')
    $('.modal').remove()



