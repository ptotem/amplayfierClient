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
      @render()

Router.route '/storyWrapper',
  template: 'storyWrapper',
  name: 'storyWrapper',
  data:()->
    someRandomData = "This is just testing...."
