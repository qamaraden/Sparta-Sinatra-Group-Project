$(function (){

  $('.dropdown-toggle').dropdown()

  function error_message() {
    // console.log("Hello")
    $('.error_test').html("error");

  }

  $('.delete_button').on("click", function(){
    $("form").click(function(event){
      event.preventDefault();
    });
    error_message();
  });

  $('input[id=emailValidate]').keyup(function() {

    var emailInput = $(this).val();
    emailInput.match(/[a-z0-9._%+-]+@spartaglobal.com$/i);
  });

  $('input[type=password]').keyup(function() {

    var passwordInput = $(this).val();
    passwordInput.match(/[a-z]{1,}/)
    passwordInput.match(/[A-Z]{1,}/)
    passwordInput.match(/[0-9]{1,}/)
    passwordInput.length >= 8
    passwordInput.length <= 15
  });

  $(".userSave").click(function () {
   $(".message").css("visibility", "visible")
  });
});

 
