

# Meteor.startup(()->
#  # startUpRoutine()
# )
#
# @startUpRoutine  =()->
#  generateSeedUsers()
#
#
# @generateSeedUsers = ()->
#    htmlContent ='<div class="slide active" data-slideId="1"></div><div class="slide" data-slideId="2"></div><div class="slide" data-slideId="3"></div>'
#    deckHtml.remove({})
#    tid = platforms.insert({tenantId:123,tenantName:"sample", licenseType: ""})
#    deckHtml.insert({deckname:"dname-1",platformId:tid,tenantId:-1,deckId:"123",variants:["hello","hi","cool"]})
#    deckHtml.insert({deckname:"dname-2",platformId:tid,tenantId:-1,deckId:"122"})
#    deckHtml.insert({deckname:"dname-3",platformId:tid,tenantId:-1,deckId:"121",variants:["its","not","working"]})
#    deckHtml.insert({deckname:"dname-4",platformId:tid,tenantId:-1,deckId:"120"})
#    deckHtml.insert({deckname:"dname-5",platformId:tid,tenantId:-1,deckId:"119",variants:["dark","knight","rises"], htmlContent:htmlContent})
#
#    Meteor.users.remove({seed_user:true})
#    Accounts.createUser({email:"sunny|sample@ptotem.com",password:"p20o20e13",role:"admin",tid:123,personal_profile:{},seed_user:true})
#    Accounts.createUser({email:"nilesh|sample@ptotem.com",password:"p20o20e13",role:"player",tid:123,personal_profile:{},seed_user:true})
  #  Accounts.createUser({email:"author@ptotem.com",password:"author123",role:"author",tid:-1,personal_profile:{},seed_user:true})
  #  Accounts.createUser({email:"designer@ptotem.com",password:"designer123",role:"designer",tid:-1,personal_profile:{},seed_user:true})
  #  Accounts.createUser({email:"developer@ptotem.com",password:"developer123",tid:-1,role:"developer",personal_profile:{},seed_user:true})
