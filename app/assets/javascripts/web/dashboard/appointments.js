
function request_appointments(clinic_id, date) {
    doctor_id = $('#doctors_list').val()
    url = "/api/appointments/by_doctor_and_clinic?doctor_id=" + doctor_id + "&clinic_id=" + clinic_id + "&date=" + date;
    execute_request(url, "GET", "", callback, date == today())
}

function callback(result, control_flag) {
    $("#appointments_confirmed").empty();
    $("#appointments_checkedin").empty();
    $("#appointments_canceled").empty();
    $("#appointments_missed").empty();
    $("#appointments_past").empty();

    for (var i = 0; i < result.data.length; i++) {
        appointment = result.data[i];
        append_row(appointment, control_flag)
    }

    if (!control_flag)
    {
      $("#past_li").trigger("click");
    }
    else {
      $("#scheduled_li").trigger("click");
    }
}

function append_row(appointment, control_flag){
  table = $("#appointments_"+appointment.state);
  row =
      "<tr>" +
      "<td>" + appointment.patient_name + "</td>" +
      "<td>" + appointment.appointment_time + "</td>";

  if (control_flag && appointment.state == "confirmed")
  {
    row = row +
          "<td class='action-col'>" +
          "<a href='#' data-target='#confirm_modal' data-toggle='modal' title='Check In' role='button'>" +
          "<i class='fa fa-calendar-check-o'></i>" +
          "</a>" +
          "<a href='#' data-target='#confirm_modal' data-toggle='modal' title='Cancel' role='button'>" +
          "<i class='fa fa-calendar-times-o'></i>" +
          "</a>" +
          "<a href='#' data-target='#confirm_modal' data-toggle='modal' title='Missed' role='button'>" +
          "<i class='fa fa-calendar-minus-o'></i>" +
          "</a>" +
          "</td>";
  }
  row = row + "</tr>";
  table.append(row);
}

function today()
{
  d = new Date();
  month = (d.getMonth()+1)+"";
  if ( month.length == 1 )
    month = "0" + month;
  return d.getFullYear() + "-" + month + "-" + d.getDate();
}

$("document").ready(function() {
    clinic_id = $("#clinic_id").val();

    $("#view_appointments").click(function() {
        // -- remove actions if selected date < today's date --
        var todaysDate = new Date();
        var datePickerVal = $("#app_date").val();
        datePickerVal = datePickerVal.split('-');
        var temp = datePickerVal[1];
        datePickerVal[1] = datePickerVal[2];
        datePickerVal[2] = temp;
        datePickerVal = datePickerVal[2] + "-" + datePickerVal[1] + "-" + datePickerVal[0];
        datePickerVal = new Date(datePickerVal);
        if (datePickerVal.setHours(0, 0, 0, 0) < todaysDate.setHours(0, 0, 0, 0)) {
            $(".action-header,.action-col").hide();
        }

        // -- get appointments by clinic id --
        request_appointments($(this).data("value"), $('#app_date').val());
    });


    request_appointments(clinic_id, today());

});
