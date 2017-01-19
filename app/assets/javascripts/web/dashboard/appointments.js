res = "";

function request_appointments(clinic_id){
  date = $('#app_date').val()
  doctor_id = $('#doctors_list').val()
  url = "/api/appointments/by_doctor_and_clinic?doctor_id="+doctor_id+"&clinic_id="+clinic_id+"&date="+date;
  execute_request(url,"GET","",callback)
}

function callback(result){
  res = result;
  table = $("#appointments_table");
  table.empty();
  for (var i = 0 ; i < result.data.length ; i ++)
  {
    appointment = result.data[i];
    table.append(
      "<tr>"+
        "<td>" + appointment.patient_name + "</td>"+
        "<td>" + appointment.appointment_date + "</td>"+
        "<td class='action-col'>"+
            "<a href='#' data-target='#confirm_modal' data-toggle='modal' title='Cancel' role='button'>"+
                "<i class='fa fa-calendar-times-o'></i>"+
            "</a>"+
            "<a href='#' data-target='#confirm_modal' data-toggle='modal' title='Missed' role='button'>"+
                "<i class='fa fa-calendar-minus-o'></i>"+
            "</a>"+
        "</td>"+
    "</tr>"
  );
  }
}
