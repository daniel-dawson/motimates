# document.addEventListener 'DOMContentLoaded', ->
#   notes = document.querySelectorAll('.connection.text')
#   for note in notes
#     note.addEventListener 'click', ->
#       console.log(this.classList)
#       this.classList.add('js-whitespace')

document.addEventListener 'turbolinks:load', ->
  notes = document.querySelectorAll('.connection.text')
  for note in notes
    note.addEventListener 'click', ->
      this.classList.toggle('js-whitespace')
