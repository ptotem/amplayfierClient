# Template.userEditForm.events
#   'click .update-user':(e)->
#     display_name = $("#user-name").val()
#     first_name = $("#user-first-name").val()
#     last_name = $("#user-last-name").val()
#     designation = $("#user-designation").val()
#     if document.getElementById('profile-pic').files.length isnt 0
#       profilePic = new FS.File(document.getElementById('profile-pic').files[0])
#       profilePic.owner = Meteor.userId()
#       profilePic.stored = false
#       pp = assetFiles.insert(profilePic)
#       ppid = pp._id
#     else
#       ppid = Meteor.user().personal_profile.profilePicId
#     if document.getElementById('cover-pic').files.length isnt 0
#       coverPic = new FS.File(document.getElementById('cover-pic').files[0])
#       coverPic.owner = Meteor.userId()
#       coverPic.stored = false
#       cp = assetFiles.insert(coverPic)
#       cpid = cp._id
#     else
#       cpid = Meteor.user().personal_profile.coverPicId
#     if $('#user-password-old').val().length isnt 0
#       Accounts.changePassword($('#user-password-old').val(),$('#user-password-new').val(),(err)->
#         if err?
#           createNotification(err.message,1)
#       )
#     $('#overlay').show()
#     Tracker.autorun(()->
#
#       if assetFiles.findOne(ppid).stored and assetFiles.findOne(cpid).stored
#         pp = Meteor.user().personal_profile
#         pp['coverPicId'] = cpid
#         pp['profilePicId'] = ppid
#         pp['first_name'] = first_name
#         pp['last_name'] = last_name
#         pp['display_name'] = display_name
#         pp['designation'] = designation
#
#         Meteor.users.update({_id:Meteor.userId()},{$set:{personal_profile:pp}})
#         $('.modal').modal('hide')
#         $('.user-edit-form').remove()
#         $('#overlay').hide()
#
#
#     )
#
#
# Template.storyWrapper.created = ()->
#   s = platforms.findOne().storyConfig
#   window.storyConfig = JSON.parse(s);
#
#
# Template.storyWrapper.rendered = () ->
#
#
#   if Meteor.userId()?
#     Meteor.call('checkIfUserPasswordSet',Meteor.userId(),(err,res)->
#       if !res
#         window.location = "/setpassword/"+Meteor.userId()
#     )
#
#   if platforms.findOne()?
#     window.platformData.nodes = platforms.findOne().nodes
#
#     setTitle(storyConfig.name)
#     window.storyConfig.imgsrc = Meteor.settings.public.mainLink + window.storyConfig.imgsrc
#     pid = platforms.findOne({tenantName: platformName})._id
#     window.wrapperDecks = _.compact(deckHtml.find({platformId:pid}).fetch())
#     window.userdata["decks"] = []
#     for d in _.compact(deckHtml.find({platformId:pid}).fetch())
#       window.userdata["decks"].push({deckId:d.deckId,complete:isModuleComplete(d.deckId,Meteor.userId())})
#     $('.story-node').popover({trigger:'hover',html: true})
#     initPage()
#
# Template.storyWrapper.helpers
#   getNamePlate : ()->
#     Meteor.settings.public.mainLink+storyConfig.imgsrc + "/" + storyConfig.nameplate.image
#   getStoryPresenter: ()->
#     Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + storyConfig.presenter.image
#   nodes:()->
#     _.reject(platforms.findOne().nodes,(i)->
# #         !i.decks? and parseInt(((new Date().getTime() - Meteor.user().createdAt.getTime())/1000)/86400) < parseInt(i.startDay)
# #      if i.sequence isnt 0
# #        console.log "sas"
# #
# #        parseInt(((new Date().getTime() - Meteor.user().createdAt.getTime())/1000)/86400) > parseInt(i.startDay)
# #      else
# #        console.log "sgaga"
# #        console.log  parseInt(i.startDay)
# #        console.log parseInt(((new Date().getTime() - Meteor.user().createdAt.getTime())/1000)/86400)
#         parseInt(((new Date().getTime() - Meteor.user().createdAt.getTime())/1000)/86400) < parseInt(i.startDay)
#     )
#   getNodeUrl:(pic)->
#     "<img class='popover-photo' src='"+Meteor.settings.public.mainLink+storyConfig.imgsrc + "/" + pic + "' />"
#   getNodeStatusPic:(seq)->
#     if seq isnt 0
#       if !userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq-1})?
#         return Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + platforms.findOne().nodes[seq].incomplete
#
#     if userNodeCompletions.findOne({userId:Meteor.userId(),nodeSeq:seq})?
#
#       Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + platforms.findOne().nodes[seq].complete
#     else
#       Meteor.settings.public.mainLink+  storyConfig.imgsrc + "/" + platforms.findOne().nodes[seq].active
#
#   getPlacement:(px)->
#     if px < 50
#       "right"
#     else
#       "left"
#
# Template.individualStoryZone.rendered = ->
#   $('.zone-deck').popover({
#     placement: 'left',
#     trigger: "hover",
#     html: true,
#   });
#
#
#
# Template.individualStoryZone.events
#   'click #story-zone-close':(e)->
#     $('#story-zone').fadeOut()
#     $('.story-node').css({
#       "pointer-events": "auto",
#       opacity: 1
#     });
#     $('.story-zone-wrapper').hide()
#
#
# Template.individualStoryZone.helpers
#   deckOfNode:(s)->
#
#     deckList = []
#     console.log s
#     flag = 'auto'
#     for d,i in platforms.findOne().nodes[s].decks
#       if userCompletions.findOne({userId:Meteor.userId(),deckId:d})?
#         status = 'complete'
#       else
#         status = 'incomplete'
#
#
#       deckList.push {flag:flag,deckId:d,deckName:deckHtml.findOne({deckId:d}).name,status:status}
#       if status is 'incomplete' and i is 0
#         flag = 'none'
#     deckList
#
#
#
# Template.storyWrapper.events
#
#   'click .fullscreener':(e)->
#     $('#story-wrapper').fadeOut()
#     $('#full-wrapper-cont').append($('#story-zone').find('.projector-container').html())
#     $('#full-wrapper').slideDown()
#
# #      initDeck()
# #      Blaze.renderWithData Template.homePage, { deckId: currentDisplayedDeckId }, document.getElementsByClassName('fullprojector')[0]
#
#
#     'mouseenter .story-node':(e)->
#     $(e.currentTarget).css({"box-shadow": storyConfig.nodestyle.hover})
#   'click .story-node':(e)->
#     $('[data-toggle="popover"]').popover('hide');
#     $('.story-node').css({
#       "pointer-events": "none",
#       opacity: 0
#     });
#     if window.innerWidth > 1050
#       $('#story-nameplate').animate width: storyConfig.nameplate.reduced + '%'
#     else
#       if !isPortrait()
#         $('#story-nameplate').fadeOut()
#     $('#story-zone').empty()
#     seq = $(e.currentTarget).attr('seq')
#     node = platforms.findOne().nodes[seq]
#     nodePhoto = storyConfig.imgsrc + "/" + node.photo
#     nodeTitle = node.title
#     nodeDescription = node.description
#     Blaze.renderWithData(Template.individualStoryZone,{seq:seq,nodePhoto:nodePhoto,nodeTitle:nodeTitle,nodeDescription:nodeDescription},document.getElementById('story-zone'))
#
#
#
#     $('#story-zone').fadeIn()
#
#
#
#
#   'mouseleave .story-node':(e)->
#     $(e.currentTarget).css({"box-shadow": 'none'})
#
#   'keyup #chat-user-search':(e)->
#     searchBar($(e.currentTarget).val(),".chat-row")
#
#
#   'click .redeem-reward':(e)->
#     if this.stock is 0
#       createNotification("Sorry out of stock",0)
#     if this.value > currency.getValue()
#       createNotification("You do not have enough credits",0)
#     Meteor.call('redeemReward',Meteor.userId(),this._id,(err,res)->
#       if res
#         createNotification("Reward is redeemed, you would have got an email",1)
#
#     )
#
#   'click .btn-logout':(e)->
#     Meteor.logout()
#   'click .user-edit-btn':(e)->
#     $('.modal').modal('hide')
#     $('.user-edit-form').remove()
#     Blaze.renderWithData(Template['userEditForm'], {}, document.getElementById('story-wrapper'))
#     $(".modal").modal()
#
# #  'click .fullscreener':(e)->
# #    Blaze.renderWithData(Template.homePage,{deckId:currentDisplayedDeckId},document.getElementsByClassName("projector")[0])
#   'click #noti-link':(e)->
#     setTimeout(()->
#       markAllNotiRead(Meteor.userId())
#     ,2000)
#
#   'click .admin-icon':(e)->
#     $('.menu').slideToggle('slow')
#     # window.location = "/admin"
#
#   'click #story-block-close':(e)->
#     if $('.active').has('iframe').length is 0
#       setTime(getTime());
#       minTime = $('.center-panel:visible').find(".slide-wrapper").attr("min-time");
#       maxTime = $('.center-panel:visible').find(".slide-wrapper").attr("max-time");
#       points = $('.center-panel:visible').find(".slide-wrapper").attr("points");
#       setCurrentSlideScore(minTime, maxTime, points);
#     if $('.slide-container.active').length is 1
#       setTime(getTime());
#       minTime = $('.center-panel:visible').find(".slide-wrapper").attr("min-time");
#       maxTime = $('.center-panel:visible').find(".slide-wrapper").attr("max-time");
#       points = $('.center-panel:visible').find(".slide-wrapper").attr("points");
#       setCurrentSlideScore(minTime, maxTime, points);
#     setTimeout(()->
#       endAttempt()
#     ,2000)
#
#
#     $('.projection').remove();
#     $('.story-zone-playbar').remove();
#
#
# #    $("#story-zone-close").trigger('click')
#
#   'click .zone-deck':(e)->
#
#     deckId = $(e.currentTarget).attr("id").split("-")[2]
#
#     setDeckId(deckId)
#     if platforms.findOne().profiles?
#       for p in platforms.findOne().profiles
#         if p.name is Meteor.user().profile
#           for v in p.variants
#             if v[deckId]?
#               setVariantToShow(v[deckId])
#     if !variantToShow?
#       setVariantToShow('Basic')
#     setCurrentDeckId(deckId)
#     setTimeout(()->
#       initDeck()
#     ,1000)
#
#     # Blaze.renderWithData(Template.homePage,{deckId:deckId},document.getElementById("story-zone"))
#     console.log "ppt"
#     Blaze.renderWithData(Template.previewPPT,{deckId:deckId},document.getElementById("story-zone"))
#
#
#   'click #dashboard-launcher':(e)->
#
#     initDash()
#
#
#
# Template.storyDashboard.helpers
#   notiPassKey:()->
#     {ukey:platforms.findOne()._id}
#
#   passKey:()->
#     {getNodeStatusPic:platforms.findOne()._id}
#   faqs:()->
#     faq
#   rewards:()->
#     systemRewards.find().fetch()
#   getCurrency:()->
#     currency.getValue()
#   remainingBadges:()->
#     remainingBadges = []
#
#     basePath = "/assets/badgeimages/"
#     allBadgeList = [basePath+'milestone.png',basePath+'alldone.png',basePath+'god.png',basePath+'flawless.png',basePath+'mastermind.png',basePath+'mrperfect.png',basePath+'revisionary.png',basePath+'rocketman.png',basePath+'thorough.png',basePath+'wellstarted.png']
#
#     userBadges = _.pluck(Meteor.user().badges,'imgPath')
#     #    remainingBadges =
#     for r in _.difference(allBadgeList,userBadges)
#       remainingBadges.push {imgPath:r.replace(".png","-bw.png")}
#
#     remainingBadges
#
# Template.storyWrapper.helpers
#   getPortalName:()->
#     platforms.findOne().tenantName
