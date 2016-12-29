$(document).on "turbolinks:load", ->
  captcha_counter = if $.cookie('skip_recaptcha', Number) then $.cookie('skip_recaptcha', Number) else 0

  if captcha_counter < 3
    $("#recaptcha").remove()

  $("form#new_user").submit ->
    captcha_counter++
    $.cookie('skip_recaptcha', captcha_counter, { path: '/users/sign_in' })
