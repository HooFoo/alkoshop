# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Shop
  constructor: ->
    $('.show_brand').on 'ajax:success', (e, data) =>
      $('.brands_screen').append(data)
    $('.item_about_link').on 'ajax:success', (e, data) =>
      $('.catalog_screen').append(data)

$(document).on('turbolinks:load', ->
  window.shop = new Shop()
)
