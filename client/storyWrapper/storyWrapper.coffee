Template.storyWrapper.rendered = () ->
  initPage()

Template.storyWrapper.events ->
  'click .someBtn': (e) ->
    console.log(e)
