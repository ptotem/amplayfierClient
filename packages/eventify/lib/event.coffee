class @AppEvent
#  This is the main app event class. All the events defined would be objects of thisclass
#  The schema for the class :
#  name -> name of the event
#  type -> type of event [client,server,both]
#  handler -> the function to be invoked when the event is triggered
  constructor: (name,type,handler) ->
    @name = name
    @handler = handler
    @type = type

  trigger:(args)->
    prms = args || {}
    console.log prms
#    console.log arguments

    if this.type is 'client'

      window[this.handler[0]](prms)
    if this.type is 'server'
        Meteor.call('executeTriggerHandler',this.handler[0],prms,@name)
    if this.type is 'both'
        window[this.handler[0]](prms)
        Meteor.call('executeTriggerHandler',this.handler[0],prms,@name)






class @SysVar
#  This is the class definition for system variables.
#  The logic is you define a system variable and register it. Each badge has an affect on one of the system variable.
  constructor:(name)->
    @name = name
    @routineLogic = []
  assignGetValFunction:(gvf)->
    @getValFunc = gvf
  assignUpdateRoutine:(actionName,routineName)->
    @routineLogic.push {actionName:actionName,routineName:routineName}
    @routineName = routineName


  setValue:(newVal,uid)->
    Meteor.call('executeTriggerHandler',this.routineName,[uid,newVal],-1,(err,res)->
#      console.log res
#      console.log err
    )
  getValue:(args)->
    if Meteor.isClient
      ns = window
    else
      ns = global
    ns[@getValFunc](args)





class @Badge
#  This is the class definition for badges
#  The dev can define badges and set properties here
  constructor:(name,display_name,description,imgPath,sysVars)->
    @name = name
    @sysVars = sysVars
    @imgPath = imgPath
    @description = description
    @display_name  = display_name
    @eventListener = []

  assign:(methodArgs)->
#    Meteor.call('addBadgeToUser',Meteor.userId(),this.name)
    t = this

    for el in  _.where(@eventListener,{eventName:'assign'})


      el.eventCallBack(t,methodArgs)

  triggerEvent:(eventname,methodArgs)->
    t = this
#    console.log eventname
    for el in  _.where(@eventListener,{eventName:eventname})
      el.eventCallBack(t,methodArgs)




  on:(event,callback)->
    @eventListener.push {eventName:event, eventCallBack:callback}




