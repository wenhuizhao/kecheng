$(document).ready ->
  
  window.bgNum = 0
  changeBg = ->
    if bgNum < 2
      bgNum += 1
    else
      window.bgNum = 0
    $('#middle')
      .css('background','url(\'/assets/login-bg' + bgNum + '.jpg\')')
      .css('background-size', '110% 100%')
  setInterval changeBg, 3000
  
  $.ajax
    url: "/send_code"
    type: "post"
    data:
      mobile: ''
    success: (r) ->
      alert r
