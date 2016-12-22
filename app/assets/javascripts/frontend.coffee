# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Ui

  constructor: ->
    $('.burger, .nav-item').click( =>
      @toggleSidenav()
    )
    @showLink()

  toggleSidenav: ->
    $('.sidenav').toggleClass('open')

  showLink: () ->
    $('.login_link').on "ajax:success", (e, data) ->
      $('.top').html(data)
      $('.top > form').on( "ajax:sucess", (e, data) ->
        $('.top').html(data))
      .on "ajax:error", (e, data) ->
        $('.errors').html('Регистрационные данные не верны')


ready = ->
  window.ui = new Ui()

$(document).on('turbolinks:load', ready)
