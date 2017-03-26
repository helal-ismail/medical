$("document").ready(function() {
    // << ====================== FUNCTION CALLS  ====================== >>
    hospital_id = $("#hospital_id").val();
    if (hospital_id != 0 && hospital_id != undefined) {
        get_hospital_profile(hospital_id);
        $("#header_label").html("Edit Hospital")

    }



    // << ====================== EVENT ACTION  ====================== >>

    $("#add_hospital_btn").click(function() {
        if ($(".form").valid()) {
            name = $("#name").val();
            phone = $("#phone").val();
            address = $("#address").val();
            email = $("#email").val();
            website = $("#website").val();
            request_add_hospital(name, email, phone, website, address);
        }
    });

    // << ====================== FUNCTION DECLARATION  ====================== >>

    // << ================== AJAX CALLS ================== >>
    function request_add_hospital(name, email, phone, website, address) {
        data = {
            "name": name,
            "email": email,
            "phone": phone,
            "website": website,
            "address": address,
            "hospital_id": hospital_id
        };
        url = "/api/hospitals/new";
        execute_request(url, "POST", data, callback, false)
    }

    function callback(result) {
        redirect_url = $("#redirect_url").val();
        window.location = redirect_url
    }


    function get_hospital_profile(hospital_id) {
        url = "/api/hospitals/profile?id=" + hospital_id;
        data = "";
        execute_request(url, "GET", data, profile_callback, false)
    }

    function profile_callback(result) {
        $("#name").val(result.data.name);
        $("#email").val(result.data.email);
        $("#phone").val(result.data.phone);
        $("#website").val(result.data.website);
        $("#address").val(result.data.address);
    }




});
