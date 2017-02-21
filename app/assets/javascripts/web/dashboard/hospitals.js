$("document").ready(function() {
    // << ====================== FUNCTION CALLS  ====================== >>




    // << ====================== EVENT ACTION  ====================== >>

    $("#add_hospital_btn").click(function(){
      name = $("#name").val();
      phone = $("#phone").val();
      address = $("#address").val();
      email = $("#email").val();
      website = $("#website").val();
      request_add_hospital(name, email, phone, website, address);
    });

    // << ====================== FUNCTION DECLARATION  ====================== >>

    // << ================== AJAX CALLS ================== >>
    function request_add_hospital(name, email, phone, website, address) {
        data = {"name": name, "email":email, "phone":phone,"website":website, "address":address};
        url = "/api/hospitals/new";
        execute_request(url, "POST", data, callback, false)
    }

    function callback(result) {
      redirect_url = $("#redirect_url").val();
      window.location = redirect_url
    }




});
