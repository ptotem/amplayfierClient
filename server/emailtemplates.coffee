@inviteMail = (email,platformName,userName)->
  subject:"Hello from amplayfier"
  text:"You have been invited by " + userName + " to explore and interact on " + platformName + ". To Join " + userName + " just click on the link http://www.amplayfier.com/. Your account has been created,your email is " + email + " and password is password."
@registerMail =
  subject:"Welcome, Let's get started...."
  text:'SampleTExt'
@generateRegistrationMail = (email,dname,pname,pass)->
  return '<div class="main-wrapper" style="height: 480px;width: 640px;background-size:100% 100%;margin:0 auto;position: relative;background-image:
url(http://amplayfier.com/assets/mailerimages/background.jpg);">
    <div class="top-left" style="width:60% ;float:left;background-color: rgba(132, 132, 132,0.2);height:30%;position:relative">
        <div class="logo-img">
            <img src="http://amplayfier.com/assets/mailerimages/amplayfier_logo.png" class="imgset" style="padding: 5% 5% 0;width: 75%">

        </div>

    </div>
    <div class="top-right" style="width:40% ;float:left;height:30%;position:relative;">
        <div class="sign-in" style="text-align: center;margin-top:24%">
            <div class="signname" style="color:#4a4a4a;font-family: arial;font-size: 16px;">
                <div style="text-align: right;margin-right: 10%;">'+dname+'</div>

                <a class="sign" href="http://amplayfier.com" style="color: #F28D37;font-family: arial;font-size: 16px;float:right;margin-right:10%;">Sign in</a>
            </div>


        </div>
    </div>

    <div class="bottom-left" style="width:60% ;float:left;height:70%;position:relative;">
     <div style="font-family: arial;color: #000000;margin:10%">
        <div><p>Hello,'+email+' </p></div>
         <div><p>Welcome to your Amplayfier portal !</p></div>
         <div><p>You can login using your email id and your portal secret key : '+pass+'</p></div>


         <div><p>We hope you enjoy yourself. A new way to communicate will be your experience. Since we at Amplayfier encourage everyone to,</p> </div>       <h2 style="font-size: 20px;line-height: 0;color:#848484;font-family: arial">Say It With Games!</h2>
          <div style="font-size: 16px;line-height: 0;color:#000000;font-family: arial;font-weight: bolder;
  margin-top: 15%">The Amplayfier Team</div>
</div>


    </div>

    <div class="bottom-right" style="width:40% ;float:left;height:70%;position:relative;background-color: rgba(242, 141, 55,0.6)">
    <div style="padding: 3%;text-align: center;font-family: arial,sans-serif;margin-top:35%;background-color:rgb(132,132, 132);  width: 75%;margin-left: 10%;"><a style="text-decoration:none;color:black" href="http://'+pname+'.amplayfier.com/" target="_blank">Admin Panel</a></div>
        <div class="social-container" style="padding-top:65%">
      <span style="margin-left: 4%;font-size: 1em;float:left;font-family: arial;color:black">Follow us:-</span>
      <div class="fb" style="width: 15%;float:left;margin-top: 0px;">
        <a href="https://twitter.com/ptotemlearning" target="_blank">
          <img src="http://amplayfier.com/assets/mailerimages/twitter01.png" class="social-icons" style="width: 90%;height: 30px;">
        </a>
      </div>
      <div class="twit" style="width: 15%;float:left;margin-top: 0px;">
        <a href="https://www.facebook.com/ptotembook" target="_blank">
          <img src="http://amplayfier.com/assets/mailerimages/fb_icon01.png" class="social-icons" style="width: 90%;height: 30px;">
        </a>
      </div>
      <div class="lnk" style="width: 15%;float:left;padding-left: 0px;padding-right: 0px;margin-top: 0px;">
        <a href="https://www.linkedin.com/company/ptotem-learning-projects" target="_blank">
          <img src="http://amplayfier.com/assets/mailerimages/linkedin01_icon.png" class="social-icons" style="width: 90%;height: 30px;">
        </a>
      </div>
    </div>

    </div>
</div>
</div>'


@forgotPwdMail =
  text:"We were told that you have forgotten your password. This is something we deal with quite often and it is an easy process. All you have to do is click on the link below to reset your password and you are good to go. "
@changePwdMail =
  subject:"Hello from Amplayfier"
  text:"We just thought you should know that you have changed your Amplayfier password. If you have not changed your password then click on the link http://www.amplayfier.com/ to reset your password. After all, your account's safety is very important."
@publishMail =
  subject:"Congratulations"
  text:"You have just published a Platform. You can now see your Platform listed on the Amplayfier Store, and so can other Interested Buyers"

@generateUserAdditionMail = (to,fname,lname,currUserFname,currUserLname)->
  return '<div class="main-wrapper" style="height: 480px;width: 640px;background-size:100% 100%;margin:0 auto;position: relative;background-image:
url(http://amplayfier.com/assets/mailerimages/background.jpg);">
    <div class="top-left" style="width:60% ;float:left;background-color: rgba(132, 132, 132,0.2);height:30%;position:relative">
        <div class="logo-img">
            <img src="http://amplayfier.com/assets/mailerimages/amplayfier_logo.png" class="imgset" style="padding: 5% 5% 0;width: 75%">

        </div>

    </div>
    <div class="top-right" style="width:40% ;float:left;height:30%;position:relative;">
        <div class="sign-in" style="text-align: center;margin-top:24%">
            <div class="signname" style="color:#4a4a4a;font-family: arial;font-size: 16px;">
                <div style="text-align: right;margin-right: 10%;">'+fname+' ' +lname+' </div>

                <a class="sign" href="http://amplayfier.com" style="color: #F28D37;font-family: arial;font-size: 16px;float:right;margin-right:10%;">Sign in</a>
            </div>


        </div>
    </div>

    <div class="bottom-left" style="width:60% ;float:left;height:70%;position:relative;">
     <div style="font-family: arial;color: #000000;margin:10%">
        <div><p>Hello,'+fname+' ' +lname+' </p></div>
         <div><p>Welcome to Amplayfier!</p></div>
         <div><p> You have been registered to play on a game based portal created by '+currUserFname+' ' +currUserLname+'</p></div>


         <div><p>We hope you enjoy yourself. A new way to communicate will be your experience. Since we at Amplayfier encourage everyone to,</p> </div>       <h2 style="font-size: 20px;line-height: 0;color:#848484;font-family: arial">Say It With Games!</h2>
          <div style="font-size: 16px;line-height: 0;color:#000000;font-family: arial;font-weight: bolder;
  margin-top: 15%">The Amplayfier Team</div>
</div>


    </div>

    <div class="bottom-right" style="width:40% ;float:left;height:70%;position:relative;background-color: rgba(242, 141, 55,0.6)">
    <div style="padding: 3%;text-align: center;font-family: arial,sans-serif;margin-top:35%;background-color:rgb(132,132, 132);  width: 75%;margin-left: 10%;"><a style="text-decoration:none;color:black" href="http://'+currUserFname+'.amplayfier.com/" target="_blank">Click Here to Engage</a></div>
        <div class="social-container" style="padding-top:65%">
      <span style="margin-left: 4%;font-size: 1em;float:left;font-family: arial;color:black">Follow us:-</span>
      <div class="fb" style="width: 15%;float:left;margin-top: 0px;">
        <a href="https://twitter.com/ptotemlearning" target="_blank">
          <img src="http://amplayfier.com/assets/mailerimages/twitter01.png" class="social-icons" style="width: 90%;height: 30px;">
        </a>
      </div>
      <div class="twit" style="width: 15%;float:left;margin-top: 0px;">
        <a href="https://www.facebook.com/ptotembook" target="_blank">
          <img src="http://amplayfier.com/assets/mailerimages/fb_icon01.png" class="social-icons" style="width: 90%;height: 30px;">
        </a>
      </div>
      <div class="lnk" style="width: 15%;float:left;padding-left: 0px;padding-right: 0px;margin-top: 0px;">
        <a href="https://www.linkedin.com/company/ptotem-learning-projects" target="_blank">
          <img src="http://amplayfier.com/assets/mailerimages/linkedin01_icon.png" class="social-icons" style="width: 90%;height: 30px;">
        </a>
      </div>
    </div>

    </div>
</div>






</div>'



@generateNewPassWordMail = (email,dname,pname,pass)->
  return '<div class="main-wrapper" style="height: 480px;width: 640px;background-size:100% 100%;margin:0 auto;position: relative;background-image:
url(http://amplayfier.com/assets/mailerimages/background.jpg);">
    <div class="top-left" style="width:60% ;float:left;background-color: rgba(132, 132, 132,0.2);height:30%;position:relative">
        <div class="logo-img">
            <img src="http://amplayfier.com/assets/mailerimages/amplayfier_logo.png" class="imgset" style="padding: 5% 5% 0;width: 75%">

        </div>

    </div>
    <div class="top-right" style="width:40% ;float:left;height:30%;position:relative;">
        <div class="sign-in" style="text-align: center;margin-top:24%">
            <div class="signname" style="color:#4a4a4a;font-family: arial;font-size: 16px;">
                <div style="text-align: right;margin-right: 10%;">'+dname+'</div>

                <a class="sign" href="http://amplayfier.com" style="color: #F28D37;font-family: arial;font-size: 16px;float:right;margin-right:10%;">Sign in</a>
            </div>


        </div>
    </div>

    <div class="bottom-left" style="width:60% ;float:left;height:70%;position:relative;">
     <div style="font-family: arial;color: #000000;margin:10%">
        <div><p>Hello,'+email+' </p></div>
         <div><p>Welcome to your Amplayfier portal !</p></div>
         <div><p>You can login using your email id and your portal secret key : '+pass+'</p></div>


         <div><p>We hope you enjoy yourself. A new way to communicate will be your experience. Since we at Amplayfier encourage everyone to,</p> </div>       <h2 style="font-size: 20px;line-height: 0;color:#848484;font-family: arial">Say It With Games!</h2>
          <div style="font-size: 16px;line-height: 0;color:#000000;font-family: arial;font-weight: bolder;
  margin-top: 15%">The Amplayfier Team</div>
</div>


    </div>

    <div class="bottom-right" style="width:40% ;float:left;height:70%;position:relative;background-color: rgba(242, 141, 55,0.6)">
    <div style="padding: 3%;text-align: center;font-family: arial,sans-serif;margin-top:35%;background-color:rgb(132,132, 132);  width: 75%;margin-left: 10%;"><a style="text-decoration:none;color:black" href="http://'+pname+'.amplayfier.com/" target="_blank">Admin Panel</a></div>
        <div class="social-container" style="padding-top:65%">
      <span style="margin-left: 4%;font-size: 1em;float:left;font-family: arial;color:black">Follow us:-</span>
      <div class="fb" style="width: 15%;float:left;margin-top: 0px;">
        <a href="https://twitter.com/ptotemlearning" target="_blank">
          <img src="http://amplayfier.com/assets/mailerimages/twitter01.png" class="social-icons" style="width: 90%;height: 30px;">
        </a>
      </div>
      <div class="twit" style="width: 15%;float:left;margin-top: 0px;">
        <a href="https://www.facebook.com/ptotembook" target="_blank">
          <img src="http://amplayfier.com/assets/mailerimages/fb_icon01.png" class="social-icons" style="width: 90%;height: 30px;">
        </a>
      </div>
      <div class="lnk" style="width: 15%;float:left;padding-left: 0px;padding-right: 0px;margin-top: 0px;">
        <a href="https://www.linkedin.com/company/ptotem-learning-projects" target="_blank">
          <img src="http://amplayfier.com/assets/mailerimages/linkedin01_icon.png" class="social-icons" style="width: 90%;height: 30px;">
        </a>
      </div>
    </div>

    </div>
</div>
</div>'

