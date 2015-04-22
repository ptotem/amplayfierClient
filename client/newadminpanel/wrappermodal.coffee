 Template.addvariantModal.events
   'click .remove-modal':(e)->
     $('.modal').modal('hide')
     $('.modal').remove()
     $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

   'click .add-individual-variant': (e) ->
     arr = []
     $('.userDecks').each (i, v) ->
       #console.log $(v).find('.deckname').val()
       a = {}
       a[$(v).find('.deckname').val()] = $(v).find('.variant-chosen').val()
       arr.push a
       return
     platId = platforms.findOne()._id
     profile = {name: $('#currentProfileName').val(), description: $('#currentProfileDesc').val()}
     platforms.update({_id: platId}, {$pull: {profiles: profile}})
     profile.variants = arr
     platforms.update({_id: platId}, {$push: {profiles: profile}})
     console.log platforms.findOne({_id: platId}).profile
     createNotification("Variants are added to this profile", 1)

  Template.addvariantModal.helpers
    userDeckHtml: ()->
      deckHtml.find().fetch()

    deckVariants: (deckId)->
      variants = []
      deck = deckHtml.findOne(deckId)
      if deck.variants?
        for j in deck.variants
          variants.push({userVariants: j})
      variants


  Template.addprofileModal.events
    'click .remove-modal':(e)->
      $('.modal').modal('hide')
      $('.modal').remove()
      $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

    'click .add-individual-profile': (e)->
      profile = {name: $("#profile-name").val(), description: $("#profile-desc").val()}
      platId = platforms.findOne()._id
      platforms.update({_id: platId}, {$push: {profiles: profile}})
      createNotification("Profile has been added successfully", 1)
      $(".internal-sidelinks.active").trigger('click')

  Template.adduserModal.events
    'click .remove-modal':(e)->
      $('.modal').modal('hide')
      $('.modal').remove()
      $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

  Template.adduserModal.helpers
    myusers: () ->
      Meteor.users.find().fetch()
    myuser: (uid) ->
      if uid isnt -1
        Meteor.users.findOne(uid)
      else
        {}
    roles:()->
      roles.find().fetch()
