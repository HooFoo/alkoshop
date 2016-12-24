# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Ui

  constructor: ->
    $('.burger, .nav-item').click( =>
      @toggleSidenav()
    )
    @loginScreen()

  toggleSidenav: ->
    $('.sidenav').toggleClass('open')

  loginScreen: () ->
    old_top = $('.top').html()
    $('.login_link').on "ajax:success", (e, data) =>
      @updateTop(data)
      $('.close_button').click (e) =>
        @updateTop(old_top)
      $('.overlay > form').on( "ajax:success", (e, data) =>
        @updateTop(data)
      ).on "ajax:error", (e, data) ->
        console.log('Error')
        $('.errors').html(data.responseText)
    $('.sign-out').on "ajax:success", (e, data) =>
      @updateTop(data)



  updateTop: (data) ->
    $('.top').html(data)

ready = ->
  window.ui = new Ui()

$(document).on('turbolinks:load', ready)
