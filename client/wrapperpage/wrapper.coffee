Template.wrapperPage.events
  'click .box-style':(e)->
    $('.wrapper-story').fadeOut(1000)
#    $('.story-node').hide()
    $("#story-wrapper").show()


    tnc = $(e.currentTarget).attr('target-node-class')
    finalTime = parseInt($('.story-node').length * 500)
    setTimeout(()->
      $('.story-node').each((ind,ele)->
        if $(ele).hasClass(tnc)
          $(ele).fadeOut(0).delay(ind*500).fadeIn(500)
        else
          $(ele).fadeOut(0).delay(ind*500)
          $(ele).hide()
#          $(ele).remove()


      )
    ,1000)
#    setTimeout(()->
#      $('.story-node').hide()
#      $("."+tnc).show()
#    ,finalTime)



  'click .pepsi-home-dash':(e)->
    $('#dashboard-launcher').trigger('click')

  'click #dashboard-launcher':(e)->

    initDash()


