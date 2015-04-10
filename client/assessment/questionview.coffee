Template.assessmentQuestion.helpers
  assessments: ()->
    assesments.find().fetch()

  assessmentsQues: (aid)->
    assesments.findOne(aid).scoreQuestions

  loopCount: (count) ->
    countArr = []
    i = 0
    while i < count
      countArr.push {}
      i++
    countArr


