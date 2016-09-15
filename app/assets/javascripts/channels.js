
$(function(){
    var params = {
        containerSelector: ".masonry-container",
        columnWidth: '.masonry-container>.content',
        itemSelector: '.masonry-container>.content',
        loadingSelector: '.loading'
    }
    $(params.containerSelector).masonry({
        columnWidth: params.columnWidth,
        itemSelector: params.itemSelector
    });
    var stop=true;
    $(params.loadingSelector).attr("start", $(".masonry-container>.content").length + 1)
    $(window).scroll(function(){
        var totalheight = parseFloat($(window).height()) + parseFloat($(window).scrollTop());
        if($(document).height() <= totalheight){
            $(params.loadingSelector).show();
            if(stop==true){
                stop=false;
                var start = $(params.loadingSelector).attr("start")
                $.get(location.url, {start:start},function(txt){
                    var boxes = $(txt);
                    $(params.containerSelector).append(boxes).masonry('appended', boxes);
                    stop=true;
                    $(params.loadingSelector).attr("start", parseInt(start) + boxes.filter(".content").length).hide();
                },"text");
            }
        }
    });
})