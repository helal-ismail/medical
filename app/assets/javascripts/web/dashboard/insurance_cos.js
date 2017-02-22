$("document").ready(function() {
    // << ====================== FUNCTION CALLS  ====================== >>

    insurance_co_id = $("#insurance_co_id").val();
    if (insurance_co_id != 0 && insurance_co_id != undefined){
      get_insurance_co_profile(insurance_co_id);
    }


    // << ====================== EVENT ACTION  ====================== >>

    $("#add_company_btn").click(function(){
      name = $("#name").val();
      website = $("#website").val();
      address = $("#address").val();
      request_add_company(name, website, address);
    });

    // << ====================== FUNCTION DECLARATION  ====================== >>

    // << ================== AJAX CALLS ================== >>
    function request_add_company(name, website, address) {
        data = {"name": name, "website":website, "address":address,"insurance_co_id":insurance_co_id};
        url = "/api/insurance_cos/new";
        execute_request(url, "POST", data, callback, false)
    }

    function callback(result) {
//      redirect_url = $("#redirect_url").val();
      window.location = "/insurance_cos"
    }

    function get_insurance_co_profile(insurance_co_id){
      url = "/api/insurance_cos/profile?id="+insurance_co_id;
      data = "";
      execute_request(url, "GET", data, profile_callback, false)
    }

    function profile_callback(result){

      $("#name").val(result.data.name);
      $("#address").val(result.data.address);
      $("#website").val(result.data.website);

    }


});
