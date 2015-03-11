var mailgunoptions = {
  apiKey: 'key-036bf41682cc241d89084bfcaba352a4',
  domain: 'amplayfier.com'
}
// window.mailgunoptions = options
Meteor.methods({
sendUserAddMailGunMail: function(to,fname,lName,currUserFname,currUserLname) {
  var NigerianPrinceGun = new Mailgun(mailgunoptions);

  NigerianPrinceGun.send({
    'to': to,
    'from': 'postmaster@ptotemydemo.com',
    'html': generateUserAdditionMail(to,fname,lName,currUserFname,currUserLname),
    'text': "someText",
    'subject': publishMail.subject,
  });
}



})
