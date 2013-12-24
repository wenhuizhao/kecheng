$(document).ready ->
  
  # setTimeout $('#notice').hide(1000)

  window.App =
    grade: 'g1'
    cls: 'c1'
  
  if $('.actions').find('a').length is 1
    $('.actions').css
      "margin-left": "620px"
    
  $('#content').on 'click', '.ltitle',  ->
    $(this).parent().find('.leave-homework').toggle()
    $(this).parent().find('.lesson-content').toggle()

  $('.areas').on 'click', '.area',  ->
    redirect_to $(this).find('a').attr('href')

  $('.back').on 'click', ->
    history.go(-1)

  $('.xld-left').click ->
    redirect_to '/'
  
  $('.jyj-left').click ->
    redirect_to '/'

  $('.grades').find('.words').each (i, obj) ->
    $(obj).click ->
      $('.grades').find('.hover').removeClass('hover')
      grade_num = $(obj).attr('data-id')
      $('#grade_num').attr('value', grade_num)
      $(@).addClass('hover')
      $.ajax
        url: '/get_classes'
        type: 'post'
        data:
          grade_num: grade_num
        success: (r) ->
          $('.classes').html r

  $('.courses').find('.words').each (i, obj) ->
    $(obj).click ->
      $('.courses').find('.hover').removeClass('hover')
      course_id = $(obj).attr('data-id')
      $('#course_id').attr('value', course_id)
      $(@).addClass('hover')

  # bind_click = (o, e, e2) ->
  #     $(e).find('.hover').removeClass('hover')
  #     num = $(o).attr('data-id')
  #     $(e2).attr('value', num)
  #     $(e).addClass('hover')
  window.redirect_to = (url) ->
    window.location.href = url
  
  window.toggle_course = (obj) ->
    $(obj).parent().find('.leave-homework').toggle()
    $(obj).parent().find('.lesson-content').toggle()

  window.select_all_records = ->
    if ($('#select_all').get(0).checked)
      $('input[type="checkbox"]').attr('checked', true)
    else
      $('input[type="checkbox"]').attr('checked', false)
    return null
