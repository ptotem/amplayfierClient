Template.iframeWrapper.rendered =->
  # Meteor.call('userIdOfClient',Meteor.userId())
  console.log "wrapper"
  $("#quoScoreIframe").attr("data", "http://lvh.me:4002/presentation/show/GQdvHc9cNznWjM8if/" + Meteor.userId())
