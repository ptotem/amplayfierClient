initDMS(1,{})


Meteor.startup(()->
  # startUpRoutine()
  resetCapabilities()

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








  @mailgunoptions =

    apiKey: 'key-036bf41682cc241d89084bfcaba352a4',
    domain: 'amplayfier.com',
    defaultFrom:'info@amplayfier.com'


  reCAPTCHA.config({
    privatekey: '6Le9gwITAAAAAC8oUhSpzgFSwBYyD_QzLyJ9I28P'
  });
)






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
