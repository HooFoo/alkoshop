# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Shop

  constructor: ->
    @offset = 24
    @handle_links()
    $('.catalog_screen, .brands_screen').bind "DOMSubtreeModified", () =>
      @activate_buttons()
    @handle_filters()
    @activate_more()
    @update_more()

  add_location: (url) =>
    type = url.split('?')[1]
    if type.length >= 3 #minimum t=0
      type = type.split('=')[0]
      id = url.split('=')[1]
    location.href = add_params(type,id,location.href)

  check_href: =>
    arr = location.href.split('#')
    if arr.length > 1
      a = arr[1].split('=')
      if a.length == 2
        $("a[href*='#{arr[1]}']")[0].click()

  activate_buttons: =>
    $('.count').change (e)=>
      button= $('.cart_section > .sbutton > a')[0]
      base= button.href.split('?')[0]
      params = button.href.split('?')[1].split('&')
      url = "#{base}?#{params[0]}&quantity=#{e.target.value}"
      button.href = url
    $('.close_button').click =>
      console.log('Тута')
      remove_params()
      $('.overlay').remove()
    $('.buy').on 'ajax:success', (e, data) =>
      ui.updateCart(data)
    $('.overlay').find('.about').on 'ajax:success', (e,data) =>
      @activate_overlay(e,data)


  activate_overlay: (e,data) =>
    $('.overlay').remove()
    $('.brands_screen, .catalog_screen').append(data)
    @add_location(e.target['href'])

  update_more: =>
    $('.more_link')[0 ].href = "/shop/more#{location.search}&offset=#{@offset}"

  activate_more: =>
    $('.more_link').on 'ajax:success', (e,data) =>
      $('.items').append(data)
      @handle_links()
      @offset += 24
      @update_more()

  handle_links: =>
    $('.about').on 'ajax:success', (e, data) =>
      @activate_overlay(e,data)

  handle_filters: =>
    $('.filter').on 'change', (e) =>
      type = e.target.id
      value = e.target.value
      url = "#{location.origin}#{location.pathname}"
      filters = $.makeArray($('select.filter, input.filter').map( (index,element) =>
        "#{element.id}=#{element.value}"
      ))
      console.log(filters)

      location.href = "#{url}?#{filters.join('&')}"




  add_params = (key, val, url ) ->
    arr = url.split('#')

    if arr.length == 1
      return url + '#' + key + '=' + val
    else if arr.length == 2
      if arr[1] == ''
        return arr[0] + '#' + key + '=' + val
      else
        params = arr[1].split('&')
        p = {}
        a = []
        strarr = []
        $.each params, (index, element) ->
          a = element.split('=')
          p[a[0]] = a[1]
          return
        p[key] = val
        for o of p
          strarr.push o + '=' + p[o]
        str = strarr.join('&')
        return arr[0] + '#' + str
    return

  remove_params = () =>
    location.href = location.href.split('#')[0]+'#'

$(document).on('turbolinks:load', ->
  window.shop = new Shop()
  window.shop.check_href()
)
