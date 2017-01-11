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
    @contactsScreen()
    $('.cart-icon').click () =>
      @toggleCart()
    @activateCart()
    @activateBack()
    @activateNews()

  toggleSidenav: ->
    $('.sidenav').toggleClass('open')

  loginScreen: () ->
    old_top = $('.top').html()
    $('.login_link').on "ajax:success", (e, data) =>
      @updateTop(data)
      $('.close_button').click (e) =>
        @updateTop(old_top)
      $('.overlay > .login_form').on( "ajax:success", (e, data) =>
        @updateTop(data)
      ).on "ajax:error", (e, data) ->
        console.log('Error')
        $('.errors').html(data.responseText)
    $('.sign-out').on "ajax:success", (e, data) =>
      @updateTop(data)

  contactsScreen: =>
    $('.contacts_link').on 'ajax:success', (e,data) =>
      $('.contacts_screen').append(data)
      $('.small_overlay > .close_button').click =>
        $('.small_overlay').remove()

      $('.support_form').on("ajax:complete", (ev,edata) =>
        $('.support_form').remove()
        $('.small_overlay').append(edata.responseText)
      )
  updateCart: (data) =>
    $('.cart_wrapper').remove()
    $('.cart_board').append(data)
    $('.cart-items').html($('.cart_board .cart_items > .item').length)
    $('.cart_board .cart-count').material_select();
    @activateCart()

  toggleCart: () ->
    $('.cart_board').toggleClass('opened')
    $('.main-screen').toggleClass('compressed')
    $('.cart-icon').toggleClass('replaced')

  activateCart: () =>
    $('.cart_close').click () =>
      @toggleCart()
    if $('.cart_items > .item').length > 0
      $('.cart-items').html($('.cart_board .cart_items > .item').length)
    $('.remove').on 'ajax:success', (e,data) =>
      $(e.target).closest('.item').remove()
      @updateCart(data)

    $('.cart-count').change  (e) =>
      id = e.target.attributes['data-item'].value
      value = e.target.value
      $.ajax("/cart/add?id=#{id}&quantity=#{value}").success (data) =>
        @updateCart(data)

  activateNews: () =>
    @offset = 0
    $('.left').click =>
      if @offset < 0
        @offset += 1474
        console.log @offset
        $('.news_slider').animate({left: @offset })
    $('.right').click =>
      @offset -= 1474
      console.log @offset
      $('.news_slider').animate({left: @offset })
    $('.news_link').on 'ajax:success', (e,data) =>
      $('.news_screen').append(data)
      $('.close_button').click =>
        $('.overlay').remove()

  updateTop: (data) ->
    $('.top').html(data)

  activateBack: () =>
    element = $('.close.back')
    if element.length > 0
      $('.burger').hide()
      element.click =>
        history.back()

ready = ->
  window.ui = new Ui()

$(document).on('turbolinks:load', ready)
