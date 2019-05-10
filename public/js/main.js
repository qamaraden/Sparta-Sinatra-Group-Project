

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
    console.log ("Hello")
    error_message();


  });

});
