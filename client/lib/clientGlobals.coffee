@createNotification = (text, type)->
  # type indicates the type of notification
  # 0 -> failure
  # 1 -> success
  #2 -> warning
  toastr.clear()
  if type is 0
    toastr.error(text)
  if type is 1
    toastr.success(text)
  if type is 2
    toastr.warning(text)

@showModal = (templateName, templateArgs, docId)->
  $(".modal").remove()
  Blaze.renderWithData(Template[templateName], templateArgs, document.getElementById(docId))
  setTimeout(()->
    $(".modal").modal()
    $('.modal-blur-content').css({"-webkit-filter":"blur(3px)"})
    $('.modal-dialog').css({"z-index":"9999"})
  ,100)

#  $(".modal").modal()
