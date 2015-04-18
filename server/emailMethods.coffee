@sendRegisterMail = ()->
  Mailer.send({
    to: 'Perseus Vazifdar <rushabh@ptotem.com>',           # 'To: ' address. Required.
    subject: 'Subject',                     # Required.
    template: 'sampleMail',
    from:'info@ptotem.com'
    data: {}                                # Optional. Render your email with a data object.
  })

@sendGeneralMail = (to,subject,templateName,data)->
  Mailer.send({
    to: to,           # 'To: ' address. Required.
    subject: subject,                     # Required.
    template: templateName,               # Required.
    from:'info@ptotem.com'
    data: data                                # Optional. Render your email with a data object.
  })

