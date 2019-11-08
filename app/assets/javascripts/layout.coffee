# I think this is redundant with turbolinks?
# $ ->
#   # remove flash message after user clicks it
#   $('.flash').on 'click', ->
#     $('.flash').addClass('hidden')
#
#   # remove flash message after small delay
#   setTimeout (->
#     $('.flash').addClass('hidden')
#     ), 3000
#
#   modalLink = $('.modal-link')
#
#   modalLink.on 'click', ->
#     event.preventDefault()
#     $('.ui.modal').modal('show')

# does everything above, but when page loads from turbolink
$(document).on 'turbolinks:load', ->
  
  #dynamically set active link in nav bar
  path = window.location.pathname
  $('nav a.item[href="' + path + '"]').addClass 'active'

  # remove flash message after user clicks it
  $('.flash').on 'click', ->
    $('.flash').addClass('hidden')

  # remove flash message after small delay
  setTimeout (->
    $('.flash').addClass('hidden')
    ), 3000

  modalLink = $('.modal-link')

  modalLink.on 'click', ->
    event.preventDefault()
    $('.ui.modal').modal('show')

  Connection.setAddButtons();
