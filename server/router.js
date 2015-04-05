// Router.map(function() {
//   this.route('serverFile', {
//     where: 'server',
//     path: '/cfs123/files/assetFiles/:fid/:iid',
//     action: function() {
//       console.log(this);
//       var fs = Npm.require('fs');
//       var filePath = process.env.PWD + '/.cfs/files/assetFiles/' + this.params.fid + "/"+ this.params.iid;
//       var data = fs.readFile(filePath);
//       this.response.writeHead(200, {
//         'Content-Type': 'image'
//       });
//       this.response.write(data);
//       this.response.end();
//     }
//   });
// });
