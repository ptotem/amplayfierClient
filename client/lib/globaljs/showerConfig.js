Shower({
    name:"registerForm",
    template:"registerPage",
    fields:{
        email:{
            required:true,
            message: "Not a valid email",
            format: "email"
        },
        fullname:{
            required: true,
            format: "alphanumeric",
            message: "Only letters in a first name.",
            rules:{
                maxLength:20,
                minLength:4
            }
        },
        password:{
            required:true,
            message:"Must be at least 6 characters.",
            rules:{
                minLength:6
            }
        },
        confirmpassword:{
            required:true,
            message:"Must be at least 6 characters.",
            rules:{
                minLength:6
            }
        }
    }
});