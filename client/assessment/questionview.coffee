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


Template.assessmentQuestion.events
  'mouseover .ratings_stars':(e)->
    newSrc="../assets/questionview/whitestar.png"
    originalSrc="../assets/questionview/bluestar.png"
    $(e.currentTarget).attr("src", newSrc).prevAll('.ratings_stars').attr("src", newSrc);
    if $(e.currentTarget).attr("src") == newSrc
      $(e.currentTarget).nextAll('.ratings_stars').attr("src", originalSrc);
    $(".ratings_div img[src='../assets/questionview/whitestar.png']").length;
    console.log("count---" + $(".ratings_div img[src='../assets/questionview/whitestar.png']").length);
