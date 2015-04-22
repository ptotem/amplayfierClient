Template.addvariantModal.events
  'click .remove-modal': (e)->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"})

Template.newAssessmentModal.events
  'click .remove-modal': (e)->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"})

  'click .new-assessment-for-admin-save': (e)->
    newassessment = $("#new-assessment").val()
    assesments.insert({assessmentName: newassessment, platform: platforms.findOne()._id})
    $('.remove-modal').click()