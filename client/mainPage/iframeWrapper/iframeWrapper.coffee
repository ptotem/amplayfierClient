Template.iframeWrapper.rendered =->
# "qvotASbgwJhzJ5Bao"
# "atZoaaK5nqYsF9hTF"
  team = Meteor.users.findOne({_id:Meteor.userId()}).team
  $("#quoScoreIframe").attr("src", Meteor.settings.public.quodeckIP + "/presentation/show/"+creatorSeq+"/"+ Meteor.userId()+"/"+team)
