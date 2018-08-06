$(function () {
    $("#books-read").find(".icon-button").each(function () {
        $(this).click(function () {
            var iconGroup = $(this).parents().find('.icon-group');
            var book_id = iconGroup.find("#value").text();
            var user_id = $("#user-id").text();
            console.log("User " + user_id + " read " + book_id);
            $.post("/users/" + user_id + "/books/" + book_id);
            $("#no-books-msg").hide();
            $("#books-read-listing").append("<li>" + $(this).parent().find(".icon-text").text() + "</li>");
            $(this).parent().hide();
        });
    });

    $("#attendance-button").click(function () {
        var $studentTable = $("#student-table");
        var selections = $studentTable.bootstrapTable('getSelections');
        for (var i in selections) {
            var id = selections[i]['id'];
            console.log(id);
            $.post('/attendance/' + id)
        }
        location.reload();
    });
});