Router.onBeforeAction (->
  # all properties available in the route function
  # are also available here such as this.params
  if !Meteor.userId()
    # if the user is not logged in, render the Login template
    @render 'loginPage'
  else
    # otherwise don't hold up the rest of hooks or our route/action function
    # from running
    @next()
  return
  ),{except:['login','admin']}


Router.route '/login',
    template: "loginPage",
    name:'login',
    data:()->
      pname =  headers.get('host').split('.')[0]
      {platformName:pname}
    action: ->
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
      setTenant()
      @render()

Router.route '/storyWrapper',
  template: 'storyWrapper',
  name: 'storyWrapper',
  data:()->
    someRandomData = "This is just testing...."
