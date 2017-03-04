# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Ui

  constructor: ->
    @activateSidenav()
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
    @enableTabs()
    @activatePromo()
    @enableSubmits()
    @calculateNewsWidth()
    @activateSpecial()

  toggleSidenav: ->
    $('.sidenav').toggleClass('open')

  loginScreen: () ->
    old_top = $('.top').html()
    $('.login_link').on "ajax:success", (e, data) =>
      $('.main-screen').append(data)
      $('#user_country').material_select();
      $('.close_button').click (e) =>
        $('.overlay').trigger('mouseleave')
        $('.overlay').remove()
      @enableTabs()
      @enableSubmits()
      @checkEmail()
    $('.sign-out').on "ajax:success", (e, data) =>
      @updateTop(data)

  contactsScreen: =>
    $('.contacts_link').on 'ajax:success', (e,data) =>
      $('.main-screen').append(data)
      $('.small_overlay > .close_button').click =>
        $('.overlay').trigger('mouseleave')
        $('.overlay').remove()

      $('.support_form').on("ajax:complete", (ev,edata) =>
        $('.support_form').remove()
        $('.support').css('margin-top', '50%').html('Спасибо!')
        $('.small_overlay').append('<div class="we_will">Мы свяжемся с вами!</div>')
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
        @offset += @scrollWidth
        $('.news_slider').animate({left: @offset })
      if @offset >= 0
        $('.navigation > .left').css('display': 'none')
    $('.navigation > .right').click =>
      @offset -= @scrollWidth
      $('.news_slider').animate({left: @offset })
      if @offset <= (-1 * @scrollWidth)
        $('.navigation > .left').css('display': 'block')

    $('.news_link').on 'ajax:success', (e,data) =>
      $('.main-screen').append(data)
      @activateSlider()
      $('.close_button').click =>
        $('.overlay').trigger('mouseleave')
        $('.overlay').remove()

  updateTop: (data) ->
    $('.top').html(data)

  activateBack: () =>
    element = $('.close.back')
    if element.length > 0
      $('.burger').hide()
      element.click =>
        history.back()

  activatePromo: () =>
    $('.promo_buy').on 'ajax:success', (e, data) =>
      ui.updateCart(data)

  hideNav: () =>
    if window.innerWidth <= 760
      $('.sidenav').click () ->
        $('.sidenav').removeClass('hover')

  checkEmail: () =>
    $('.input > input[type=email]').change (e) ->
      re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      if not re.test e.target.value
        $('.input > input[type=email] ~ label').css(color: 'red !important', top: '-20px')
      else
        $('.input > input[type=email] ~ label').css(color: 'red')

  alton: =>
    if $('.screen').length > 0
      $('.screens').fullpage(
        sectionSelector: '.screen'
        slideSelector: '.slide'
        menu: '.sidenav'
        anchors: ['one','two','three', 'four', 'five']
        normalScrollElements: '.overlay, .cart_items'
        normalScrollElementTouchThreshold: 5
        recordHistory: false
        onLeave: (index, nextIndex, direction) ->
          $('.screens-navigation>.up').show() if nextIndex > 1
          $('.screens-navigation>.up').hide() if nextIndex == 1
          $('.screens-navigation>.down').show() if nextIndex < 5
          $('.screens-navigation>.down').hide() if nextIndex == 5
      )
      $('.screens-navigation>.up').click(()->
        $.fn.fullpage.moveSectionUp()
      ).hide()
      $('.screens-navigation>.down').click(()->
        $.fn.fullpage.moveSectionDown()
      )
    else
      $('.screens-navigation').hide()

  calculateNewsWidth: () =>
    newsbox = $('.news_box_wrapper')
    news_wrapper = $('.news_wrapper')
    if news_wrapper.width() < (newsbox.outerWidth())*2
      news_wrapper.width(newsbox.outerWidth())
      @scrollWidth = newsbox.outerWidth()+20
    else
      news_wrapper.width((newsbox.outerWidth()+20)*2)
      @scrollWidth = (newsbox.outerWidth()+20)*2


  confirmation: =>
    if localStorage.getItem('confirmed') == null
      $('.confirmation').css({'display':'block'})
    $('.confirmation_close, .registration_screen > .profile_overlay .close_button').click =>
      history.back()
    $('.confirmation_button').click =>
      localStorage.setItem('confirmed','true')
      $('.confirmation').remove()

  enableTabs: =>
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

  enableSubmits: =>
    $('.login_form').on( "ajax:success", (e, data) =>
      $('.overlay').trigger('mouseleave')
      $('.overlay').remove()
      @updateTop(data)
    ).on "ajax:error", (e, data) ->
      $('.errors').html(data.responseText)

  activateSidenav: =>
    sn_hide = =>
      $('.burger').hide()
      $('.cart-icon').hide()
    sn_show = =>
      $('.burger').show(300)
      $('.cart-icon').show(300)
    if window.innerWidth <=768
      $('.burger').click( ->
        $('.sidenav').css(height: '100vh')
      )
      $('.sidenav').click( ->
        $('.sidenav').css(height: '0')
      )
    else
      $('.sidenav').hover(sn_hide,sn_show)

  activateSlider: =>
    $('.resslides').responsiveSlides(
      pager: true
    )

  activateSpecial: =>
    $('.spslider').responsiveSlides(
      pager: true
      auto: true
    )

ready = ->
  window.ui = new Ui()

$(document).ready(ready)
