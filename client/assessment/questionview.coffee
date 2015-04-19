Template.assessmentQuestion.events
  'mouseover .ratings_stars': (e)->
    newSrc = "/../assets/questionview/whitestar.png"
    originalSrc = "/../assets/questionview/bluestar.png"
    $(e.currentTarget).attr("src", newSrc).prevAll('.ratings_stars').attr("src", newSrc);
    if $(e.currentTarget).attr("src") == newSrc
      $(e.currentTarget).nextAll('.ratings_stars').attr("src", originalSrc);
    $(".ratings_div img[src='/../assets/questionview/whitestar.png']").length;




  'click #statement-submit': (e)->
    selectedData = []
    pid = platforms.findOne()._id
    assess = assesmentScore.insert({platformId: pid, assessmentId: assessmentId, uid: managerId, curid: Meteor.userId()})
    $(".statementQue").each (i, v) ->
      statement = $(v).find('.subquestion').text()
      rating = $(v).find(".ratings_div img[src='/../assets/questionview/whitestar.png']").length;
      selectedData.push({statement: statement, rating: rating})
    assesmentScore.update({_id: assess}, {$set: {userScore: selectedData}})
    createNotification("Your Score has been recorded", 1)
    $('.modal').remove()
    Blaze.renderWithData(Template['assessmentModal'], {}, document.getElementById('assessment-container'))
    $('.modal').modal()


Template.assessmentQuestion.rendered = () ->
  if platforms.findOne()?
    pid = platforms.findOne()._id
    console.log assesmentScore.find({platformId: pid, assessmentId: assessmentId, uid: managerId, curid: Meteor.userId()}).fetch().length isnt 0
    if assesmentScore.find({platformId: pid, assessmentId: assessmentId, uid: managerId, curid: Meteor.userId()}).fetch().length is 0 ?
      $('#statement-submit').show()
    else
      $('#statement-submit').hide()
      setTimeout(()->
        alert("You had already give these assessment")
      ,200)




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


Template.assessmentModal.events

  'click .assessment-certify':(e)->
    Meteor.call('certifiedImg',Meteor.userId(),'CONGRATS!!!')
    $('.modal').remove()

  'click .assessment-certify-no':(e)->
    Meteor.call('updateFlunkCount',Meteor.userId())
    $('.modal').remove()
