@availablePlatform = (platName)->
  Meteor.call("isPlatformAvailable",platName,(err,res)->
    if res is false
      window.location = "/notAuthorised"
  )






Router.onBeforeAction (->
   # First check if the platform exists. If it does not, then just show the unauthorized page.
   pname = headers.get('host').split('.')[0]
   availablePlatform(pname)
   # If the control is here that means the platform exists...
   if !Meteor.userId()? and Router.current().url.indexOf('reset-password') is -1
     # if the user is not logged in, render the Login template
     @render 'loading'

     window.location = "/login"
   else
     # otherwise don't hold up the rest of hooks or our route/action function
     # from running

     @next()
   return
   ),{except:['login','notAuthorised','forgot','reset']}



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
        # availablePlatform(this,this.data().platformName)
        @render()
      else
        @render('loading')

Router.route '/forgotpassword',
  template: "forgotPassword",
  name:'forgot',
  data:()->
    pname =  headers.get('host').split('.')[0]
    {platformName:pname}
  action:()->
    setPlatform(this.data().platformName)

    @render()





Router.route '/reset-password/:token',
  template: "resetPassword",
  name:'reset',
  data:()->
    {token:this.params.token}
  action:()->
    setToken(this.data().token)
    @render()


Router.route '/deckList',
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

Router.route '/admintest',
  template: 'adminpanel',
  name:'admin',
  data:()->
    pname =  headers.get('host').split('.')[0]
    console.log pname
    {platformName:pname}
  waitOn:()->
    [Meteor.subscribe('scoreQuestions',this.data().platformName),Meteor.subscribe('assesments',this.data().platformName),Meteor.subscribe('platformAssetFiles',this.data().platformName),Meteor.subscribe('platformRewards',this.data().platformName),Meteor.subscribe('repositoryFiles',this.data().platformName),Meteor.subscribe('platformData',this.data().platformName),Meteor.subscribe('usersOfPlatform',this.data().platformName),Meteor.subscribe('excelFiles'),Meteor.subscribe('thisUser',Meteor.userId())]
  action: ->
    if @ready()

      setPlatform(this.data().platformName)
      setTenant(this.data().platformName)
      @render()
    else
      @render('loading')

Router.route '/admin',
  template: 'mainAdminPanel',
  name:'admintest',
  data:()->
    pname =  headers.get('host').split('.')[0]
    console.log pname
    {platformName:pname}
  waitOn:()->
    [Meteor.subscribe('badges'),Meteor.subscribe('userAssetFiles',Meteor.userId()),Meteor.subscribe('scoreQuestions',this.data().platformName),Meteor.subscribe('assesments',this.data().platformName),Meteor.subscribe('platformAssetFiles',this.data().platformName),Meteor.subscribe('platformRewards',this.data().platformName),Meteor.subscribe('repositoryFiles',this.data().platformName),Meteor.subscribe('platformData',this.data().platformName),Meteor.subscribe('usersOfPlatform',this.data().platformName),Meteor.subscribe('excelFiles'),Meteor.subscribe('thisUser',Meteor.userId()),Meteor.subscribe('messages')]
  action: ->
    if @ready()

      setPlatform(this.data().platformName)
      setTenant(this.data().platformName)
      @render()
    else
      @render('loading')



Router.route '/assessment/:aid/:mid',
  template: 'assessmentQuestion',
  name:'assessment',
  data:()->
    pname =  headers.get('host').split('.')[0]
    {assessmentId:this.params.aid,managerId:this.params.mid,platformName:pname}
  waitOn:()->
    [Meteor.subscribe('thisAssessment',this.data().assessmentId),Meteor.subscribe('assesmentScore',this.data().platformName),Meteor.subscribe('platformData',this.data().platformName)]
  action: ->
    if @ready()
      setAssessmentId(this.data().assessmentId)
      setManagerId(this.data().managerId)
      @render()
    else
      @render('loading')

Router.route '/wrapperpage',
  template: 'wrapperPage',
  name:'wrapperpage',




Router.route '/storytestold',
  template: 'storyWrapper',
  name: 'storyWrapper',
  data:()->
    pname =  headers.get('host').split('.')[0]
    {platformName:pname}
  waitOn:()->
    [Meteor.subscribe('platformAssetFiles',this.data().platformName),Meteor.subscribe('platformRewards',this.data().platformName),Meteor.subscribe('usersOfPlatform',this.data().platformName),Meteor.subscribe('userAssetFiles',Meteor.userId()),Meteor.subscribe('userCompletions',this.data().platformName,Meteor.userId()),Meteor.subscribe('platformData',this.data().platformName),Meteor.subscribe('thisJs'),Meteor.subscribe('gameQuestionbank'),Meteor.subscribe('customizationDecks'),Meteor.subscribe('thisUser',Meteor.userId()), Meteor.subscribe('indexReport'),Meteor.subscribe('panelReport')]
  action:()->
    if @ready()
      setPlatform(this.data().platformName)
      setTenant(this.data().platformName)

      @render()
    else
      @render('loading')

Router.route '/story',
  template: 'storyWrapperTest',
  name: 'storyWrapperTest',
  data:()->
    pname =  headers.get('host').split('.')[0]
    {platformName:pname}
  waitOn:()->
    [Meteor.subscribe('platformAssetFiles',this.data().platformName),Meteor.subscribe('platformRewards',this.data().platformName),Meteor.subscribe('usersOfPlatform',this.data().platformName),Meteor.subscribe('userAssetFiles',Meteor.userId()),Meteor.subscribe('userCompletions',this.data().platformName,Meteor.userId()),Meteor.subscribe('platformData',this.data().platformName),Meteor.subscribe('thisJs'),Meteor.subscribe('gameQuestionbank'),Meteor.subscribe('customizationDecks'),Meteor.subscribe('thisUser',Meteor.userId()), Meteor.subscribe('indexReport'),Meteor.subscribe('panelReport')]
  action:()->
    if @ready()
      setPlatform(this.data().platformName)
      setTenant(this.data().platformName)

      @render()
    else
      @render('loading')

Router.route '/oldpepsi',
  template: 'wrapperPage',
  name: 'wrapperPage',
  data:()->
    pname =  headers.get('host').split('.')[0]
    {platformName:pname}
  waitOn:()->
    [Meteor.subscribe('plaformUserFeedbacks',this.data().platformName),Meteor.subscribe('badges'),Meteor.subscribe('platformAssetFiles',this.data().platformName),Meteor.subscribe('platformRewards',this.data().platformName),Meteor.subscribe('usersOfPlatform',this.data().platformName),Meteor.subscribe('userAssetFiles',Meteor.userId()),Meteor.subscribe('userCompletions',this.data().platformName,Meteor.userId()),Meteor.subscribe('platformData',this.data().platformName),Meteor.subscribe('thisJs'),Meteor.subscribe('gameQuestionbank',this.data().platformName),Meteor.subscribe('customizationDecks'),Meteor.subscribe('thisUser',Meteor.userId()), Meteor.subscribe('indexReport'),Meteor.subscribe('panelReport')]
  action:()->
    if @ready()
      setPlatform(this.data().platformName)
      setTenant(this.data().platformName)

      @render()
    else
      @render('loading')

Router.route '/',
  template: 'mainWrapper',
  name: 'mainWrapper',
  data:()->
    pname =  headers.get('host').split('.')[0]
    {platformName:pname}
  waitOn:()->
    [Meteor.subscribe('plaformUserFeedbacks',this.data().platformName),Meteor.subscribe('badges'),Meteor.subscribe('platformAssetFiles',this.data().platformName),Meteor.subscribe('platformRewards',this.data().platformName),Meteor.subscribe('usersOfPlatform',this.data().platformName),Meteor.subscribe('userAssetFiles',Meteor.userId()),Meteor.subscribe('userCompletions',this.data().platformName,Meteor.userId()),Meteor.subscribe('platformData',this.data().platformName),Meteor.subscribe('thisJs'),Meteor.subscribe('gameQuestionbank',this.data().platformName),Meteor.subscribe('customizationDecks'),Meteor.subscribe('thisUser',Meteor.userId()), Meteor.subscribe('indexReport'),Meteor.subscribe('panelReport'),Meteor.subscribe('messages')]
  action:()->
    if @ready()
      setPlatform(this.data().platformName)
      setTenant(this.data().platformName)

      @render()
    else
      @render('loading')




Router.route '/indexreport',
  template: 'reportIndex',
  name: 'reportIndex',
  waitOn:()->
    [Meteor.subscribe('indexReport')]




Router.route '/setpassword/:uid/',
  template: 'setpassword',
  name: 'setPassword',
  data:()->
    {uid:this.params.uid}



Router.route '/deckreport',
 template: 'adminDeckReport',
 name: 'deckreport',
 data:()->
   pname =  headers.get('host').split('.')[0]
   {platformName:pname}
 waitOn:()->
   [Meteor.subscribe('indexReport')]


Router.route '/notAuthorised',
  template: 'notAuthorised',
  name: 'notAuthorised',
