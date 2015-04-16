@sendRegisterMail = ()->
  Mailer.send({
    to: 'Perseus Vazifdar <rushabh@ptotem.com>',           # 'To: ' address. Required.
    subject: 'Subject',                     # Required.
    template: 'sampleMail',
    routePrefix: 'assets/sample-email',    # Required.
    from:'info@ptotem.com'
    baseUrl: process.env.ROOT_URL,
    data: {}                                # Optional. Render your email with a data object.
  })

@sendGeneralMail = (to,subject,templateName,data)->
  Mailer.send({
    to: to,           # 'To: ' address. Required.
    subject: subject,                     # Required.
    template: templateName,               # Required.
    from:'info@ptotem.com'
    routePrefix: 'assets/sample-email',
    baseUrl: process.env.ROOT_URL,
    data: data                                # Optional. Render your email with a data object.
  })

