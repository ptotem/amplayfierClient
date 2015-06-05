
UI.registerHelper "isLoggedIn", ->

  Meteor.userId()?


UI.registerHelper "addition", (a,b)->

  parseInt(a) + parseInt(b)



UI.registerHelper "getCurrentUserEmail", ->

  #    small helper that reads the application name from the configuration file
  unless Meteor.user() is `undefined`
    Meteor.user().emails[0].address
  else
    "someone@hierodex.com"


UI.registerHelper "getUserId", ->

  #    small helper that reads the application name from the configuration file
  unless Meteor.user() is `undefined`
    Meteor.userId()
  else
    "someone@hierodex.com"

UI.registerHelper "getUserFullName", ->

  #    small helper that reads the application name from the configuration file
  if Meteor.user()?
    if Meteor.user().personal_profile?
      Meteor.user().personal_profile.first_name + " " + Meteor.user().personal_profile.last_name



UI.registerHelper "getUserEmailId",(uid) ->

  #    small helper that reads the application name from the configuration file
  unless Meteor.user() is `undefined`
    Meteor.users.findOne({_id:uid}).emails[0].address
  else
    "someone@hierodex.com"

UI.registerHelper "getAppTitle",() ->

  "Ptotemy"
UI.registerHelper "encode",(em) ->
  decodeEmail(em)



UI.registerHelper "notEquals", (a, b) ->
  a isnt b
UI.registerHelper "equals", (a, b) ->
  a is b
UI.registerHelper "getAssetUrl",(fileid) ->
  if assetFiles.findOne(fileid)?
    assetFiles.findOne(fileid).url()


UI.registerHelper "getGameImageUrl",(fileid) ->
  if assetFiles.findOne(fileid) is `undefined`
    "/admin/img/defaultback-game.gif"
  else
    assetFiles.findOne(fileid).url()


UI.registerHelper "getImageForStore",(tid) ->
  if tenants.findOne(tid).screenshots?
    assetFiles.findOne(tenants.findOne(tid).screenshots[0]).url()
  else
    "/assets/theme/images/product-1.png"




UI.registerHelper "getTenantName",(cartid) ->
  if tenants.findOne(cartid) is `undefined`
    ""
  else
    tenants.findOne(cartid).tenantName


UI.registerHelper "getTenantDesc",(cartid) ->
  if tenants.findOne(cartid) is `undefined`
    ""
  else
    tenants.findOne(cartid).desc


UI.registerHelper "getTenantPrice",(cartid) ->
  if tenants.findOne(cartid) is `undefined`
    ""
  else
    tenants.findOne(cartid).price

UI.registerHelper "getWrapperPic",(stryId) ->
  if assetFiles.findOne(stryId) is `undefined`
    "/admin/img/defaultback.gif"
  else
    assetFiles.findOne(stryId).url()

UI.registerHelper "publishTemplates",(tempid) ->
  if htemplates.findOne(tempid).published is false
    "fa-eye-slash"
  else
    "fa-eye"


UI.registerHelper "userCart",(cartid) ->
  if !Meteor.user()?
    "Add to cart"
  else
    userCarts=Meteor.users.findOne({_id:Meteor.userId()}).carts
    if userCarts?
      if userCarts.indexOf(cartid)>=0
        "Added to Cart"
      else
        "Add to Cart"
    else
      "Added to Cart"


UI.registerHelper "userCartClass",(cartid) ->
  if !Meteor.user()?
    "login-to-add"
  else

    userCarts=Meteor.users.findOne({_id:Meteor.userId()}).carts
    if userCarts?
      if userCarts.indexOf(cartid)>=0
        "already_added"
      else
        "add-to-cart"
    else
      "add-to-cart"


UI.registerHelper "isOptionSelected", (optionValue) ->
  dep.depend();
  if Session.get("activeComponent")?
    if deck?
      return (($(".slide-component").find("#" + Session.get("activeComponent")).attr("class").indexOf(optionValue)) isnt -1)
    else
      return (($("#" + Session.get("activeComponent")).attr("class").indexOf(optionValue)) isnt -1)



UI.registerHelper "getActiveComponentId", ->

  #    small helper that reads the application name from the configuration file
  Session.get("activeComponent") or "NA"

UI.registerHelper "getActiveComponentName", ->

  #    small helper that reads the application name from the configuration file
  $("#" + Session.get("activeComponent")).attr("compname") or "NA"
UI.registerHelper "getActiveComponentType", ->

  #    small helper that reads the application name from the configuration file
  $("#" + Session.get("activeComponent")).attr("component-type") or "NA"


UI.registerHelper "getActiveComponentClass", ->

  #    small helper that reads the application name from the configuration file
  $("#" + Session.get("activeComponent")).attr("class") or "NA"

UI.registerHelper "isSelectedComponentInLayer", (num) ->

  #    small helper that reads the application name from the configuration file
  $("#" + Session.get("activeComponent")).hasClass("layer" + num) or false

UI.registerHelper "activeComponent", ->
  Session.get("activeComponent") or false

UI.registerHelper "isPlatformMini", ->
  if tenants.findOne()?
   tenants.findOne().tenantType is "mini"


UI.registerHelper "isPlatformIntermediate", ->
    if tenants.findOne()?

      tenants.findOne().tenantType is "intermediate"

UI.registerHelper "isPlatformStandard", ->
    if tenants.findOne()?

      tenants.findOne().tenantType is "standard"

UI.registerHelper "isAdmin", ->
  Meteor.users.findOne({_id:tenants.findOne().admin}).personal_profile.email is "admin@ptotem.com"




UI.registerHelper "getCurrentUserName", ->

  #    small helper that reads the application name from the configuration file
  unless Meteor.user() is `undefined`
    if !Meteor.user().username?
      Meteor.user().personal_profile.email.split("@")[0]
    else
      Meteor.user().username
  else
    "someone"

UI.registerHelper "sanitizer", (ac,cv)->
  $(".slide-component").find("#"+ac).find(".actual-text").html(cv)
  $(".left-panel-preview").find("#"+ac).find(".actual-text").html(cv)



UI.registerHelper "blockUnblock",(uid) ->
  if blockedUsers.findOne({uid:uid}) is undefined
    "fa-pencil"
  else
    if blockedUsers.findOne({uid:uid}).blocked is "true"
      "fa-search-plus"
    else
      "fa-pencil"

UI.registerHelper "blockUnblockClass",(uid) ->
  if blockedUsers.findOne({uid:uid}) is undefined
    "block-users"
  else
    if blockedUsers.findOne({uid:uid}).blocked is "true"
      "unblock-users"
    else
      "block-users"


UI.registerHelper "customHtml",()->
  if homepagecustomize.findOne()?
    homepagecustomize.findOne().html


UI.registerHelper "blockUnblockPlatform",(uid) ->
  if blockedPlatform.findOne({tid:uid}) is undefined
    "fa-pencil"
  else
    if blockedPlatform.findOne({tid:uid}).blocked is "true"
      "fa-search-plus"
    else
      "fa-pencil"

UI.registerHelper "blockUnblockPlatformClass",(uid) ->
  if blockedPlatform.findOne({tid:uid}) is undefined
    "block-platform"
  else
    if blockedPlatform.findOne({tid:uid}).blocked is "true"
      "unblock-platform"
    else
      "block-platform"

UI.registerHelper "syncImage",() ->
  if platforms.findOne().platformSync is false
    "/assets/images/sync_icon_notification.png"


UI.registerHelper "previewImage",() ->
  if Meteor.users.findOne({_id:Meteor.userId()}).role is "admin"
    "/assets/images/preview_icon.png"

UI.registerHelper "adminImage",() ->
  if Meteor.users.findOne({_id:Meteor.userId()}).role is "admin"
    "/assets/images/admin_icon.png"

UI.registerHelper "styleForAdmin",() ->
  if platforms.findOne().platformSync is false
    "block"  
  else  
    "none"
UI.registerHelper "getContentTitle",() ->
  v = Session.get('contentVar')
  adminPanelContent[v]['title']
UI.registerHelper "getContentDesc",() ->
  v = Session.get('contentVar')
  adminPanelContent[v]['desc']
UI.registerHelper "getSpecificContentDesc",(v) ->
  adminPanelContent[v]['desc']


UI.registerHelper "getContentIcon",() ->
  v = Session.get('contentVar')
  adminPanelContent[v]['icon']

UI.registerHelper "getContentKeyText",() ->
  v = Session.get('contentVar')
  adminPanelContent[v]['keyText']

UI.registerHelper "getContentKeyTitle",() ->
  v = Session.get('contentVar')
  adminPanelContent[v]['keyTitle']





UI.registerHelper "getSpecificContentIcon",(v) ->
  
  adminPanelContent[v]['icon']


UI.registerHelper "getContentBoxColor",() ->
  v = Session.get('contentVar')
  adminPanelContent[v]['boxColor']
UI.registerHelper "getSpecificContentBoxColor",(v) ->
  
  adminPanelContent[v]['boxColor']


UI.registerHelper "isSwitchable",() ->
  v = Session.get('contentVar')
  adminPanelContent[v]['switchable']





UI.registerHelper "getPlatformName",() ->
  platforms.findOne().tenantName

UI.registerHelper "hasRewards",() ->
  systemRewards.find().fetch().length > 1



  #    small helper that reads the application name from the configuration file

  #    small helper that reads the application name from the configuration file
