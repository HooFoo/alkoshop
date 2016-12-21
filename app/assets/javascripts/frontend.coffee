# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Ui

  constructor: ->
    console.log 'ctor'
    $('.burger, .nav-item').click( =>
      @toggleSidenav()
    )

  toggleSidenav: ->
    console.log 'toggle'
    $('.sidenav').toggleClass('open')


ready = ->
  console.log 'polomkah'
  window.ui = new Ui()

$(document).on('turbolinks:load', ready)
