function request_assign_doctor(clinic_id, doctor_uid, assign_flag) {
    data = {"clinic_id":clinic_id, "doctor_uid":doctor_uid, "assign_flag": assign_flag};
    url = "/api/clinics/assign_doctor";
    execute_request(url, "POST", data, callback)
}

function callback(result) {
    table = $("#doctors_table");
    table.empty();
    for (var i = 0; i < result.data.length; i++) {
        doctor = result.data[i];
        table.append(
          "<tr>"+
              "<td>" + doctor.name +"</td>" +
              "<td>" +
                  "<a href='#' title='Details' role='button'>" +
                      "<i class='fa fa-info-circle'></i>" +
                  "</a>" +
                  "<a href='#' data-target='#confirm_modal' data-toggle='modal' title='Delete' role='button'>" +
                      "<i class='fa fa-trash'></i>" +
                  "</a>" +
              "</td>" +
          "</tr>"
        );
    }
}


$("document").ready(function() {
    $("#assign_doctor_btn").click(function() {
      doctor_uid = $('#doctor_uid').val()
      clinic_id = $('#clinics_list').val()
        request_assign_doctor(clinic_id, doctor_uid, true);
    });


    $("#yes_button").click(function() {
        $("#confirm_modal").modal('hide');

    });
});
