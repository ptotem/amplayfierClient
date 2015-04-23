@setRightBlockHeight = () ->
  leftContainerHeight = $('#left-container').height()
  $("#right-container").css('height',(leftContainerHeight-15.84375)+"px");


Template.wrapperPage.events
  'click .box-style':(e)->
#    $('.wrapper-story').fadeOut(1000)
#    $('.story-node').hide()
    window.location = '/mystory'


  'click #active-pepsi-div':(e)->
    window.location = '/mystory'



#    tnc = $(e.currentTarget).attr('target-node-class')
#    finalTime = parseInt($('.story-node').length * 500)
#    i = 0
#    setTimeout(()->
#      $('.story-node').each((ind,ele)->
#
#        if $(ele).hasClass(tnc)
#          i = i + 1
#          $(ele).fadeOut(0).delay(i*500).fadeIn(500)
#        else
#          $(ele).fadeOut(0).delay(0)
##          $(ele).hide()
#          $(ele).remove()
#
#
#      )
#    ,1000)
#    setTimeout(()->
#      $('.story-node').hide()
#      $("."+tnc).show()
#    ,finalTime)



#  'click .pepsi-home-dash':(e)->
#    $('#dashboard-launcher').trigger('click')
#
#  'click #dashboard-launcher':(e)->
#
#    initDash()





Template.wrapperPage.rendered = ->
  $('.pepsi-homepage').fadeIn('slow')
  setTimeout(()->
    setRightBlockHeight()
    $(window).resize ->
      setRightBlockHeight()
  ,600)
