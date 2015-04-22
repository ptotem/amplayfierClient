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

Template.newQuestionForAssessmentModal.events
  'click .remove-modal': (e)->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"})

  'click .new-question-for-admin-save': (e)->
    nqName = $("#new-question-name").val()
    nqMax = $("#new-question-max").val()
    nqMin = $("#new-question-min").val()
    manualData = {statement: nqName, min: nqMin, max: nqMax}
    assesments.update({_id: Session.get("newquesId")}, {$push: {scoreQuestions: manualData}})
# assesments.update({statement:nqName,min:nqMin,max:nqMax,platform:platforms.findOne()._id,_id:assesments.findOne()._id})

Template.viewQuestionsForAssessmentModal.events
  'click .remove-modal': (e)->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"})

Template.viewQuestionsForAssessmentModal.helpers
  viewQuestion:()->
    assesments.findOne(Session.get("viewquesId")).scoreQuestions