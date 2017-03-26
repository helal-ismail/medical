$("document").ready(function() {
    // << ====================== FUNCTION CALLS  ====================== >>
    admin_id = $("#admin_id").val();
    edit = false;
    if (admin_id != 0 && admin_id != undefined){
      get_user_profile(admin_id);
      edit = true;
      $("#header_label").html("Edit User")
    }


    // << ====================== EVENT ACTION  ====================== >>

    $("#add_user_btn").click(function(){
      email = $("#email").val();
      name = $("#name").val();
      password = $("#password").val();
      phone = $("#phone").val();
      hospital_id = $("#hospital_list").val();
      type = $("#role_list").val();

      request_add_user(name, email, password, phone, type, hospital_id);
    });

    // << ================== AJAX CALLS ================== >>
    function request_add_user(name, email, password, phone, type, hospital_id){
        data = {"user":{"name":name, "email":email, "password":password, "phone":phone, "type":type, "hospital_id":hospital_id}}
        url = "/api/users/register";
        if ( edit == true ){
          data = {"user_id":admin_id,"name":name, "email":email, "password":password, "phone":phone, "type":type, "hospital_id":hospital_id}
          url = "/api/users/edit";
        }

        execute_request(url, "POST", data, callback, false)
    }

    function callback(result) {
      window.location = "/users"
    }


    function get_user_profile(user_id){
      url = "/api/users/profile?id="+user_id;
      data = "";
      execute_request(url, "GET", data, profile_callback, false)
    }

    function profile_callback(result){

      $("#name").val(result.data.name);
      $("#email").val(result.data.email);
      $("#email").prop('disabled', true);
      $("#password").prop('disabled', true);
      $("#phone").val(result.data.phone);
      $("#role_list").val(result.data.type);
      $("#hospital_list").val(result.data.hospital_id);

    }


});
