# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Shop
  constructor: ->

    $('.show_brand').on 'ajax:success', (e, data) =>
      $('.brands_screen').append(data)
    $('.item_about_link').on 'ajax:success', (e, data) =>
      $('.catalog_screen').append(data)

    $('a').on 'ajax:success', (e) =>
      @add_location(e.target['href'])
      $('.close_button').click =>
        remove_params()
        $('.overlay').remove()


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
