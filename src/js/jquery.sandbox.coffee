(($) ->
  'use strict'

  #
  # Utility functions
  #

  # utility for generate unique id
  alphanumeric = 'abcdefghijklmnopqrstuvwxyz'
  alphanumeric += alphanumeric.toUpperCase()
  alphanumeric += '0123456789'

  generate_id = ->
    id = ''
    for i in [1..16]
      id += alphanumeric[Math.floor(alphanumeric.length * Math.random())]
    return id

  # post() function can either post into the queue, or post directly to the iframe
  post_to_queue = (message) ->
    $.sandbox.queue.push message

  post_to_frame = (message) ->
    $.sandbox.frame.get(0).contentWindow.postMessage message, '*'

  post = post_to_queue

  # handler handles the message event of the window coming from the iframe
  handler = (e) ->
    data = JSON.parse e.originalEvent.data
    $.sandbox.sandboxes[data.id].callback data.data, data.error if data.id of $.sandbox.sandboxes

  # load iframe when first needed
  load_frame = (url) ->
    return if $.sandbox.frame
    $.sandbox.frame = $('<iframe />').attr('src', url).appendTo('body').css
      position: 'absolute'
      top: -9999
      left: -9999
      width: 100
      height: 100

    $.sandbox.frame.bind 'load', ->
      $(window).bind 'message', handler
      post = post_to_frame
      queue = $.sandbox.queue
      $.sandbox.queue = []
      for message in queue
        post message

  # unload iframe when there is no more sandbox
  unload_frame = ->
    return unless $.sandbox.frame
    return if $.sandbox.count > 0
    $(window).unbind 'message', handler
    post = post_to_queue
    $.sandbox.frame.unbind().remove()
    $.sandbox.frame = null   


  #
  # Sandbox class
  #

  Sandbox = (options) ->
    @options = $.extend true, {}, $.sandbox.defaults, options or {}
    @id = generate_id()
    @state = 'init'
    return this

  Sandbox:: =

    constructor: Sandbox

    callback: (data, error) ->
      @options.callback.apply this, [data, error]

    post: (command, options) ->
      post JSON.stringify
        id: @id
        command: command
        options: options

    run: ->
      return if @state isnt 'init'      
      load_frame @options.url
      @post 'run',
        scripts: @options.scripts
        timeout: @options.timeout
      @state = 'running'

    terminate: ->
      return if @state isnt 'running'
      @post 'terminate'
      @state = 'terminated'
      delete $.sandbox.sandboxes[@id]
      $.sandbox.count--

  $.sandbox = (options) ->
    return null unless $.support.sandbox
    sandbox = new Sandbox options
    $.sandbox.sandboxes[sandbox.id] = sandbox
    $.sandbox.count++
    sandbox.run()
    return sandbox

  $.sandbox.defaults =
    timeout: 0
    url: '//d3ltuim8m8ytq2.cloudfront.net/jquery-sandbox/0.0.1/sandbox.html'
    scripts: []
    callback: (data, error) ->
      true

  $.sandbox.sandboxes = {}
  $.sandbox.count = 0
  $.sandbox.frame = null
  $.sandbox.queue = []

  $.support.sandbox = typeof Worker isnt undefined

) window.jQuery

