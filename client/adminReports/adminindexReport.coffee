Template.adminDeckReport.helpers
  allReports:()->
    reports.find().fetch()

Template.adminDeckReport.rendered = () ->
  $('#example').DataTable()
