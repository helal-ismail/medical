$("document").ready(function() {
    // << ====================== FUNCTION CALLS  ====================== >>
    toggleInputs();



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

    $("#add_clinic_btn").click(function(){
      hospital_id = $("#hospital_id").val();
      clinic_name = $("#clinic_name").val();
      clinic_phone = $("#clinic_phone").val();
      clinic_address = $("#clinic_address").val();
      specialization_id = $("#Spec_list").val();

      request_add_clinic(hospital_id, clinic_name, specialization_id, clinic_address, clinic_phone);
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
        data = {"name": clinic_name, "hospital_id":hospital_id, "specialization_id":specialization_id, "address":clinic_address, "phone":clinic_phone};
        url = "/api/clinics/new";
        execute_request(url, "POST", data, callback, false)
    }

    function callback(result) {
      redirect_url = $("#redirect_url").val();
      window.location = redirect_url
    }


});
