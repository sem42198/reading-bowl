$(function() {
    $("#question-card").flip({
        axis: 'y',
        trigger: 'click'
    });

    $("#star").bind("click", function () {
        var question_id = $("#question-id").text();
        $.post("/questions/" + question_id + "/star_toggle");
    });

    $("#blank-star").bind("click", function () {
        $("#blank-star").hide();
        $("#yellow-star").show();
    });

    $("#yellow-star").bind("click", function () {
        $("#yellow-star").hide();
        $("#blank-star").show();
    });

    $("#answered_by").find(".icon-button").each(function () {
       $(this).click(function () {
           var iconGroup = $(this).parents().find('.icon-group');
           var user_id = iconGroup.find("#value").text();
           var question_id = $("#question-id").text();
           console.log("User " + user_id + " answered question " + question_id);
           $.post("/users/" + user_id + "/answers/" + question_id);
       });
    });

});