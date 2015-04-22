 Template.addvariantModal.events
   'click .remove-modal':(e)->
     $('.modal').modal('hide')
     $('.modal').remove()
     $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})
