Template.adminHeaderBar.events
  'click .logout-link':(e)->
    Meteor.logout()

Template.rewardsLeftMenu.helpers
  rewards:()->
    systemRewards.find().fetch()

Template.profilesLeftMenu.helpers
  getPlatformProfiles: (uid)->
    dep.depend()
    profiles = []
    if platforms.findOne().profiles?
      for p in platforms.findOne().profiles
        p["uid"] = uid
        profiles.push p

    profiles

Template.adminSideBar.events
  'click .menu-link':(e)->
    temName = $(e.currentTarget).attr('target-templ')
    Blaze.renderWithData(Template[temName],{},document.getElementById('left-menu-container'))

Template.mainAdminPanel.helpers
  assessments:()->
    assesments.find().fetch()
  viewQuestion:()->
    assesments.findOne(Session.get("viewquesId")).scoreQuestions
  questions:()->
    scoreQuestions.find().fetch()
  nodes:()->
    platforms.findOne().nodes


  badges:()->
    platforms.findOne().badges

  passKey:()->
    {ukey:platforms.findOne()._id}
  setUniqKey:()->
    {uniqKey:platforms.findOne()._id}
  myusers: () ->
    Meteor.users.find().fetch()
  roles:()->
    roles.find().fetch()
  profileForUsers :(uid)->
    profiles = []
    if platforms.findOne().profiles?
      for p in platforms.findOne().profiles
        console.log Meteor.users.findOne(uid).profile
        if Meteor.users.findOne(uid).profile is p.name
          p["selected"] = true
        else
          p['selected'] = false
        profiles.push p


    profiles

