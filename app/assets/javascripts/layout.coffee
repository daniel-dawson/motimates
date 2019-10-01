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
  setTimeout (->
    $('#flash').addClass('hidden')
    ), 3000


$(document).on 'turbolinks:load', ->
  path = window.location.pathname
  $('nav a.item[href="' + path + '"]').addClass 'active'

# $(window).on 'load', ->
#   path = window.location.pathname
#   $('nav a.item[href="' + path + '"]').addClass 'active'
#   return
