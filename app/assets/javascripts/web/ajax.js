function execute_request(url, type, data, success_callback, control_flag){

  $.ajax({
     type: type,// GET in place of POST
     contentType: "application/json; charset=utf-8",
     url: url,
     data : JSON.stringify(data),
//     data: data,
    // dataType: "json",
     success: function (result) {
       success_callback(result, control_flag)
     },
     error: function (result){
       window.alert("Error : " + result+"")
     }
});
}

function callback(result){
  window.alert(result );
}


//======= GLOBAL ACTIONS =====
$("document").ready(function() {

  $("#logout_btn").click(function(){
    logout();
  });

  function logout() {
      data = "";
      url = "/logout";
      execute_request(url, "POST", data, success_callback, false)
  }

  function success_callback(result) {
    window.location = "/login"

  }

});
