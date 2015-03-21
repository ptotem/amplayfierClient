
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
    sendMassMail:function(pid,subject,body){
        var ul = Meteor.users.find({'personal_profile.platform':pid.toString()}).fetch();
        var emailIds = [];
        for(var i=0;i<ul.length;i++) {
            emailIds.push(decodeEmail(ul[i].personal_profile.email))
        }
        sendEmails(emailIds,subject,body)


    },
    sendMultipleMail:function(pid,emailIds,subject,body){
        emailList = [];
        ul = emailIds;
        for(var i=0;i<ul.length;i++) {
            emailList.push(decodeEmail(ul[i]))
        }
        sendEmails(emailList,subject,body);


    }


});
