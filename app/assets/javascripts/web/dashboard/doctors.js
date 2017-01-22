$("document").ready(function() {

function request_assign_doctor(e_type, e_id, doctor_uid, assign_flag) {
    data = {"entity_type":e_type, "entity_id":e_id, "doctor_uid":doctor_uid, "assign_flag": assign_flag};
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
                  "<a href='#' data-value='" + doctor.id + "' data-target='#confirm_modal' data-toggle='modal' title='Delete' role='button'>" +
                      "<i class='fa fa-trash'></i>" +
                  "</a>" +
              "</td>" +
          "</tr>"
        );
    }
}




var doctor_uid, entity_type, entity_id;

$("#assign_doctor_btn").click(function() {
      d_uid = $('#doctor_uid').val()
      clinic_id = $('#clinics_list').val()
      request_assign_doctor("clinic", clinic_id, d_uid, true);
    });


$("#yes_button").click(function() {
  $("#confirm_modal").modal('hide');
  if (doctor_uid){
    request_assign_doctor(entity_type, entity_id, doctor_uid, true);
  }

});

$(".delete-btn").click(function(){
  doctor_uid = $(this).getAttribute("data-value");
  entity_type = $(this).getAttribute("data-value2");
  entity_id = $(this).getAttribute("data-value3");

});

});
