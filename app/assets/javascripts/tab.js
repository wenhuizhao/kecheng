jQuery.jqtab = function(tabtit,tab_conbox,shijian) {
  $(tab_conbox).find("li").hide();
  $(tabtit).find("li:first").addClass("thistab").show(); 
  $(tab_conbox).find("li:first").show();
  
  $(tabtit).find("li").bind(shijian,function(){
    $(this).addClass("thistab").siblings("li").removeClass("thistab"); 
    var activeindex = $(tabtit).find("li").index(this);
    $(tab_conbox).children().eq(activeindex).show().siblings().hide();
    return false;
  });

};
