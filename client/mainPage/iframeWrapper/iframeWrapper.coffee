Template.iframeWrapper.rendered =->
# "qvotASbgwJhzJ5Bao"
# "atZoaaK5nqYsF9hTF"
  team = Meteor.users.findOne({_id:Meteor.userId()}).team
  console.log team
  $("#quoScoreIframe").attr("data", Meteor.settings.public.quodeckIP + "/presentation/show/"+creatorSeq+"/"+ Meteor.userId()+"/"+team)
