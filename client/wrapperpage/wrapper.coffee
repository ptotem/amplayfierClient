Template.wrapperPage.events
  'click .box-style':(e)->
    $('.wrapper-story').fadeOut(1000)
#    $('.story-node').hide()
    $("#story-wrapper").show()


    tnc = $(e.currentTarget).attr('target-node-class')
    setTimeout(()->
      $('.story-node').each((ind,ele)->

        $(ele).fadeOut(0).delay(ind*500).fadeIn(500)
        if !$(ele).hasClass(tnc)
          $(ele).hide()
      )
    ,1000)

  'click .pepsi-home-dash':(e)->
    $('#dashboard-launcher').trigger('click')

  'click #dashboard-launcher':(e)->

    initDash()


