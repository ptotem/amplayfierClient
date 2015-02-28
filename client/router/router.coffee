Router.onBeforeAction (->
  # all properties available in the route function
  # are also available here such as this.params
  console.log "---------------------------"
  console.log Meteor.userId()
  if !Meteor.userId()?
    # if the user is not logged in, render the Login template
    @render 'loading'
    console.log "/login"
    window.location = "/login"
  else
    # otherwise don't hold up the rest of hooks or our route/action function
    # from running
    console.log "/loginNExt"
    @next()
  return
  ),{except:['login']}



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
    if @ready
      @render()
    else
      @render('loading')

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
    console.log pname
    {platformName:pname}
  waitOn:()->
    [Meteor.subscribe('platformData',this.data().platformName),Meteor.subscribe('excelFiles'),Meteor.subscribe('allUsers')]
  action: ->
    if @ready()
      console.log "ddd"
      setPlatform(this.data().platformName)
      setTenant(this.data().platformName)
      @render()
    else
      @render('loading')

Router.route '/storyWrapper',
  template: 'storyWrapper',
  name: 'storyWrapper',
  data:()->
    pname =  headers.get('host').split('.')[0]
    {platformName:pname}
  waitOn:()->
    [Meteor.subscribe('platformData',this.data().platformName),Meteor.subscribe('thisJs'),Meteor.subscribe('gameQuestionbank'),Meteor.subscribe('customizationDecks')]
  action:()->
    if @ready()
      setPlatform(this.data().platformName)
      @render()
    else
      @render('loading')


Router.route '/indexreport',
  template: 'reportIndex',
  name: 'reportIndex',
  waitOn:()->
    [Meteor.subscribe('indexReport')]

#
Router.route '/deckreport',
 template: 'adminDeckReport',
 name: 'deckreport',
 data:()->
   pname =  headers.get('host').split('.')[0]
   {platformName:pname}
 waitOn:()->
   [Meteor.subscribe('indexReport')]
