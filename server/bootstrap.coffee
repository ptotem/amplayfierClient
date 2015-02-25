

Meteor.startup(()->
  startUpRoutine()
)
#
@startUpRoutine  =()->
  generateSeedUsers()

@generateSeedUsers = ()->
    platforms.remove({})
    deckHtml.remove({})
    tid = platforms.insert({tenantId:-1,tenantName:"rakesh",backgroundUrl:'http://wallpoper.com/images/00/31/33/51/black-background_00313351.jpg',platformLogo:'http://4.bp.blogspot.com/-yPf7kImILf0/UOFI_7OHlEI/AAAAAAAAF7k/fiUjRLKN6Hg/s1600/amplifierLogo.jpg',platformFavicon:"http://faviconicon.com/uploads/2010-09-23/1285245556-624813-256.png"})._id
    deckHtml.insert({deckname:"dname-1",platformId:tid,tenantId:-1,deckId:"123",variants:["hello","hi","cool"]})
    deckHtml.insert({deckname:"dname-2",platformId:tid,tenantId:-1,deckId:"122"})
    deckHtml.insert({deckname:"dname-3",platformId:tid,tenantId:-1,deckId:"121",variants:["its","not","working"]})
    deckHtml.insert({deckname:"dname-4",platformId:tid,tenantId:-1,deckId:"120"})
    deckHtml.insert({deckname:"dname-5",platformId:tid,tenantId:-1,deckId:"119",variants:["dark","knight","rises"]})
    # platforms.insert({tenantId:-1,tenantName:"rakesh"})
    Meteor.users.remove({seed_user:true})
    Accounts.createUser({email:"sunny@ptotem.com",password:"p20o20e13",role:"admin",tid:tid,personal_profile:{},seed_user:true})
    # Accounts.createUser({email:"author@ptotem.com",password:"author123",role:"author",tid:-1,personal_profile:{},seed_user:true})
    # Accounts.createUser({email:"designer@ptotem.com",password:"designer123",role:"designer",tid:-1,personal_profile:{},seed_user:true})
    # Accounts.createUser({email:"developer@ptotem.com",password:"developer123",tid:-1,role:"developer",personal_profile:{},seed_user:true})
