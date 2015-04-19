Template.wrapperSideBar.rendered = ->
    $('.side-bar-link').popover({trigger:'hover',html: true,delay: { "show": 500, "hide": 100 }})


Template.wrapperSideBar.events
  'click .notification-link':(e)->
    showModal('notificationModal',{},'main-wrapper-page')

Template.notificationModal.helpers
  notiPassKey:()->
    {ukey:platforms.findOne()._id}
Template.notificationModal.events
  'click .remove-modal':(e)->

    $('.modal').modal('hide')
    $('.modal').remove()


