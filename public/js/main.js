$(function (){

  $('.dropdown-toggle').dropdown()

  $('input[type=text]').keyup(function() {

    emailInput = $(this).val();

    if(emailInput.match(/[a-zA-Z0-9._%+-]+@[s][p][a][r][t][a][g][l][o][b][a][l][.][c][o][m]$/i)) {

      console.log("bingo")

    } else {

      console.log("wrong email domain")

    }

  });

  $('input[type=password]').keyup(function() {

    passwordInput = $(this).val();

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

  $(userSave).click(function () {

    // var passwordInput = $(this).val();
    // var emailInput = $(this).val();


    console.log(passwordInput)

    console.log(emailInput)

    console.log("BWAMP")

    if (passwordInput.match(/[0-9]/) && passwordInput.length >= 8 && passwordInput.match(/[A-Z]/) && passwordInput.match(/[a-z]/) && passwordInput.length <= 15 && emailInput.match(/[a-z0-9._%+-]+@[s][p][a][r][t][a][g][l][o][b][a][l][.][c][o][m]/)) {

    } else {

    $(".message1").removeClass("hidden");

    };

  });

});

 
