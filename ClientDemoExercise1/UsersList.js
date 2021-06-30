function callUsersList() {
    $.ajax({
        type: "get",
        url: "https://5dc588200bbd050014fb8ae1.mockapi.io/assessment",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {        
            var source = $("#first-template").html();
            for (i = 0; i < result.length; i++) {            
                var template = Handlebars.compile(source);
                var context = {
                    nameVal: result[i].name,
                    avatarVal: result[i].avatar,
                    createdVal: result[i].createdAt,
                    idVal: result[i].id
                };
                var el_html = el_html + template(context);
                $("#divContainer").html(el_html);
            }

        }
    });

}
