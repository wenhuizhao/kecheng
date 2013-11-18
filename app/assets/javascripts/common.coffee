$(document).ready ->
  
  window.App =
    grade: 'g1'
    cls: 'c1'
  
  $('.course-toggle-title').click ->
    $('.courses').toggle()

  $('.grades').find('.words').each (i, obj) ->
    $(obj).click ->
      $('.grades').find('.hover').removeClass('hover')
      grade_num = $(obj).attr('data-id')
      $('#grade_num').attr('value', grade_num)
      $(@).addClass('hover')

  $('.classes').find('.words').each (i, obj) ->
    $(obj).click ->
      $('.classes').find('.hover').removeClass('hover')
      class_num = $(obj).attr('data-id')
      $('#class_num').attr('value', class_num)
      $(@).addClass('hover')

  redirect_to = (url) ->
    window.location.href = url
    