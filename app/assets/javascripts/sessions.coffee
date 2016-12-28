captcha_counter = 0

$(document).on "turbolinks:load", ->
  console.log(captcha_counter)
  if captcha_counter < 3
    $("#recaptcha").remove()
    document.cookie = 'skip_recaptcha=true; path=/users/sign_in'
  else
    document.cookie = 'skip_recaptcha=false; path=/users/sign_in'

  $("form#new_user").submit (event) ->
    captcha_counter++
    console.log(captcha_counter)
    event.preventDefault()
