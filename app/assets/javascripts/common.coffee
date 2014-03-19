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

  $('.area-hover').click  ->
    redirect_to $(this).attr('data-href')
  
  $('.small-title').click ->
     redirect_to '/messages/broadcast'

  # $('.check-left').on 'click', '.student',  ->
  #   redirect_to '/homeworks/' + $(this).attr('data-hid') + '/check?status=' + $(this).attr('data-status') + '&student_id=' + $(this).attr('data-id')
  
  $('.user-left').on 'click', '.student',  ->
    redirect_to $(this).attr('data-url')

  # $('.back').on 'click', ->
  #   history.go(-1)

  $('.data-url').click -> redirect_to $(this).attr('data-url')
  
  $('.ans-input').removeAttr('disabled')
  
  $('.xld-left').click ->
    redirect_to '/'
  
  $('.lback').click ->
    history.go(-1)
 
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

  $('#exercises').find('p').find('span').css({"font-size": '18px', "font-family": "'STHeiti' Microsoft YaHei"});
  $('#exercises').find('p').css({"font-size": '18px', "font-family": "'STHeiti' Microsoft YaHei"});
  # $('.radio').click -> $(this).find('input').attr('checked','checked')
   
  scrollTo(0,0)

  # window.close_homework = (obj, gid) ->
  #   id = $(obj).attr("data-id")
  #   sid = $(obj).attr("data-sid")
  #   uds = $(obj).attr("data-uds")
  #   uns = $(obj).attr("data-uns")
  #   s = '您确定将本作业关闭吗？关闭后'
  #   s1 = '学生将不能提交作业.'
  #   s2 = '您将不能批阅作业.'
  #   m1 = uns == '0' ? s + s1 : "还有" + uns + "个学生未提交作业，" + s + s1
  #   m2 = uds == '0' ? s + s2 : "还有" + uds + "个学生的提交的作业等待您批阅，" + s + s2
  #   m = uds == '0' ? m1 : m2
  #   if confirm(m)
  #     redirect_to '/sections/' + sid + '/homeworks/' + id + '/close?grades_course_id=' + gid
  #   else 
  #     false

  $('.areas').find('.area').hover ->
    o = $(this).offset()
    top = o.top
    left = o.left
    $('.area-hover').show()
    $('.area-hover').attr('data-href', $(this).find('a').attr('href'))
    $('.area-hover').css
      top: top
      left: left
  
  $('#register-form').find('input').blur -> 
    o = $(this)
    hid = o.attr('id')
    $.ajax
      url: '/check_user'
      type: 'post'
      data:
        hid: hid
        val: $(this).val()
      success: (res) =>
        console.info res
        r = res.split("/")[0]
        # console.info res.split("/")[0]
        tip = o.parent().find(".tip")
        tip = o.parent().find(".atip") if tip.length == 0
        tip.attr("class", "tip " + r) if $(o).attr('id') != 'auth_code'
        if r is 'error'
          o.css
            border: "2px solid red"
          tip.find(".mess").html(res.split("/")[1])
        else
          o.css
            border: 'none'
          tip.find(".mess").html('')
        if hid is 'user_password'
          $("#user_password_confirmation").val('')
          $("#user_password_confirmation").parent().find(".tip").attr("class", "tip")

        # $(this).parent().find(".atip").attr("class", "atip " + r)

  window.check_user = ->
    errs = []
    # blanks = []
    b = true
    $('.mess').each (i,o) -> 
      errs.push $(o).html() if $(o).html().length != 0
      # blanks.push $(o).html() if $(o).html() == 'tip'
    err_length = errs.length
    console.info err_length
    # if blanks.length != 0
    #   m = '信息填写不完整！'
    #   b = false
    # else 
    # else 
    if $('#user_login').val() == ''
      m = '用户名不能为空！'
      b = false
    else if $('#user_password').val() == ''
      m = '密码不能为空！'
      b = false
    else if $('#user_password_confirmation').val() == ''
      m = '密码验证不能为空'
      b = false
    else if $('#user_real_name').val() == ''
      m = '真实姓名不能为空！'
      b = false
    else if $('#user_phone').val() == ''
      m = '手机号码不能为空！'
      b = false
    else if $('#auth_code').val() == ''
      m = '验证码不能为空！'
      b = false
    else if $('input:radio[name="user[gender]"]:checked').val() == undefined 
      m = '请选择性别'
      b = false 
    else if $('#role_id').val() == ''
      m = '请选择角色'
      b = false
    else if $('#school_id').val() == ''
      m = '请选择学校'
      b = false
    else if errs.length != 0
      m = errs[0]
      b = false
    else
      m = ''
      b = true
    
    tip_dialog = $('.tip-mess')
    if b == false
      tip_dialog.css 'visibility', 'visible'
      tip_dialog.html(m)
    else
      tip_dialog.css 'visibility', 'hidden'
      tip_dialog.html('')
      
    return b 
  
  $('.send-code').click ->
    if $(this).html().match(/验证/) || $(this).html().match(/重新/)
      if $('#user_phone').val().match /1[358]+\d[\d]{8}/
        $(this).html('发送中...').css
          "font-size": '16px'
        $.ajax
          url: "/send_code"
          type: "post"
          data:
            mobile: $("#user_phone").val()
          success: (r) =>
            $(this).html '发送成功，120秒后重发'
            setInterval changeCodeTime, 1000
            alert(r)
      else
        alert '请输入正确手机号码!'
    else
      ''
  
  window.changeCodeTime = ->
    o = $('.send-code')
    n = o.html().match(/[\d]+/).toString()
    if n == '1'
      o.html('重新发送').css
          "font-size": '26px'
    else
      o.html '发送成功，' + (Number(n) - 1) + '秒后重发'

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


