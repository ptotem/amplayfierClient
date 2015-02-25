Template.reportIndex.helpers

Template.reportIndex.rendered = () ->
#  reports = reports.find().fetch()
  console.log(_.map(reports.find().fetch(), (num, key) ->
    num.slideId
  ))
