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
});
