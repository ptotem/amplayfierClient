
// window.mailgunoptions = options
Meteor.methods({
sendUserAddMailGunMail: function(to,fname,lName,currUserFname,currUserLname) {
  var NigerianPrinceGun = new Mailgun(mailgunoptions);

  NigerianPrinceGun.send({
    'to': to,
    'from': 'info@amplayfier.com',
    'html': generateUserAdditionMail(to,fname,lName,currUserFname,currUserLname),
    'text': "someText",
    'subject': publishMail.subject
  });
},



});
