$(document).ready ->
 
  window.hideNotice = ->
    $('.unotice').hide(1000)
    if $('.unotice').html() is '您的修改已保存成功！' and location.pathname.match(/password/)
      redirect_to '/' 
  setTimeout hideNotice, 2000
  
  $('.unotice').click ->
    $(this).hide()  

  window.App =
    grade: 'g1'
    cls: 'c1'
  
  id_params = $('#homework_sta').attr('data-id')
  gids = '?grades_course_id=' + $('#homework_sta').attr('g-id')
  id_params_with_gid = id_params + gids
  $('#homework_sta').click ->
    redirect_to '/statistics/teacher/' + id_params_with_gid

  $('#message_sta').click ->
    redirect_to '/statistics/teacher/' + id_params + '/messages' + gids

  if $('.messages').find('.actions').find('a').length is 1
    $('.actions').css
      "margin-left": "620px"
    
  $('#content').on 'click', '.ltitle',  ->
    $(this).parent().find('.leave-homework').toggle()
    $(this).parent().find('.lesson-content').toggle()

  $('.areas').on 'click', '.area',  ->
    redirect_to $(this).find('a').attr('href')
  
  $('.small-title').click ->
     redirect_to '/messages/broadcast'

  # $('.check-left').on 'click', '.student',  ->
  #   redirect_to '/homeworks/' + $(this).attr('data-hid') + '/check?status=' + $(this).attr('data-status') + '&student_id=' + $(this).attr('data-id')
  
  $('.user-left').on 'click', '.student',  ->
    redirect_to $(this).attr('data-url')

  # $('.back').on 'click', ->
  #   history.go(-1)

  $('.xld-left').click ->
    redirect_to '/'
  
  $('.jyj-left').click ->
    redirect_to '/'
 
  ['.grades', '.roles', '.courses', '.schools', '.periods'].forEach (el) ->
    $(el).find('.select').click ->
      $(this).parent().find('.opts').toggle()

  $('.grades').find('.opt').each (i, obj) ->
    $(obj).click ->
      click_menu '.grades', '#grade_num', obj
      update_books()
      # $.ajax
      #   url: '/get_classes'
      #   type: 'post'
      #   data:
      #     grade_num: $(obj).attr('data-id')
      #   success: (r) ->
      #     $('.classes').html r

  $('.courses').find('.opt').each (i, obj) ->
    $(obj).click ->
      click_menu '.courses', '#course_id', obj
      update_books()

  $('.roles').find('.opt').each (i, obj) ->
    $(obj).click ->
      click_menu '.roles', '#role_id', obj

  $('.schools').find('.opt').each (i, obj) ->
    $(obj).click ->
      click_menu '.schools', '#school_id', obj
  
  $('#date-select').find('input').click ->
    WdatePicker()
  
  $('#homework_end_time').click ->
    WdatePicker
      dateFmt: 'yyyy年MM月dd日 HH:mm'

  # $('.econtent').find('p').find('span').css
  #   color: '#848484'
  #   'font-family': '"STHeiti" Microsoft YaHei'
  
  $('#exercises').find('p').find('span').css({"font-size": '18px', "font-family": "'STHeiti' Microsoft YaHei"});

  window.click_menu = (cls, id, obj) ->
    $(cls).find('.hover').removeClass('hover')
    course_id = $(obj).attr('data-id')
    $(id).attr('value', course_id)
    $(cls).find('.select').find('.word').html $(obj).find('.word').html()
    $(cls).find('.opts').hide()
    $(obj).addClass('hover')

  window.update_books = ->    
    $.ajax
      url: '/update_books'
      type: 'post'
      data:
        grade_num: $('#grade_num').val()
        course_id: $('#course_id').val()
      success: (r) ->
        $('#books').html(r)

  window.redirect_to = (url) ->
    window.location.href = url
  
  window.toggle_course = (obj) ->
    $(obj).parent().find('.leave-homework').toggle()
    $(obj).parent().find('.lesson-content').toggle()

  window.select_all_records = ( id = 'select_all', sel = 'body' ) ->
    if ($('#' + id).get(0).checked)
      $(sel).find('input[type="checkbox"]').attr('checked', true)
    else
      $(sel).find('input[type="checkbox"]').attr('checked', false)
    return null


