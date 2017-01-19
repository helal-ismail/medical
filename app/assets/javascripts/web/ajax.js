function execute_request(url, type, data, success_callback){



  $.ajax({
     type: type,// GET in place of POST
     contentType: "application/json; charset=utf-8",
     url: url,
     data : JSON.stringify(data),
//     data: data,
     dataType: "json",
     success: function (result) {
       success_callback(result)
     },
     error: function (result){
       window.alert("Error : " + result)
     }
});
}

function callback(result){
  window.alert(result );
}
