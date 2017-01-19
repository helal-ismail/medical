
function request_appointments(clinic_id) {
    date = $('#app_date').val()
    doctor_id = $('#doctors_list').val()
    url = "/api/appointments/by_doctor_and_clinic?doctor_id=" + doctor_id + "&clinic_id=" + clinic_id + "&date=" + date;
    execute_request(url, "GET", "", callback)
}

function callback(result) {
    table = $("#appointments_table");
    table.empty();
    for (var i = 0; i < result.data.length; i++) {
        appointment = result.data[i];
        table.append(
            "<tr>" +
            "<td>" + appointment.patient_name + "</td>" +
            "<td>" + appointment.appointment_date + "</td>" +
            "<td class='action-col'>" +
            "<a href='#' data-target='#confirm_modal' data-toggle='modal' title='Cancel' role='button'>" +
            "<i class='fa fa-calendar-times-o'></i>" +
            "</a>" +
            "<a href='#' data-target='#confirm_modal' data-toggle='modal' title='Missed' role='button'>" +
            "<i class='fa fa-calendar-minus-o'></i>" +
            "</a>" +
            "</td>" +
            "</tr>"
        );
    }
}


$("document").ready(function() {
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
            $(".action-header,action-col").hide();
        }

        // -- get appointments by clinic id --
        request_appointments($(this).data("value"));
    });
});
