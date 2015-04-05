Package.describe({
  name: 'rushabhhathi:amplayfieracl',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: 'A plugin for managing ACL in the amplayfier client',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/SauronTheGreat/amplayfieracl.git',
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

    api.use('underscore', 'client');
    api.addFiles('collectionDefinition.coffee');
    api.addFiles('client/roleTemplates.html');
    api.addFiles('client/roleTemplates.coffee');
    api.addFiles('server/server.coffee');
    api.addFiles('amplayfieracl.js');
    api.addFiles('handlebar/handlebar.coffee')
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('rushabhhathi:amplayfieracl');
  api.addFiles('amplayfieracl-tests.js');
});
