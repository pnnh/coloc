$(function () {
   $("textarea.auto-height").each(function () {
       var render = function(){
           this.style.height='0px';this.style.height=this.scrollHeight + 'px';
       };
       this.onpropertychange = render;
       this.oninput = render;
       render.apply(this);
   });
});