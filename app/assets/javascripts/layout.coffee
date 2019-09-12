# let flashMessage = document.querySelector("#flash");
#
# if (flashMessage) {
#   flashMessage.addEventListener("click", () => {
#     flashMessage.classList.add("hidden");
#   });
# }
$ ->
  $('#flash').on 'click', ->
    $('#flash').addClass('hidden')


$(document).on 'turbolinks:load', ->
  path = window.location.pathname
  $('nav a.item[href="' + path + '"]').addClass 'active'

# $(window).on 'load', ->
#   path = window.location.pathname
#   $('nav a.item[href="' + path + '"]').addClass 'active'
#   return
