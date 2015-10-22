Shower({
    name:"registerForm",
    template:"register",
    fields:{
        email:{
            required:true,
            message: "E-mail ID is a mandatory field",
            format: "email"
        },
        fullname:{
            required: true,
            format: "alphanumeric",
            message: "Name must be greater than 4 characters",
            rules:{
                maxLength:20,
                minLength:4
            }
        },
        password:{
            required:true,
            message:"Password is a mandatory field",
            rules:{
                minLength:6
            }
        },
        confirmpassword:{
            required:true,
            message:"Password must be greater than 6 characters",
            rules:{
                minLength:6
            }
        },
        teamSelection:{
            required:true,
            message:"Team is a mandatory field",
            
        }
    }
});
