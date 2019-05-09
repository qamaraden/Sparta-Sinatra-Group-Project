$(function (){

  $('.dropdown-toggle').dropdown()

  $('input[type=text]').keyup(function() {

    var emailInput = $(this).val();

    if(emailInput.match(/[a-z0-9._%+-]+[@spartaglobal.com$]/)) {

    } else {

      console.log("wrong email domain")

    }

  });

  $('input[type=password]').keyup(function() {

    var passwordInput = $(this).val();

    if(passwordInput.match(/[a-z]/)) {

    } else {

      console.log("no lower case")

    }

    if( passwordInput.match(/[A-Z]/) ) {

    } else {

      console.log("no upper case")

    }

    if(passwordInput.match(/[0-9]/)) {

    } else {

      console.log("no nums")

    }

    if(passwordInput.length >= 8 && passwordInput.length <= 15) {

    } else {

      console.log("too short")

    }

  });

  $(loginButton).click(function () {

    console.log("BWAMP")

    // if () {

    // } else {

    // $(".message").css("visibility", "visible");

    // };

  });

});

 
