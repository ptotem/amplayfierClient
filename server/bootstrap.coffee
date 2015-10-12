@clearAllData = ()->
  reports.remove({})
  userCompletions.remove({})
  userNodeCompletions.remove({})

@getDeckScore = (id)->
  r = reports.findOne(id)
  maxPossiblePoints = 0
  totalIdealTime = 0
  actualPoints = 0
  actualTime = 0

  for sd in r.slideData
    totalIdealTime+= parseInt(sd['slideMaxTime'])
    actualTime+= parseInt(sd['slideTime'])
    actualPoints+= parseFloat(sd['slideScore'])
    maxPossiblePoints+=parseInt(sd['slidePoints'])
#  maxPossiblePoints
  [maxPossiblePoints,actualPoints,actualPoints*100/maxPossiblePoints]
#  parseInt(actualTime*100/totalIdealTime)
#
@getNodeScore = (seq,uid,pid)->
  flag = true
  for d in platforms.findOne(pid).nodes[seq].decks
    if _.pluck(userCompletions.find({userId:uid,deckId:d}).fetch(),'perscore').indexOf(100) is -1
      flag = false
  flag



Mailer.config({
  from: 'Team Amplayfier  <info@ptotem.com',
  replyTo: 'Team Amplayfier <info@ptotem.com'
});



initDMS(1,{})

@initMailers = ()->
  Mailer.init
    templates: Templates
    helpers: TemplateHelpers
#    layout:
#      name: 'emailLayout'
#      path: 'layout.html'
#      scss: 'layout.scss'




createBadges = ()->
  systemBadges.remove({})
  systemBadges.insert({index:0,name:"firstTimeLandMedal",display_name:"Well Started",value:100,imgPath:'/assets/badgeimages/wellstarted-bw.png',display_title:'Start the game to win this badge',display_desc:'You will win 100 credits when you get this badge'})
  systemBadges.insert({index:1,name:"chapterCompleteMedal",display_name:"Milestone",value:50,imgPath:'/assets/badgeimages/milestone-bw.png',display_title:'Complete a chapter to win this badge',display_desc:'You will win 50 credits when you get this badge'})
  systemBadges.insert({index:2,name:"allNodeComplete",display_name:"All Done",value:100,imgPath:'/assets/badgeimages/alldone-bw.png',display_title:'Complete all chapters to win this badge',display_desc:'You will win 100 credits when you get this badge'})
  systemBadges.insert({index:3,name:"fullScoreInDecks",display_name:"Thorough Decks",value:200,imgPath:'/assets/badgeimages/thorough-bw.png',display_title:'Complete all decks with a full score to win this badge',display_desc:'You will win 200 credits when you get this badge'})
  systemBadges.insert({index:4,name:"fullScoreInAGame",display_name:"Flawless Victory",value:10,imgPath:'/assets/badgeimages/flawless-bw.png',display_title:'Complete a game with a full score to win this badge',display_desc:'You will win 10 credits when you get this badge'})
  systemBadges.insert({index:5,name:"fullScoreInAllGames",display_name:"Mr. Perfect",value:500,imgPath:'/assets/badgeimages/mrperfect-bw.png',display_title:'Complete all games with a full score to win this badge',display_desc:'You will win 500 credits when you get this badge'})
  systemBadges.insert({index:6,name:"fullScoreInEverything",display_name:"Master Mind",value:500,imgPath:'/assets/badgeimages/mastermind-bw.png',display_title:'Complete all decks and games with a full score to win this badge',display_desc:'You will win 500 credits when you get this badge'})
  systemBadges.insert({index:7,name:"revisionary",display_name:"Revisionary",value:500,imgPath:'/assets/badgeimages/revisionary-bw.png',display_title:'Complete all decks and games twice to win this badge',display_desc:'You will win 500 credits when you get this badge'})
  systemBadges.insert({index:8,name:"topHat",display_name:"Top Hat",value:1000,imgPath:'/assets/badgeimages/rocketman-bw.png',display_title:'Make it to the top 10 on the leaderboard to win this badge',display_desc:'You will win 1000 credits when you get this badge'})
  systemBadges.insert({index:9,name:"god",display_name:"God of all things",value:1000,imgPath:'/assets/badgeimages/god-bw.png',display_title:'Win all badges to get this badge',display_desc:'You will win 1000 credits when you get this badge'})


addScoringConfig = ()->
  quoScoreConfig.remove({})
  if platforms.findOne({_id:"NAAscuNtRALrgHBdE"})?
    qDecks = platforms.findOne({_id:"NAAscuNtRALrgHBdE"}).quodecks
    console.log "Start executing this function......"
    console.log platforms.findOne({_id:"NAAscuNtRALrgHBdE"})
    console.log "list of quodecks"
    configuration = [
        {
            "quoid": qDecks[0],
            "mapping": [
                # Reflect the range of scores which can come back from the Quo and the corresponding values
                {"score": "1", "value": ["75", "50", "25", "0"]},
                {"score": "2", "value": ["75", "25", "25", "25"]},
                {"score": "3", "value": ["50", "50", "50", "0"]},
                {"score": "4", "value": ["50", "50", "25", "25"]}
            ],
            "criteria": [
                # Inputvars should be the index of the columns in the mapping values
                # Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
                {"sequence": 1, "name": "C1", "inputvars": [0], "logic": "minTotal", "args": "350"},
                {"sequence": 2, "name": "C2", "inputvars": [1], "logic": "minTotal", "args": "250"},
                {"sequence": 3, "name": "C3", "inputvars": [2], "logic": "minTotal", "args": "150"},
                {"sequence": 4, "name": "C4", "inputvars": [3], "logic": "minTotal", "args": "50"},
                {"sequence": 5, "name": "C5", "inputvars": [], "logic": "and", "args": ["C1", "C2", "C3", "C4"]},
                {"sequence": 6, "name": "C6", "inputvars": [], "logic": "not", "args": "C5"}
            ],
            "payoff": [
                # Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                {"inputvar": 0, "criteria": "C1", "value": "asIs", "multiplier": "1"},
                {"inputvar": 1, "criteria": "C2", "value": "asIs", "multiplier": "1"},
                {"inputvar": 2, "criteria": "C3", "value": "asIs", "multiplier": "1"},
                {"inputvar": 3, "criteria": "C4", "value": "asIs", "multiplier": "1"}
            ],
            "gameMaster": [
                # Game Master Payoff defined the same way as payoff
                {"inputvar": 0, "criteria": "C6", "value": "150", "multiplier": "1"}
            ]
        },
        {
            "quoid": qDecks[1],
            "mapping": [
                # Reflect the range of scores which can come back from the Quo and the corresponding values
                {"score": "1", "value": ["75", "50", "0", "0"]},
                {"score": "2", "value": ["75", "25", "25", "0"]},
                {"score": "3", "value": ["50", "50", "0", "25"]},
                {"score": "4", "value": ["25", "50", "25", "25"]}
            ],
            "criteria": [
                # Variables should be the index of the columns in the mapping values
                # Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
                {"sequence": 1, "name": "C1", "inputvars": [0], "logic": "minTotal", "args": "350"},
                {"sequence": 2, "name": "C2", "inputvars": [1], "logic": "minTotal", "args": "250"},
                {"sequence": 3, "name": "C3", "inputvars": [2], "logic": "minTotal", "args": "150"},
                {"sequence": 4, "name": "C4", "inputvars": [3], "logic": "minTotal", "args": "100"},
                {"sequence": 5, "name": "C5", "inputvars": [], "logic": "and", "args": ["C1", "C2", "C3", "C4"]},
                {"sequence": 6, "name": "C6", "inputvars": [], "logic": "not", "args": "C5"}
            ],
            "payoff": [
                # Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
                {"inputvar": 0, "criteria": "C1", "value": "asIs", "multiplier": "1"},
                {"inputvar": 1, "criteria": "C2", "value": "asIs", "multiplier": "1"},
                {"inputvar": 2, "criteria": "C3", "value": "asIs", "multiplier": "1"},
                {"inputvar": 3, "criteria": "C4", "value": "asIs", "multiplier": "1"}
            ],
            "gameMaster": [
                # Game Master Payoff defined the same way as payoff
                {"inputvar": 0, "criteria": "C6", "value": "150", "multiplier": "1"}
            ]
        }#,
        # {
        #     "quoid": qDecks[0],
        #     "mapping": [
        #         # Reflect the range of scores which can come back from the Quo and the corresponding values
        #         {"score": "1", "value": ["75", "50", "0", "0"]},
        #         {"score": "2", "value": ["75", "25", "25", "0"]},
        #         {"score": "3", "value": ["50", "50", "0", "25"]},
        #         {"score": "4", "value": ["25", "50", "25", "25"]}
        #     ],
        #     "criteria": [
        #         # Variables should be the index of the columns in the mapping values
        #         # Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
        #         {"sequence": 1, "name": "C1", "inputvars": [0], "logic": "minTotal", "args": "350"},
        #         {"sequence": 2, "name": "C2", "inputvars": [1], "logic": "minTotal", "args": "250"},
        #         {"sequence": 3, "name": "C3", "inputvars": [2], "logic": "minTotal", "args": "150"},
        #         {"sequence": 4, "name": "C4", "inputvars": [3], "logic": "minTotal", "args": "100"},
        #         {"sequence": 5, "name": "C5", "inputvars": [], "logic": "and", "args": ["C1", "C2", "C3", "C4"]},
        #         {"sequence": 6, "name": "C6", "inputvars": [], "logic": "not", "args": "C5"}
        #     ],
        #     "payoff": [
        #         # Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
        #         {"inputvar": 0, "criteria": "C1", "value": "asIs", "multiplier": "1"},
        #         {"inputvar": 1, "criteria": "C2", "value": "asIs", "multiplier": "1"},
        #         {"inputvar": 2, "criteria": "C3", "value": "asIs", "multiplier": "1"},
        #         {"inputvar": 3, "criteria": "C4", "value": "asIs", "multiplier": "1"}
        #     ],
        #     "gameMaster": [
        #         # Game Master Payoff defined the same way as payoff
        #         {"inputvar": 0, "criteria": "C6", "value": "150", "multiplier": "1"}
        #     ]
        # },
        # {
        #     "quoid": qDecks[1],
        #     "mapping": [
        #         # Reflect the range of scores which can come back from the Quo and the corresponding values
        #         {"score": "1", "value": ["Arjun", "Shikhandi", "0"]},
        #         {"score": "2", "value": ["Arjun", "", "50"]},
        #         {"score": "3", "value": ["", "Shikhandi", "100"]},
        #         {"score": "4", "value": ["", "", "200"]}
        #     ],
        #     "criteria": [
        #         # Variables should be the index of the columns in the mapping values
        #         # Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
        #         {"sequence": 1, "name": "C1", "inputvars": [2], "logic": "minTotal", "args": "750"},
        #         {
        #             "sequence": 2,
        #             "name": "C2",
        #             "inputvars": [0, 1],
        #             "logic": "unionAnd",
        #             "args": ["Arjun", "Shikhandi"]
        #         },
        #         {"sequence": 3, "name": "C3", "inputvars": [], "logic": "and", "args": ["C1", "C2"]},
        #         {"sequence": 4, "name": "C4", "inputvars": [], "logic": "not", "args": "C3"}
        #     ],
        #     "payoff": [
        #         # Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
        #         {"inputvar": 2, "criteria": "C1", "value": "asIs", "multiplier": "1"},
        #         {"inputvar": 0, "criteria": "C3", "value": "250", "multiplier": "1"},
        #         {"inputvar": 1, "criteria": "C3", "value": "150", "multiplier": "1"}
        #     ],
        #     "gameMaster": [
        #         # Game Master Payoff defined the same way as payoff
        #         {"inputvar": 0, "criteria": "C4", "value": "250", "multiplier": "1"}
        #     ]
        # },
        # {
        #     "quoid": qDecks[0],
        #     "mapping": [
        #         # Reflect the range of scores which can come back from the Quo and the corresponding values
        #         {"score": "1", "value": ["Yudishthir", "Arjun", "0"]},
        #         {"score": "2", "value": ["Yudishthir", "", "100"]},
        #         {"score": "3", "value": ["", "Arjun", "200"]},
        #         {"score": "4", "value": ["", "", "300"]}
        #     ],
        #     "criteria": [
        #         # Variables should be the index of the columns in the mapping values
        #         # Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
        #         {"sequence": 1, "name": "C1", "inputvars": [0, 1], "logic": "unionAnd", "args": ["Yudishthir", "Arjun"]},
        #         {"sequence": 2, "name": "C2", "inputvars": [], "logic": "not", "args": "C1"}
        #     ],
        #     "payoff": [
        #         # Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
        #         {"inputvar": 0, "criteria": "C1", "value": "100", "multiplier": "1"},
        #         {"inputvar": 1, "criteria": "C1", "value": "50", "multiplier": "1"},
        #         {"inputvar": 2, "criteria": "C1", "value": "asIs", "multiplier": "1"}
        #     ],
        #     "gameMaster": [
        #         # Game Master Payoff defined the same way as payoff
        #         {"inputvar": 0, "criteria": "C2", "value": "250", "multiplier": "1"}
        #     ]
        # },
        # {
        #     "quoid": qDecks[1],
        #     "mapping": [
        #         # Reflect the range of scores which can come back from the Quo and the corresponding values
        #         {"score": "1", "value": ["", "", "0"]},
        #         {"score": "2", "value": ["Bheem", "", "150"]},
        #         {"score": "3", "value": ["", "Break", "300"]},
        #         {"score": "4", "value": ["", "", "500"]}
        #     ],
        #     "criteria": [
        #         # Variables should be the index of the columns in the mapping values
        #         # Logic can be unionAnd, unionOr, eachAnd, eachOr, minTotal, maxTotal
        #         {"sequence": 1, "name": "C1", "inputvars": [0, 1], "logic": "unionAnd", "args": ["Bheem", "Break"]},
        #         {"sequence": 2, "name": "C2", "inputvars": [2], "logic": "not", "args": "C1"}
        #     ],
        #     "payoff": [
        #         # Criteria can be none or a name. Value can be a fixed number or asIs with a multipler
        #         {"inputvar": 0, "criteria": "C1", "value": "250", "multiplier": "1"},
        #         {"inputvar": 2, "criteria": "C1", "value": "asIs", "multiplier": "1"},
        #         {"inputvar": 2, "criteria": "C2", "value": "asIs", "multiplier": "-1"}
        #     ],
        #     "gameMaster": [
        #         # Game Master Payoff defined the same way as payoff
        #         {"inputvar": 0, "criteria": "C2", "value": "350", "multiplier": "1"}
        #     ]
        # }
    ]
    quoScoreConfig.insert(configuration)


Meteor.startup(()->

#  SyncedCron.start();

  # initMailers()
  # startUpRoutine()
  resetCapabilities()
  createBadges()
  console.log "creating badges"
  addCapabilities("Can add user",'add_user')
  addCapabilities("Can edit user",'edit_user')
  addCapabilities("Can delete user",'delete_user')
  addCapabilities("Can upload users",'upload_user')
  addCapabilities("Can send mass communication",'send_mass_communication')
  addCapabilities("Can send individual communication",'send_individual_communication')
  addCapabilities("Can add roles",'add_roles')
  addCapabilities("Can delete roles",'delete_roles')
  addCapabilities("Can update roles",'update_roles')

  addCapabilities("Can assign roles",'assign_user')
  addCapabilities("Can upload documents",'upload_documents')
  addCapabilities("Can download documents",'download_documents')
  addCapabilities("Can delete documents",'delete_documents')
  addCapabilities("Can view reports",'view_reports')
  addCapabilities("Can customize reports",'customize_reports')
  addCapabilities("Can view Admin Panel",'view_admin_panel')
  addCapabilities("Can Disable Features",'disable_features')
  # addScoringConfig()








  @mailgunoptions =

    apiKey: 'key-036bf41682cc241d89084bfcaba352a4',
    domain: 'amplayfier.com',
    defaultFrom:'info@amplayfier.com'


  reCAPTCHA.config({
    privatekey: '6Le9gwITAAAAAC8oUhSpzgFSwBYyD_QzLyJ9I28P'
  });
)


reports.deny
  update:(uid,docs,fields,modifier)->
    if fields.indexOf('deckComplete') isnt -1
      true
    else
      false

Meteor.users.deny
  update:(uid,docs,fields,modifier)->
    if fields.indexOf('currency') isnt -1 or fields.indexOf('score') isnt -1 or fields.indexOf('redeemedRewards') isnt -1
      true
    else
      false





reports.find().observeChanges
  changed:(id,field)->
#    if reports.findOne(attempt).slideData.length is reports.findOne(attempt).slideCount

      if field['deckComplete']?
        false
      else
        if field['attemptComplete']?
          thisreport = reports.findOne(id)
          if thisreport.slideData.length >= thisreport.slideCount
            reports.update({_id:id},{$set:{deckComplete:true}})
            ds = getDeckScore(id)
            deckScore = ds[2]
            deckMaxScore = ds[0]
            deckActualScore = ds[1]
            markModuleAsComplete(thisreport.deckId,thisreport.userId,thisreport.platformId,true,id,deckScore,deckActualScore,deckMaxScore)
            deckCompleteEvent.trigger({uid:thisreport.userId,rid:id})

  #        we now check for individual node completions in this platform and assign badges accordingly so the user cannot cheat
          nodeflag = true
          for n,i in platforms.findOne(thisreport.platformId).nodes
            if n.decks?
              flag = true
              for d in n.decks
  #              console.log _.pluck(reports.find({userId:thisreport.userId,deckId:d}).fetch(),'deckComplete')
                if  _.pluck(reports.find({userId:thisreport.userId,deckId:d}).fetch(),'deckComplete').length is 0 or _.pluck(reports.find({userId:thisreport.userId,deckId:d}).fetch(),'deckComplete').indexOf(true) is -1
                  flag = false
  #            console.log flag
              if flag
                userNodeStatus.insert({userId:thisreport.userId,nodeSeq:i,status:'complete'})
#                getNodeScore(id,i,thisreport.userId)
                if !userNodeCompletions.findOne({userId:thisreport.userId,nodeSeq:i})?
                  userNodeCompletions.insert({platformId:thisreport.platformId,userId:thisreport.userId,nodeSeq:i,status:'complete',createdAt:new Date().getTime()})
                sts = getNodeScore(i,thisreport.userId,thisreport.platformId)
                chapterCompleteEvent.trigger({status:sts,uid:thisreport.userId,node:i,pid:thisreport.platformId})
              else
                nodeflag = false
          if nodeflag
            allChapterCompleteEvent.trigger({uid:thisreport.userId,pid:thisreport.platformId})




#
#Meteor.users.find().observeChanges
#  added: (post) ->
#  # When new posts are added, the user gain the points.
##    Meteor.users.update post.userId, $inc: 'profile.points': 5
#    return
#  changed: (id,fields)->
#    if fields['currency']
#
#reports.observeChanges
#  changed:(id,fields)->
#    console.log "********************"
#    console.log id
#    console.log fields
#    console.log "********************"

#
# Meteor.startup(()->
#  startUpRoutine()
# )
#
# @startUpRoutine  =()->
 # generateSeedUsers()

#
# @generateSeedUsers = ()->
#    platformType.remove({})
#    platformType.insert({platformId:"YpqpefGhPfQXecggT",platformLimit:100,platformLicenseType:"free"})
  #  htmlContent ='<div class="slide active" data-slideId="1"></div><div class="slide" data-slideId="2"></div><div class="slide" data-slideId="3"></div>'
#    deckHtml.remove({})
#    tid = platforms.insert({tenantId:"gejwshGxzzsHwE9RK",tenantName:"checkV2", licenseType: ""})
#    deckHtml.insert({deckname:"dname-1",platformId:tid,tenantId:-1,deckId:"123",variants:["hello","hi","cool"]})
#    deckHtml.insert({deckname:"dname-2",platformId:tid,tenantId:-1,deckId:"122"})
#    deckHtml.insert({deckname:"dname-3",platformId:tid,tenantId:-1,deckId:"121",variants:["its","not","working"]})
#    deckHtml.insert({deckname:"dname-4",platformId:tid,tenantId:-1,deckId:"120"})
#    deckHtml.insert({deckname:"dname-5",platformId:tid,tenantId:-1,deckId:"119",variants:["dark","knight","rises"], htmlContent:htmlContent})
#
#    Meteor.users.remove({seed_user:true})
#    Accounts.createUser({email:"developer|testv2@ptotem.com",password:"password",role:"admin",tid:123,personal_profile:{},seed_user:true})
#    Accounts.createUser({email:"nilesh|sample@ptotem.com",password:"p20o20e13",role:"player",tid:123,personal_profile:{},seed_user:true})
  #  Accounts.createUser({email:"author@ptotem.com",password:"author123",role:"author",tid:-1,personal_profile:{},seed_user:true})
  #  Accounts.createUser({email:"designer@ptotem.com",password:"designer123",role:"designer",tid:-1,personal_profile:{},seed_user:true})
  #  Accounts.createUser({email:"developer@ptotem.com",password:"developer123",tid:-1,role:"developer",personal_profile:{},seed_user:true})
