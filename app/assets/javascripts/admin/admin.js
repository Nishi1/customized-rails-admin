$(document).ready(function () {   
    setTimeout(function () {
       $('div.alert').fadeOut("slow");
    }, 3000);  
   
    // Custom email validation
    $.validator.addMethod('customEmail', function (value, element, param) {
        var email_regex = /^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
        if (value != '') {
            if (email_regex.test(value)) {
                isValid = true;
            } else {
                isValid = false;
            }
        } else {
            isValid = true;
        }
        return isValid;
    }, 'Please enter a valid email');

    // Numeric field validation
    $.validator.addMethod("numeric_field", function (value, element, regexpr) {
        return regexpr.test(value);
    }, "Please enter numeric value");

    // Valid image validation
    $.validator.addMethod("valid_image", function (value, element, regexpr) {
        if (value != "") {
            return regexpr.test(value);
        } else {
            return true;
        }
    }, "Please select valid image");

    // Valid zip code validation
    $.validator.addMethod("valid_zip_code",function(value, element, regexpr){
        return regexpr.test(value);
    },"Please enter valid zip code")

    
    // Validation of admin form
    $("#new_admin").validate({
        rules: {
            "admin[email]": {
                required: true,
                customEmail: true
            },
            "admin[password]": {
                required: true
            },
        },
        messages: {
            "admin[email]": {
                required: "Please enter email"
            },
            "admin[password]": {
                required: "Please enter password"
            }
        }
    })

    // Validation for forgot password form
    $("#forgot_password").validate({
        rules: {
            "admin[email]": {
                required: true,
                customEmail: true,
                remote: {
                    url: "/admin/check_admin_email",
                    type: "get"
                }
            }
        },
        messages: {
            "admin[email]": {
                required: "Please enter email",
                remote: "Email does not exist",
            }
        }
    })

    // Validation for edit password form
    $("#edit_password").validate({
        rules: {
            "admin[password]": {
                required: true,
                minlength: 6,
                maxlength: 120
            },
            "admin[password_confirmation]": {
                required: true,
                minlength: 6,
                maxlength: 120,
                equalTo: '#admin_password'
            }
        },
        messages: {
            "admin[password]": {
                required: "Please enter password"
            },
            "admin[password_confirmation]": {
                required: "Please enter password",
                equalTo: "Password and confirm password does not match"
            }
        }
    });

    // Validation for new university, edit university and add university forms
    $('form.new_university , form.edit_university, form.add_university').validate({
        rules: {
            'university[name]': {
                required: true,
                minlength: 2,
                maxlength: 50,
                remote: {
                    url: "/admin/check_uniqueness",
                    data: {existing_data: $('#existing_data').val()},
                    type: "get"
                }
            },
            'university[phone]': {
                required: true,
                numeric_field: /^(0|[1-9][0-9]*)$/,
                minlength: 10,
                maxlength: 10
            },
            'university[address]': {
                required: true,
                minlength: 2,
                maxlength: 500
            },
            'university[city]': {
                required: true
            },
            'university[state]': {
                required: true
            },
            'university[zip]': {
                required: true,
                valid_zip_code : /^[0-9]{6}(?:-[0-9]{4})?$/
            },
            'university[status]': {
                required: true
            }
        },
        messages: {
            'university[name]': {
                required: "Please enter name",
                minlength: "Name must be greater than 2 characters",
                maxlength: "Name must be less than 50 characters",
                remote: "Name is already exist"
            },
            'university[phone]': {
                required: "Please enter phone number",
                numeric_field: "Phone number should be numeric",
                minlength: "Phone number must be 10 digits long",
                maxlength: "Phone number can not be more then 10 digits"
            },
            'university[address]': {
                required: "Please enter address",
                minlength: "Address must be greater than 2 characters",
                maxlength: "Address must be less than 500 characters"
            },
            'university[city]': {
                required: "Please enter city"
            },
            'university[state]': {
                required: "Please enter state"
            },
            'university[zip]': {
                required: "Please enter zip code"
            },
            'university[status]': {
                required: "Please select status"
            }
        }
    });


    // Validation for new cms page and edit cms page forms
    $('form.new_cms_page, form.edit_cms_page').validate({
        rules: {
            'cms_page[seo_url]': {
                required: true,
                minlength: 2,
                maxlength: 50,
                remote: {
                    url: "/admin/check_uniqueness",
                    data: {existing_data: $('#existing_data').val()},
                    type: "get"
                }
            },
            'cms_page[meta_desc]': {
                required: true
            },
            'cms_page[name]': {
                required: true
            },
            'cms_page[meta_title]': {
                required: true
            },
            'cms_page[meta_keyword]': {
                required: true
            },
            'cms_page[content]': {
                required: true
            },
            'cms_page[status]': {
                required: true
            }
        },
        messages: {
            'cms_page[seo_url]': {
                required: "Please enter seo url",
                minlength: "Seo URL must be greater than 2 characters",
                maxlength: "Seo URL must be less than 50 characters",
                remote: "Seo URL is already exist"
            },
            'cms_page[meta_desc]': {
                required: "Please enter description"
            },
            'cms_page[name]': {
                required: "Please enter name"
            },
            'cms_page[meta_title]': {
                required: "Please enter meta title"
            },
            'cms_page[meta_keyword]': {
                required: "Please enter meta keyword"
            },
            'cms_page[content]': {
                required: "Please enter content"
            },
            'cms_page[status]': {
                required: "Please select status"
            }
        }
    });

 

    // Validation for new user and edit user forms
    $('form.new_user, form.edit_user ').validate({
        rules: {
            'user[first_name]': {
                required: true,
                minlength: 2,
                maxlength: 50
            },
            'user[last_name]': {
                required: true,
                minlength: 2,
                maxlength: 50
            },
            'user[email]': {
                required: true,
                customEmail: true,
                remote: {
                    url: "/admin/check_uniqueness",
                    data: {existing_data: $('#existing_data').val()},
                    type: "get"
                }
            },
            'user[phone]': {
                required: true,
                numeric_field: /^(0|[1-9][0-9]*)$/,
                minlength: 10,
                maxlength: 10
            },
            'user[password]': {
                required: true
            },
            'user[university_id]': {
                required: true
            },
            'user[university_team_users_attributes][][university_team_id]': {
                required: true,
                needsSelection: true
            },
            'user[status]': {
                required: true
            }
        },
        messages: {
            'user[first_name]': {
                required: "Please enter first name",
                minlength: "First name must be greater than 2 characters",
                maxlength: "First name must be less than 50 characters"
            },
            'user[last_name]': {
                required: "Please enter last name",
                minlength: "Last name must be greater than 2 characters",
                maxlength: "Last name must be less than 50 characters"
            },
            'user[email]': {
                required: "Please enter email",
                customEmail: "Please enter a valid email",
                remote: "Email already exist"
            },
            'user[phone]': {
                required: "Please enter phone number",
                numeric_field: "Phone number should be numeric",
                minlength: "Phone number must be 10 digits long",
                maxlength: "Phone number can not be more then 10 digits"
            },
            'user[password]': {
                required: "Please enter password"
            },
            'user[university_id]': {
                required: "Please select organization"
            },
            'user[university_team_users_attributes][][university_team_id]': {
                required: "Please select team",
                needsSelection: "Please select team"
            },
            'user[status]': {
                required: "Please select status"
            }
        }
    });

    // Validation for admin change password forms
    $("#change_password").validate({
        rules: {
            "admin[old_password]": {
                required: true,
                minlength: 6,
                maxlength: 120
            },
            "admin[password]": {
                required: true,
                minlength: 6,
                maxlength: 120
            },
            "admin[password_confirmation]": {
                required: true,
                minlength: 6,
                maxlength: 120,
                equalTo: '#admin_password'
            },
        },
        messages: {
            "admin[old_password]": {
                required: "Please enter old password",
            },
            "admin[password]": {
                required: "Please enter password"
            },
            "admin[password_confirmation]": {
                required: "Please confirm password",
                equalTo: "New Password and confirm new password does not match"
            },
        }
    });
});
