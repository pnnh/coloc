var setVisible = function(visible) {
    $("#article_visible").val(visible).closest('form').submit();
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

$(function () {
   $("form .input-select-group").each(function () {
       var toggleLabel = $(this).find(".dropdown-toggle .title");
       var dropVal = $(this).find(".dropdown-value");
      $(this).find("a[data-value]").each(function () {
        $(this).click(function () {
            dropVal.val($(this).data("value"));
            toggleLabel.text($(this).text());
        });
      });
   });

    $('body').scrollspy({ offset: 60, target:'#fixed-spy'});
    $('#fixed-spy').on('activate.bs.scrollspy', function (e) {
        if(e.target.firstChild.hash === '#fixed') {
            $('#fixed').addClass('fixed');
        } else {
            $('#fixed').removeClass('fixed');
        }
    });
});