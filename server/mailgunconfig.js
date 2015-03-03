var mailgunoptions = {
  apiKey: 'key-036bf41682cc241d89084bfcaba352a4',
  domain: 'amplayfier.com'
}
// window.mailgunoptions = options
Meteor.methods({
mailGunSend:function(sendTo,sendSubject,sendBody){
  console.log(mailgunoptions);
  var NigerianPrinceGun = new Mailgun(mailgunoptions);
  var mail, _i, _len;

  for (_i = 0, _len = sendTo.length; _i < _len; _i++) {
    mail = sendTo[_i];
    NigerianPrinceGun.send({
      'to': mail,
      'from': 'postmaster@ptotemydemo.com',
      'html': sendBody,
      'text': "someText",
      'subject': sendSubject,
    });
  }
},

sendMassMailGunEmail: function(subject, text) {
 var e, emailids, u, _i, _j, _len, _len1, _ref, _results;
 var NigerianPrinceGun = new Mailgun(mailgunoptions);
 emailids = [];
 _ref = Meteor.users.find().fetch();
 for (_i = 0, _len = _ref.length; _i < _len; _i++) {
   u = _ref[_i];
   emailids.push(u.personal_profile.email);
 }
 _results = [];
 for (_j = 0, _len1 = emailids.length; _j < _len1; _j++) {
   e = emailids[_j];
   console.log(e)
   NigerianPrinceGun.send({
     'to': e,
     'from': 'postmaster@ptotemydemo.com',
     'html': text,
     'text': "someText",
     'subject': subject,
   });
 }

},

sendPublishMailGunMail: function(to) {
  var NigerianPrinceGun = new Mailgun(mailgunoptions);

  NigerianPrinceGun.send({
    'to': to,
    'from': 'postmaster@ptotemydemo.com',
    'html': publishMail.text,
    'text': "someText",
    'subject': publishMail.subject,
  });
},

sendChangePwdMailGunMail: function(to) {
  var NigerianPrinceGun = new Mailgun(mailgunoptions);

  NigerianPrinceGun.send({
    'to': to,
    'from': 'postmaster@ptotemydemo.com',
    'html': changePwdMail.text,
    'text': "someText",
    'subject': changePwdMail.subject,
  });

},

requestCodeMailGunMail: function(email) {
  var NigerianPrinceGun = new Mailgun(mailgunoptions);

  NigerianPrinceGun.send({
    'to': 'info@ptotem.com',
    'from': 'postmaster@ptotemydemo.com',
    'html': "Requested code to publish Template",
    'text': "someText",
    'subject': email +" Requested code to publish Template",
  });

},
contactUsMailGunMail: function(name,email,feedback) {
  var NigerianPrinceGun = new Mailgun(mailgunoptions);

  NigerianPrinceGun.send({
    'to': 'info@ptotem.com',
    'from': email,
    'html': feedback,
    'text': "Feedback",
    'subject': "Feedback from "+ name,
  });

}



})
