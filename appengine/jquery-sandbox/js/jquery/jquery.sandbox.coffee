(($) ->
  'use strict'

  alphanumeric = 'abcdefghijklmnopqrstuvwxyz'
  alphanumeric += alphanumeric.toUpperCase()
  alphanumeric += '0123456789'

  Sandbox = (options) ->
    that = this

    @options = $.extend true, {}, $.sandbox.defaults, options or {}

    # generate a unique id
    @id = ''
    for i in [1..16]
      @id += alphanumeric[Math.floor(alphanumeric.length * Math.random())]

    # create iframe
    @loaded = false
    @iframe = $('<iframe />').attr('src', @options.url).appendTo('body').css
      position: 'absolute'
      top: -9999
      left: -9999
      width: 100
      height: 100
    @iframe.bind 'load', ->
      that.loaded = true

    # bind window event
    @messaged = (e) ->
      data = e.originalEvent.data
      data = JSON.parse data
      return if data.id != that.id or not that.iframe
      debug.debug 'jquery.sandbox.onmessage', e.originalEvent.data
      that.options.callback.apply that, [data.data, data.error]
    $(window).bind 'message', @messaged

    return this

  Sandbox:: =

    constructor: Sandbox

    post: (message) ->
      debug.debug 'jquery.sandbox.post', message
      if @loaded
        @iframe[0].contentWindow.postMessage message, '*'
        return
      that = this
      @iframe.load ->
        that.iframe[0].contentWindow.postMessage message, '*'

    run: ->
      @post JSON.stringify
        id: @id
        command: 'run'
        scripts: @options.scripts
        timeout: @options.timeout

    terminate: ->
      that = this

      $(window).unbind 'message', @messaged

      @post JSON.stringify
        id: @id
        command: 'terminate'

      setTimeout ->
        that.iframe.remove().unbind()
        delete that.iframe
        that.iframe = null
      , 250

  $.sandbox = (options) ->
    return null if not $.support.sandbox
    sandbox = new Sandbox options
    sandbox.run()
    return sandbox

  $.sandbox.defaults =
    timeout: 5000
    url: '//d1m5ueji66brab.cloudfront.net/sandbox/'
    scripts: []
    callback: (data, error) ->
      true

  $.sandbox.Constructor = Sandbox

  $.support.sandbox = typeof Worker isnt undefined

) window.jQuery
