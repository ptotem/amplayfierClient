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
