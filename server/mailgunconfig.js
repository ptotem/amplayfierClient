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
    'from': 'info@amplayfier.com',
    'html': generateUserAdditionMail(to,fname,lName,currUserFname,currUserLname),
    'text': "someText",
    'subject': publishMail.subject,
  });
}
,
sendMassMail:function(pid,subject,body){
  var ul = Meteor.users.find({'personal_profile.platform':pid.toString()}).fetch();
  var NigerianPrinceGun = new Mailgun(mailgunoptions);
  for(var i=0;i<ul.length;i++){
    console.log(ul[i].personal_profile.email)
    NigerianPrinceGun.send({
    'to': decodeEmail(ul[i].personal_profile.email),
    'from': 'info@amplayfier.com',
    'html': body,
    'text': "someText",
    'subject': subject,
  });

  }
},
sendMultipleMail:function(pid,emails,subject,body){
  
  var NigerianPrinceGun = new Mailgun(mailgunoptions);
  for(var i=0;i<emails.length;i++){
    console.log(emails[i])
    NigerianPrinceGun.send({
    'to': decodeEmail(emails[i]),
    'from': 'info@amplayfier.com',
    'html': body,
    'text': "someText",
    'subject': subject,
  });

  }
}

})
