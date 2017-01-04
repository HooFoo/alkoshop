# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Ui

  constructor: ->
    $('.sidenav').hover( =>
        $('.burger').hide()
      ,
      =>
        $('.burger').show(300)

    )
    @loginScreen()
    $('.cart-icon').click () =>
      @toggleCart()
    @activateCart()

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

  updateCart: (data) =>
    $('.cart_wrapper').remove()
    $('.cart_board').append(data)
    $('.cart-items').html($('.cart_items > .item').length)
    $('.cart-count').material_select();
    @activateCart()

  toggleCart: () ->
    $('.cart_board').toggleClass('opened')
    $('.main-screen').toggleClass('compressed')
    $('.cart-icon').toggleClass('replaced')

  activateCart: () =>
    $('.cart_close').click () =>
      @toggleCart()
    if $('.cart_items > .item').length > 0
      $('.cart-items').html($('.cart_items > .item').length)
    $('.remove').on 'ajax:success', (e,data) =>
      @updateCart(data)

  updateTop: (data) ->
    $('.top').html(data)

ready = ->
  window.ui = new Ui()

$(document).on('turbolinks:load', ready)
