@imgPath  =  "/var/www/assets/certificationImg"

@insertImg = (dirPath,uid)->
  console.log "INserrrrrrrrrrrrrrrt"
  certification = ""
  Fiber = Npm.require('fibers');
  Future = Npm.require('fibers/future');
  future = new Future();
  fs = Npm.require('fs');
  fs.readdir dirPath , (err, list) ->
    Fiber(()->
        list.forEach (file,index) ->
          console.log ">>>>>>>>"
          console.log index
          console.log file
          console.log list
          console.log ">>>>>>>>>"
          path = dirPath + "/" + file
          newFile = new FS.File(path);
          a = assetFiles.insert newFile
          certification = a._id
        Meteor.users.update({_id:uid},{$push:{certification:certification}})
        future.return("true")
    ).run()
# Get the file's stats
# fs.stat path, (err, stat) ->
#   console.log stat
#   console.log err





Meteor.methods
  certifiedImg:Meteor.bindEnvironment((uid,str)->
    console.log "Method is called"
    Fiber = Npm.require('fibers');
    Future = Npm.require('fibers/future');
    future = new Future();
    fs = Npm.require('fs');
    sys = Npm.require('sys');
    exec = Npm.require('child_process').exec;
    pwd =  process.env["PWD"]

    team = '"'+str+'"'
    child = exec("mkdir /var/www/assets/certificationImg/")
    child = exec("convert -font helvetica -pointsize 50 -fill white -draw 'text 300,300 " + team  + "' /var/www/assets/static/certificates.jpg  /var/www/assets/certificationImg/certify" + str + ".jpg" ,(error,stdout,stderr)->
      if error?
        console.log error
        future.return("conversionError")
      else
        console.log "conversion done"
        x = insertImg(imgPath,uid)
     )

    return future.wait()
  )
