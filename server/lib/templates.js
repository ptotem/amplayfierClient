Templates = {};

Templates.sampleMail = {
    path: '/root/build/bundle/programs/server/assets/app/sample-email/newuser.html',    // Relative to the 'private' dir.
    scss: 'sample-email/style.scss',       // Mail specific SCSS.

    helpers: {
        capitalizedName: function() {
            return this.name.charAt(0).toUpperCase() + this.name.slice(1);
        }
    },

    route: {
        path: '/sample/:name',

        data: function() {
            return {
                name: this.params.name,
                names: ['Johan', 'John', 'Paul', 'Ringo']
            };
        }
    }
};
Templates.resetPassword = {
    path: 'sample-email/resetpassword.html',    // Relative to the 'private' dir.
    scss: 'sample-email/style.scss',       // Mail specific SCSS.

    helpers: {
        capitalizedName: function() {
            return this.name.charAt(0).toUpperCase() + this.name.slice(1);
        }
    },

    route: {
        path: '/resetpassword/:name',

        data: function() {
            return {
                name: this.params.name,
                names: ['Johan', 'John', 'Paul', 'Ringo']
            };
        }
    }
};

Templates.newRegister = {
    path: 'sample-email/newuser.html',    // Relative to the 'private' dir.


    helpers: {
        capitalizedName: function() {
            return this.name.charAt(0).toUpperCase() + this.name.slice(1);
        }
    },

    route: {
        path: '/newuser/:name',

        data: function() {
            return {
                name: this.params.name,
                names: ['Johan', 'John', 'Paul', 'Ringo']
            };
        }
    }
};


Templates.assessmentMail = {
    path: 'sample-email/assessmentMail.html',    // Relative to the 'private' dir.


    helpers: {
        capitalizedName: function() {
            return this.name.charAt(0).toUpperCase() + this.name.slice(1);
        }
    },

    route: {
        path: '/assessmentMail/:name',

        data: function() {
            return {
                name: this.params.name,
                names: ['Johan', 'John', 'Paul', 'Ringo']
            };
        }
    }
};

