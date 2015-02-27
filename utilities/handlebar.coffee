UI.registerHelper "processPPT", (id)->
  convertPptxToDeck(id)

UI.registerHelper "platformWizardHeader", ()->
  pageHeaders[Session.get('showContent')];
UI.registerHelper "platformWizardHelp", ()->
  pageHelp[Session.get('showContent')];

UI.registerHelper "linksForPage", ()->
  pageSideLinks[Session.get('showContent')];




UI.registerHelper "isEquals", (a,b)->

  a is b


UI.registerHelper "timestampToDate", (tm)->
  timeStampToDate(tm)
UI.registerHelper "getUserName", (uid)->
  if uid is Meteor.userId()
    "me"
  else
    Meteor.findOne(uid).personal_profile.display_name

UI.registerHelper "timestampToTime", (tm)->
  timeStampToTime(tm)

UI.registerHelper "getImageFromAsset", (aid)->
  getImageFromAsset(aid)
UI.registerHelper "uploadStatus", (aid)->
  if gameFiles.findOne(aid)?
    gameFiles.findOne(aid).isUploaded()

UI.registerHelper "wrapperUploadStatus", (aid)->
  if wrapperFiles.findOne(aid)?
    wrapperFiles.findOne(aid).isUploaded()

UI.registerHelper "isWrapProcessed", (aid)->
  if wrapperFiles.findOne(aid)?
    wrapperFiles.findOne(aid).processed




UI.registerHelper "getLoginType", ( _id)->
  if Object.keys(Meteor.users.findOne(_id).services).length is 0
    "Manual"
  else
    Object.keys(Meteor.users.findOne(_id).services)[0]
UI.registerHelper "getTitle" , (key)->
    ribbonTitles[key]

UI.registerHelper "decodeUserEmail" , (email)->
    if email?
      decodeEmail(email)
