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
    @alton()
    @confirmation()
    @hideNav()

  toggleSidenav: ->
    $('.sidenav').toggleClass('open')

  loginScreen: () ->
    old_top = $('.top').html()
    $('.login_link').on "ajax:success", (e, data) =>
      $('.main-screen').append(data)
      $('.close_button').click (e) =>
        $('.overlay').remove()
      $('.tab_item').click (e) ->
        if $(e.target).hasClass('registration_tab')
          $('.reg').addClass('form_active')
          $('.log').removeClass('form_active')
          $('.registration_tab').addClass('tab_active')
          $('.login_tab').removeClass('tab_active')
        else
          $('.log').addClass('form_active')
          $('.reg').removeClass('form_active')

          $('.login_tab').addClass('tab_active')
          $('.registration_tab').removeClass('tab_active')
      $('.overlay > .login_form').on( "ajax:success", (e, data) =>
        $('.overlay').remove()
        @updateTop(data)
      ).on "ajax:error", (e, data) ->
        $('.errors').html(data.responseText)
    $('.sign-out').on "ajax:success", (e, data) =>
      @updateTop(data)

  contactsScreen: =>
    $('.contacts_link').on 'ajax:success', (e,data) =>
      $('.main-screen').append(data)
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
    $('.navigation > .left').click =>
      if @offset < 0
        @offset += newsWidth()
        $('.news_slider').animate({left: @offset })
      if @offset >= 0
        $('.navigation > .left').css('display': 'none')
    $('.navigation > .right').click =>
      @offset -= newsWidth()
      $('.news_slider').animate({left: @offset })
      if @offset <= (-1 * newsWidth())
        $('.navigation > .left').css('display': 'block')

    $('.news_link').on 'ajax:success', (e,data) =>
      $('.main-screen').append(data)
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

  hideNav: () =>
    if window.innerWidth <= 760
      $('.sidenav').click () ->
        $('.sidenav').removeClass('hover')
#  smoothScroll: =>
#    $ ->
#      $('a[href*="#"]:not([href="#"])').click ->
#        if location.pathname.replace(/^\//, '') == @pathname.replace(/^\//, '') and location.hostname == @hostname
#          target = $(@hash)
#          target = if target.length then target else $('[name=' + @hash.slice(1) + ']')
#          if target.length
#            $('html, body').animate { scrollTop: target.offset().top }, 1000
#            return false
#        return
#      return

  alton: =>
    if $('.screen').length > 0
      $('.screens').fullpage(
        sectionSelector: '.screen'
        slideSelector: '.slide'
        menu: '.sidenav'
        anchors: ['one','two','three', 'four', 'five']
        normalScrollElements: '.overlay'
        onLeave: (index, nextIndex, direction) =>
          $(".nav_items > .nav_quad:eq(#{index-1})").removeClass('active')
          $(".nav_items > .nav_quad:eq(#{nextIndex-1})").addClass('active')
      )
    else
      $('.nav_items').remove()

  newsWidth = () =>
    scrollWidth = 1474
    if window.innerWidth <=1366
      scrollWidth = 994
    if window.innerWidth <=1024
      scrollWidth = 780
    if window.innerWidth <=760
      scrollWidth = window.innerWidth * 0.80
    return scrollWidth

  confirmation: =>
    if localStorage.getItem('confirmed') == null
      $('.confirmation').css({'display':'block'})
    $('.confirmation_close').click =>
      history.back()
    $('.confirmation_button').click =>
      localStorage.setItem('confirmed','true')
      $('.confirmation').remove()

ready = ->
  window.ui = new Ui()

$(document).on('turbolinks:load', ready)
