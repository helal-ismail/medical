
function generate_report() {

    date_start = $('#start_date').val();
    date_end = $('#end_date').val();
    ids = $('#ids_list').val();

    data = {"ids":ids, "date_start": date_start, "date_end":date_end};
    url = $("#hidden").val();
    execute_request(url, "POST", data, callback, false)
}

function callback(result, control_flag) {
  csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(result);
  var a = $("<a />", {
     href: csvData,
     "download":"reports.csv"
  });
  $("body").append(a);
  a[0].click();
}


$("document").ready(function() {
  $("#generate_report").click(function() {
    generate_report();
  });

});
