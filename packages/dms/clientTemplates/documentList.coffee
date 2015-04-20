
if Meteor.isClient
  setCollToBeUsed = (clname)->
    Session.set('collUsed',clname)

  Template.documentList.rendered  = ->
    Meteor.call("getDmsMode",(err,res)->
      console.log res
      if res is 1
        Meteor.subscribe('gridFiles',Meteor.userId())
        setCollToBeUsed('gridFiles')

      if res is 2
        Meteor.subscribe('systemFiles',Meteor.userId())
        setCollToBeUsed('systemFiles')
      if res is 3
        Meteor.subscribe('s3Files',Meteor.userId())
        setCollToBeUsed('s3Files')


      console.log err
    )
  Template.docCollection.rendered  = ->
    Meteor.call("getDmsMode",(err,res)->
      console.log res
      if res is 1
        Meteor.subscribe('gridFiles',Meteor.userId())
        setCollToBeUsed('gridFiles')

      if res is 2
        Meteor.subscribe('systemFiles',Meteor.userId())
        setCollToBeUsed('systemFiles')
      if res is 3
        Meteor.subscribe('s3Files',Meteor.userId())
        setCollToBeUsed('s3Files')


      console.log err
    )

  Template.documentList.helpers
    platformFiles:()->

      window[Session.get('collUsed')].find().fetch()

  Template.docCollection.events
    'click .lib-item':(e)->
      window.open this.url() , "_blank"
  Template.documentList.events
    'click .file-delete-btn':(e)->
      window[Session.get('collUsed')].remove({_id:this._id})
  Template.docCollection.helpers
    platformFiles:()->

      window[Session.get('collUsed')].find({tag:Meteor.user().profile}).fetch()
    getFileIcon:(fid)->
      switch window[Session.get('collUsed')].findOne(fid).original.type
        when 'image/png' then return "/assets/dashboardimages/png-icon.png"
        when 'image/jpeg' then return "/assets/dashboardimages/jpeg-icon.png"
        when 'image/gif' then return "/assets/dashboardimages/gif-icon.png"
        when 'image/x-icon' then return "/assets/dashboardimages/file-icon.png"
        when 'image/tiff' then return "/assets/dashboardimages/tiff-icon.png"
        when 'image/vnd.adobe.photoshop' then return "/assets/dashboardimages/psd-icon.png"
        when 'image/x-cmx' then return "/assets/dashboardimages/file-icon.png"
        when 'image/vnd.dwg' then return "/assets/dashboardimages/file-icon.png"
        when 'image/vnd.xiff' then return "/assets/dashboardimages/file-icon.png"
        when 'image/svg+xml' then return "/assets/dashboardimages/file-icon.png"
        when 'image/x-rgb' then return "/assets/dashboardimages/file-icon.png"
        when 'image/webp' then return "/assets/dashboardimages/file-icon.png"
        when 'image/x-xbitmap' then return "/assets/dashboardimages/file-icon.png"
        when 'image/vnd.dxf' then return "/assets/dashboardimages/file-icon.png"
        when 'image/bmp' then return "/assets/dashboardimages/bmp-icon.png"
        when 'image/vnd.dvb.subtitle' then return "/assets/dashboardimages/file-icon.png"
        when 'image/x-cmu-raster' then return "/assets/dashboardimages/file-icon.png"
        when 'video/x-fli' then return "/assets/dashboardimages/file-icon.png"
        when 'video/h261' then return "/assets/dashboardimages/file-icon.png"
        when 'video/h263' then return "/assets/dashboardimages/file-icon.png"
        when 'video/h264' then return "/assets/dashboardimages/file-icon.png"
        when 'video/jpm' then return "/assets/dashboardimages/file-icon.png"
        when 'video/x-m4v' then return "/assets/dashboardimages/file-icon.png"
        when 'video/mpeg' then return "/assets/dashboardimages/mpeg-icon.png"
        when 'video/mp4' then return "/assets/dashboardimages/mpeg-icon.png"
        when 'video/ogg' then return "/assets/dashboardimages/file-icon.png"
        when 'video/webm' then return "/assets/dashboardimages/file-icon.png"
        when 'video/quicktime' then return "/assets/dashboardimages/mov-icon.png"
        when 'video/3gpp' then return "/assets/dashboardimages/file-icon.png"
        when 'video/3gpp2' then return "/assets/dashboardimages/file-icon.png"
        when 'video/x-msvideo' then return "/assets/dashboardimages/avi-icon.png"
        when 'video/x-f4v' then return "/assets/dashboardimages/file-icon.png"
        when 'video/x-flv' then return "/assets/dashboardimages/file-icon.png"
        when 'video/x-fli' then return "/assets/dashboardimages/file-icon.png"
        when 'video/x-ms-wmv' then return "/assets/dashboardimages/wmv-icon.png"
        when 'audio/x-mpegurl' then return "/assets/dashboardimages/mpeg-icon.png"
        when 'audio/x-ms-wma' then return "/assets/dashboardimages/wma-icon.png"
        when 'audio/x-ms-wax' then return "/assets/dashboardimages/wav-icon.png"
        when 'audio/midi' then return "/assets/dashboardimages/midi-icon.png"
        when 'audio/mpeg' then return "/assets/dashboardimages/mpeg-icon.png"
        when 'audio/mp4' then return "/assets/dashboardimages/file-icon.png"
        when 'audio/ogg' then return "/assets/dashboardimages/file-icon.png"
        when 'audio/webm' then return "/assets/dashboardimages/file-icon.png"
        when 'audio/x-wav' then return "/assets/dashboardimages/wav-icon.png"
        when 'audio/x-aac' then return "/assets/dashboardimages/file-icon.png"
        when 'audio/x-aiff' then return "/assets/dashboardimages/file-icon.png"
        when 'application/vnd.ms-powerpoint' then return "/assets/dashboardimages/ppt-icon.png"
        when 'application/vnd.ms-powerpoint.addin.macroenabled.12' then return "/assets/dashboardimages/ppt-icon.png"
        when 'application/vnd.ms-powerpoint.slideshow.macroenabled.12' then return "/assets/dashboardimages/ppt-icon.png"
        when 'application/vnd.ms-powerpoint.template.macroenabled.12' then return "/assets/dashboardimages/ppt-icon.png"
        when 'application/vnd.ms-powerpoint.slide.macroenabled.12' then return "/assets/dashboardimages/ppt-icon.png"
        when 'application/vnd.ms-powerpoint.presentation.macroenabled.12' then return "/assets/dashboardimages/ppt-icon.png"
        when "application/vnd.openxmlformats-officedocument.presentationml.presentation" then return "/assets/dashboardimages/ppt-icon.png"

        when 'application/vnd.ms-project' then return "/assets/dashboardimages/ppt-icon.png"
        when 'application/vnd.ms-excel' then return "/assets/dashboardimages/xlsx-icon.png"
        when 'application/vnd.ms-excel.addin.macroenabled.12' then return "/assets/dashboardimages/xlsx-icon.png"
        when 'application/vnd.ms-excel.sheet.binary.macroenabled.12' then return "/assets/dashboardimages/xlsx-icon.png"
        when 'application/vnd.ms-excel.template.macroenabled.12' then return "/assets/dashboardimages/xlsx-icon.png"
        when 'application/vnd.ms-excel.sheet.macroenabled.12' then return "/assets/dashboardimages/xlsx-icon.png"
        when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' then return "/assets/dashboardimages/word-icon.png"
        when 'application/vnd.openxmlformats-officedocument.wordprocessingml.template' then return "/assets/dashboardimages/word-icon.png"
        when 'application/msword' then return "/assets/dashboardimages/word-icon.png"
        when 'application/x-mswrite' then return "/assets/dashboardimages/text-icon.png"
        when 'application/vnd.wordperfect' then return "/assets/dashboardimages/word-icon.png"
        when 'application/vnd.kde.kword' then return "/assets/dashboardimages/text-icon.png"
        when 'application/vnd.ms-word.document.macroenabled.12' then return "/assets/dashboardimages/word-icon.png"
        when 'application/vnd.ms-word.template.macroenabled.12' then return "/assets/dashboardimages/word-icon.png"
        when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' then return "/assets/dashboardimages/text-icon.png"
        when 'application/vnd.openxmlformats-officedocument.wordprocessingml.template' then return "/assets/dashboardimages/text-icon.png"
        when 'application/pdf' then return "/assets/dashboardimages/pdf-icon.png"
        when 'application/zip' then return "/assets/dashboardimages/zip-icon.png"
        when 'application/x-7z-compressed' then return "/assets/dashboardimages/zip-icon.png"
        when 'application/x-rar-compressed' then return "/assets/dashboardimages/rar-icon.png"

#

  Template.uploadModal.helpers
    platformProfiles:()->
      platforms.findOne().profiles

  Template.uploadFileBtn.events
    'click .upload-file':(e)->
      $('.modal').modal()

#      $('#new-user-files').trigger('click')



    'click  .create-new-file':(e)->
      $("#overlay").show()
      Session.set("docLeft",document.getElementById('new-user-files').files.length)
      for f in document.getElementById('new-user-files').files
        plfile = new FS.File(f)
        plfile.platform = platforms.findOne()._id
        plfile.owner = Meteor.userId()
        plfile.description = $("#fileDesc").val()
        plfile.tag = $('#doc-profile').val()
        x = window[Session.get('collUsed')].insert(plfile)
        x.on("uploaded",()->
          nowLeft = parseInt(Session.get("docLeft")) - 1
          Session.set("docLeft",nowLeft)
          $('.modal').modal('hide')

        )


        Tracker.autorun(()->
          if Session.get("docLeft") is 0
            $("#overlay").hide()
        )


