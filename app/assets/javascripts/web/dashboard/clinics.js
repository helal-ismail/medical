$("document").ready(function() {
    // << ====================== FUNCTION CALLS  ====================== >>
    fetch_clinic_specializations();
    toggleInputs();

    clinic_id = $("#clinic_id").val();
    if (clinic_id != 0 && clinic_id != undefined) {
        get_clinic_profile(clinic_id);
    }


    // << ====================== EVENT ACTION  ====================== >>
    $(".schedule-table .checkbox input[type='checkbox']").change(function() {
        var effectedInputs = $(this).parents("tr").children('td.time-cell').children("input");
        if (this.checked) {
            $.each(effectedInputs, function(index, value) {
                $(this).prop('disabled', false);
            });
        } else {
            $.each(effectedInputs, function(index, value) {
                $(this).prop('disabled', true);
            });
        }
    });

    $("#add_clinic_btn").click(function() {
        if ($(".form").valid()) {
            hospital_id = $("#hospital_id").val();
            clinic_name = $("#clinic_name").val();
            clinic_phone = $("#clinic_phone").val();
            clinic_address = $("#clinic_address").val();
            specialization_id = $("#Spec_list").val();

            request_add_clinic(hospital_id, clinic_name, specialization_id, clinic_address, clinic_phone);
        }
    });

    // << ====================== FUNCTION DECLARATION  ====================== >>
    // --- this function is to enable/disable textboxes based on the da status ---
    function toggleInputs() {
        var checkboxes = $(".schedule-table .checkbox input[type='checkbox']");
        var textboxes;
        $.each(checkboxes, function(index, value) {
            textboxes = $(this).parents("tr").children('td.time-cell').children("input");
            if (this.checked) {
                $.each(textboxes, function(index, value) {
                    $(this).prop('disabled', false);
                });
            } else {
                $.each(textboxes, function(index, value) {
                    $(this).prop('disabled', true);
                });
            }
        });
    }

    // << ================== AJAX CALLS ================== >>
    function request_add_clinic(hospital_id, clinic_name, specialization_id, clinic_address, clinic_phone) {
        data = {
            "name": clinic_name,
            "hospital_id": hospital_id,
            "specialization_id": specialization_id,
            "address": clinic_address,
            "phone": clinic_phone,
            "clinic_id": clinic_id
        };
        url = "/api/clinics/new";
        execute_request(url, "POST", data, callback, false)
    }

    function callback(result) {
        redirect_url = $("#redirect_url").val();
        window.location = redirect_url
    }


    function fetch_clinic_specializations() {
        url = "http://localhost:3000/api/clinics/specializations";
        execute_request(url, "GET", "", callback_specializations, false);
    }

    function callback_specializations(result) {
        spec_list = $("#Spec_list");
        spec_list.empty();
        for (var i = 0; i < result.data.length; i++) {
            spec_list.append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
        }
    }


    function get_clinic_profile(clinic_id) {
        url = "/api/clinics/profile?id=" + clinic_id;
        data = "";
        execute_request(url, "GET", data, profile_callback, false)
    }

    function profile_callback(result) {

        $("#clinic_name").val(result.data.name);
        $("#clinic_address").val(result.data.address);
        $("#Spec_list").val(result.data.specialization.id);

    }


});
