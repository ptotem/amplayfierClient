Package.describe({
  name: 'rushabhhathi:mailersinapp',
  version: '0.0.2',
  // Brief, one-line summary of the package.
  summary: 'Add mailer support using mailgun used currently in a private environment.',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/SauronTheGreat/mailerPackage',
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

    api.use('handlebars', 'client');
  api.use('underscore', 'client');
  api.use(['gfk:mailgun-api@1.0.0','summernote:summernote@0.5.10'
],both);
  
  api.addFiles('mailersinapp.js');
    api.addFiles('collectionDefinitions.coffee');
  api.addFiles("server/mailerMethods.coffee");
    api.addFiles('clientTemplates/massmailer.css');

    api.addFiles('clientTemplates/massMailer.html');
    api.addFiles('clientTemplates/massMailer.coffee');

});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('rushabhhathi:mailersinapp');
  api.addFiles('mailersinapp-tests.js');
});
