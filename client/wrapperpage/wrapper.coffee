Template.wrapperPage.events
  'click .box-style':(e)->
    $('.wrapper-story').fadeOut(1000)
#    $('.story-node').hide()
    $("#story-wrapper").show()

    setTimeout(()->
      $('.story-node').each((ind,ele)->

        $(ele).fadeOut(0).delay(ind*500).fadeIn(500)
      )
    ,1000)

  'click .pepsi-home-dash':(e)->
    $('#dashboard-launcher').trigger('click')

  'click #dashboard-launcher':(e)->

    initDash()

