$('#exercises').find('br').remove()
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


$('#exercises').find('.check-icon').each (i, obj) ->
  $(obj).on 'click', ->
    desc = $(this).attr('data-desc')
    id = $(this).attr('data-id')
    if desc is 'edit'
      $('.' + id + 'area').removeAttr('disabled')
      alert '进入编辑状态'
    else
      $.ajax
        url: '/check_exercise'
        type: 'post'
        data:
          id: $(this).attr('data-hid') 
          exercise_id: id
          check_desc: desc
        success: (r) ->
          console.log(r)
          if desc is 'wrong' || desc is 'right'
            $("#" + id + "title").html('<img class="check-icon-answer" src="/assets/' + desc + '.png">')
          else if desc is 'niubi'
            $("#" + id + "title").append('<img class="check-icon-answer" src="/assets/' + desc + '.png">')

