# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Ui

  constructor: ->
    $('.sidenav').hover( =>
        $('.burger').hide()
        $('.cart-icon').hide()
      ,
      =>
        $('.burger').show(300)
        $('.cart-icon').show(300)
    )
    @loginScreen()
    @contactsScreen()
    $('.cart-icon').click () =>
      @toggleCart()
    @activateCart()
    @activateBack()
    @activateNews()
    @smoothScroll()
    @alton()

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
        $('.overlay').remove()

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
        @offset += newsWidth()
        console.log @offset
        $('.news_slider').animate({left: @offset })
    $('.right').click =>
      @offset -= newsWidth()
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

  smoothScroll: =>
    $ ->
      $('a[href*="#"]:not([href="#"])').click ->
        if location.pathname.replace(/^\//, '') == @pathname.replace(/^\//, '') and location.hostname == @hostname
          target = $(@hash)
          target = if target.length then target else $('[name=' + @hash.slice(1) + ']')
          if target.length
            $('html, body').animate { scrollTop: target.offset().top }, 1000
            return false
        return
      return

  alton: =>
    if $('.screen').length > 0
      console.log('Alton')
      $(document).alton
        fullSlideContainer: 'screens'
        singleSlideClass: 'screen'
        useSlideNumbers: true
        slideNumbersBorderColor: '#fff'
        slideNumbersColor: 'transparent'
        bodyContainer: 'main-screen'

  newsWidth = () =>
    scrollWidth = 1474
    if window.innerWidth <=1366
      scrollWidth = 994
    if window.innerWidth <=1024
      scrollWidth = 780
    return scrollWidth

ready = ->
  window.ui = new Ui()

$(document).on('turbolinks:load', ready)
