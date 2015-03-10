@inviteMail = (email,platformName,userName)->
  subject:"Hello from amplayfier"
  text:"You have been invited by " + userName + " to explore and interact on " + platformName + ". To Join " + userName + " just click on the link http://www.amplayfier.com/. Your account has been created,your email is " + email + " and password is password."
@registerMail =
  subject:"Welcome, Let's get started...."
  text:'SampleTExt'
@generateRegistrationMail = (email,dname,pass)->
  return '<body>
<div class="main-wrapper"
     style=" background-image: url(img/background.jpg);background-size: 100% 100%; font-family: arial;height: 515px;width: 600px;margin: 0 auto;border: 1px solid black;padding: 2px 4px 2px 2px;">


    <div style="width: 100%;height: 22%;float: left">
        <div style="width: 55%;height: 100%;float: left">
            <div style="width: 75%;height: 85%;float: left;margin-top: 2%; margin-left: 5%">
                <img style="width: 100%;height: 100%" src="img/amplayfier_logo.png">
            </div>

        </div>
        <div style="width: 45%;height: 100%;float: left;background-image: url(img/header_orange.jpg);background-size: 100% 100%">
            <div style="width: 100%;height: 100%;float: left">
                <div style="color: #4a4a4a;font-size: 1em;width: 90%;padding: 1%;margin-top: 13%;text-align: right;float: left;top: 0">
                    '+dname+'
                </div>
                <div style="color: whitesmoke;font-size: 1em;width: 90%;padding: 1%;text-align: right;float: left;top: 0">
                    Sign in
                </div>
            </div>

        </div>

    </div>
    <div style="width: 100%;height: 78%;float: left">
<div style="width: 55%;height: 100%;float: left;background-image: url(img/text.jpg);background-size: 100% 100%">
    <div style="width: 100%;height: 10%;float: left;top: 0;margin-top: 10%">
        <div style="font-size: 1.5em;color: #727376;font-weight: bold;padding: 2%">Welcome to Amplayfier!</div>

    </div>
    <div style="width: 100%;height: 20%;float: left;">
        <div style="color: #727376;padding: 2%;font-size: .9em">You can login using '+pass+'</div>

    </div>
    <div style="color: #727376;padding:2%;font-size: .9em;height: 30%;margin-top:12% ;float: left">
        We hopeyou enjoy yourself. A new way to communicate will be your experience. Since we at Amplayfier everyone to ,<br><span style="font-weight: bold;font-size: 1.5em">Say it With Games!</span>
    </div>
<div style="color:#727376;font-size: 0.9em;height: 20%;float: left;font-weight: bold;padding: 2% ">The Amplayfier Team</div>
</div>
        <div style="width: 45%;height: 100%;float: left">
            <div style="width:84%;padding:3%;text-align: center ;color: whitesmoke;font-weight: bold;font-size: 1.3em;float: left;margin-left: 5%; margin-top: 45%;background-image: url(img/button.png);background-size: 100% 100%">
                Click Here to View
                <!--<div style="color: whitesmoke;font-weight: bold;font-size: 1.3em;float: left;top: 0;padding: 9%"></div>-->
            </div>
            <div style="width:90%; height: 14%;float: left;top: 0;margin-top: 52%;padding: 4%">
                <div style="float: left;;margin-top: 9%;width: 35%;font-size: 1em;color:#727376 ">Follow us :</div>
                <div style="height: 82%;width: 60%;float: left">
                <div style="width: 30%;height: 100%;float: left;background-image: url(img/twitter01.png);background-size: 100% 100%"></div>
                <div style="margin-left:2%;width: 30%;height: 100%;float: left;background-image: url(img/fb_icon01.png);background-size: 100% 100%"></div>
                <div style="margin-left:2%;width: 30%;height: 100%;float: left;background-image: url(img/linkedin01_icon.png);background-size: 100% 100%"></div>
</div>
                </div>
            </div>

        </div>

    </div>
</div>
</body>'


@forgotPwdMail =
  text:"We were told that you have forgotten your password. This is something we deal with quite often and it is an easy process. All you have to do is click on the link below to reset your password and you are good to go. "
@changePwdMail =
  subject:"Hello from Amplayfier"
  text:"We just thought you should know that you have changed your Amplayfier password. If you have not changed your password then click on the link http://www.amplayfier.com/ to reset your password. After all, your account's safety is very important."
@publishMail =
  subject:"Congratulations"
  text:"You have just published a Platform. You can now see your Platform listed on the Amplayfier Store, and so can other Interested Buyers"

@generateUserAdditionMail = (to)->
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
                <div style="text-align: right;margin-right: 10%;">'+to+'</div>

                <a class="sign" href="http://amplayfier.com" style="color: #F28D37;font-family: arial;font-size: 16px;float:right;margin-right:10%;">Sign in</a>
            </div>


        </div>
    </div>

    <div class="bottom-left" style="width:60% ;float:left;height:70%;position:relative;">
     <div style="font-family: arial;color: #000000;margin:10%">
        <div><p>Hello,'+fname+' ' +lname+' </p></div>
         <div><p>Welcome to Amplayfier!</p></div>
         <div><p>You are now just a few steps away from creating your very first game based portal. </p></div>


         <div><p>We hope you enjoy yourself. A new way to communicate will be your experience. Since we at Amplayfier encourage everyone to,</p> </div>       <h2 style="font-size: 20px;line-height: 0;color:#848484;font-family: arial">Say It With Games!</h2>
          <div style="font-size: 16px;line-height: 0;color:#000000;font-family: arial;font-weight: bolder;
  margin-top: 15%">The Amplayfier Team</div>
</div>


    </div>

    <div class="bottom-right" style="width:40% ;float:left;height:70%;position:relative;background-color: rgba(242, 141, 55,0.6)">
    <div style="padding: 3%;text-align: center;font-family: arial,sans-serif;margin-top:35%;background-color:rgb(132,132, 132);  width: 75%;margin-left: 10%;"><a style="text-decoration:none;color:black" href="http://amplayfier.com/" target="_blank">Create Now</a></div>
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
