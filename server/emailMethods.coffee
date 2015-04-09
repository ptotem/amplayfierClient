@sendRegisterMail = ()->
  Mailer.send({
    to: 'Perseus Vazifdar <rushabh@ptotem.com>',           # 'To: ' address. Required.
    subject: 'Subject',                     # Required.
    template: 'sampleMail',               # Required.
    from:'info@ptotem.com'

    data: {}                                # Optional. Render your email with a data object.
  })
