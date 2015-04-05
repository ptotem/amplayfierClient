Package.describe({
  name: 'rushabhhathi:eventify',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: 'A package to add events which can be triggered and handled on server and client side',
  // URL to the Git repository containing the source code for this package.
  git: '',
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
    api.addFiles('lib/event.coffee');
    api.addFiles('server/server.coffee');
    api.addFiles('eventify.js');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('rushabhhathi:eventify');
  api.addFiles('eventify-tests.js');
});
