# $('#exercises').find('br').remove()
$('#exercises').find('.canvas-container').each (i, obj) ->
  width = 830
  height = $(obj).parent().height() - 150
  $(obj).css
    width: width
    height: height
    position: "absolute"
  $(obj).find('canvas').css
    width: width
    height: height
  .attr
    width: width
    height: height


