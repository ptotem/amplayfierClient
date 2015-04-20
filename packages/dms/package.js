Package.describe({
  name: 'rushabhhathi:dms',
  version: '0.0.3',
  // Brief, one-line summary of the package.
  summary: 'A simple and configurable Document Managemet System for your meteor application',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/SauronTheGreat/documentManagementSystem',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  
  
  api.versionsFrom('1.0.2.1');
    var both = ['client', 'server'];

    api.use('coffeescript', both);
    api.use(['templating'], 'client');
    api.use('handlebars', 'client');
    //api.use("UI",'client');
  api.use('underscore', 'client');
    api.use(['cfs:filesystem@0.1.1','cfs:gridfs@0.0.27','cfs:standard-packages@0.5.3','cfs:s3@0.0.0'],both);
  api.addFiles('dms.coffee');
  api.addFiles('collectionDefinitions.coffee');
  api.addFiles('clientTemplates/documentList.html');
    api.addFiles('clientTemplates/documentList.coffee');
  api.addFiles('clientTemplates/handlebar.coffee')
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('rushabhhathi:dms');
  api.addFiles('dms-tests.js');
});
