$(document).ready ->
  captcha_counter = if $.cookie('skip_recaptcha', Number) then $.cookie('skip_recaptcha', Number) else 0

  $("form#new_user").submit ->
    captcha_counter++
    $.cookie('skip_recaptcha', captcha_counter, { path: '/users/sign_in' })
