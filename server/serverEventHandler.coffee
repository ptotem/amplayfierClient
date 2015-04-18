
@setScore = (newVal)->
  console.log "Score is incremented"
  console.log newVal



@setCurrency = (args)->
  Meteor.users.update({_id:args[0]},{$set:{currency:args[1]}})

@deckComplete  = ()->
  console.log "deck is marked as complete on server"

@registerLogin = (args)->
  Meteor.users.update({_id:args['uid']},{$inc:{loginCount:1}})
  if Meteor.users.findOne(args['uid']).loginCount is 1
    firstLand.assign(args)

@getScore = (uid)->
  Meteor.users.findOne(uid).score || 0
@getCurrency = (uid)->
  Meteor.users.findOne(uid).currency || 0

@chapterComplete  = (args)->
  i = parseInt(args['node'])
  nn = platforms.findOne(args['pid']).nodes[i].title
  nnn = platforms.findOne(args['pid']).nodes[i+1].title
  assessmentNode = platforms.findOne(args['pid']).nodes[i].assessmentNode
  if assessmentNode == true
   setAssessmentId = platforms.findOne(args['pid']).nodes[i].selAssessment
   platformName = platforms.findOne(args['pid']).tenantName
   console.log platformName = platforms.findOne(args['pid']).tenantName
   console.log "Assessment Mail Sending"
   sendGeneralMail(decodeEmail(Meteor.users.findOne(args['uid']).personal_profile.email,platformName),"Congratulations !",'assessmentMail',{uname:"Rakesh",email:'rakesh@ptotem.com',nodename:nn,nextnodename:nnn,link:Meteor.absoluteUrl()+"assessment/"+setAssessmentId+"/"+ Meteor.users.findOne(args['uid']).personal_profile.reportingManager})



@allChapterComplete  = (args)->
  ""


#  if args['dids']?
#    for d in args['dids']
#      console.log reports.findOne({userId:args['uid'],deckId:d})

#    console.log args
#    console.log "chapter is marked as complete on srrver"
