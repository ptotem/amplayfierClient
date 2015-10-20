Template.resetAnalyticsModal.events
  'click .remove-modal':(e)->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-wrap').remove()
    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

  'click .reset-all-analytics':(e)->
    if window.confirm("Are you sure you want to delete all analytics?")
      x = DDP.connect(Meteor.settings.public.quodeckIP)
      deckList = platforms.findOne().quodecks
      x.call('removeAnalytics',deckList,(err, res)->
        if !err
          setTimeout(()->
            removeModal()
            createNotification('Successfully deleted all data', 1)
          ,500)
        else
          console.log err
      )

  'click .reset-analytics-of-tenant':(e)->
    if window.confirm("Are you sure you want to delete the analytics?")
      deckId = $(e.currentTarget).attr('id')
      x = DDP.connect(Meteor.settings.public.quodeckIP)
      x.call('removeAnalyticsOfTenant',deckId,(err, res)->
        if !err
          setTimeout(()->
            removeModal()
            createNotification('Successfully deleted the data', 1)
          ,500)
        else
          console.log err
      )

Template.resetAnalyticsModal.helpers
  listOfQuodecks:()->
    list=[]
    for i,j in platforms.findOne().quodecks
      list.push({id:i,round:"Round-"+(j+1)})
    list
