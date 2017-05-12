var setVisible = function(visible) {
    $("#article_visible").val(visible);
};

var showDesc = function(el) {
    var s = $(el).attr("s");
    if (s === "show") {
        $(el).attr("s", "hide").text("展开").
        parents(".desc").removeClass("full").addClass("simple");
    } else {
        $(el).attr("s", "show").text("隐藏").
        parents(".desc").removeClass("simple").addClass("full");
    }
};