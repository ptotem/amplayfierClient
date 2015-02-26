# Router.onRun (->
#     if !Meteor.userId()?
#         this.render("loading")
#         # createNotification(errorMessages.loginFristError,0)
#         window.location = "/login"
#     else
#       if this.path is "/" and headers.get('host').split(".").length is 3
#         window.location = "platform/"+headers.get('host').split(".")[0]
#       else
#         this.render()
#     return
#   ),
#   # except: ["login","store","listing","platforPreview","resetpassword","signup"]
#   except: ["login"]





Router.route '/login',
    template: "loginPage",
    name:'login',
    data:()->
      pname =  headers.get('host').split('.')[0]
      {platformName:pname}
    waitOn:()->
      [Meteor.subscribe('loginPlatform',this.data().platformName)]
    action: ->
      if @ready
        setPlatform(this.data().platformName)
        @render()


Router.route '/',
  template: 'deckList',
  name:'platformData',
  data:()->
    pname =  headers.get('host').split('.')[0]
    {platformName:pname}
  waitOn:()->
    [Meteor.subscribe('platformData',this.data().platformName)]
  action: ->
    @render()

Router.route '/showdeck/:did',

  template: 'homePage',
  name:'deckData',
  data:()->
    {deckId:this.params.did}
  waitOn:()->
    [Meteor.subscribe('thisDeck',this.data().deckId)]
  action: ->
    if @ready()
      @render()

Router.route '/admin',

  template: 'adminpanel',
  name:'admin',
  data:()->
    pname =  headers.get('host').split('.')[0]
    {platformName:pname}
  waitOn:()->
    [Meteor.subscribe('platformData',this.data().platformName),Meteor.subscribe('excelFiles'),Meteor.subscribe('usersOfPlatform',this.data().platformName)]
  action: ->
    if @ready()
      setPlatform(this.data().platformName)
      setTenant(this.data().platformName)
      @render()

Router.route '/storyWrapper',
  template: 'storyWrapper',
  name: 'storyWrapper',
  data:()->
    pname =  headers.get('host').split('.')[0]
    {platformName:pname}
  waitOn:()->
    [Meteor.subscribe('platformData',this.data().platformName),Meteor.subscribe('thisJs')]
  action:()->
    if @ready()
      setPlatform(this.data().platformName)
      @render()
    else
      @render('loading')


Router.route '/indexreport',
  template: 'reportIndex',
  name: 'reportIndex',

#
Router.route '/deckreport',
 template: 'adminDeckReport',
 name: 'deckreport',
 data:()->
   pname =  headers.get('host').split('.')[0]
   {platformName:pname}
 waitOn:()->
   [Meteor.subscribe('indexReport')]
