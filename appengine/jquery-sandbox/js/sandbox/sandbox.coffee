(($) ->
  'use strict'

  sandboxes = {}

  Sandbox = (id, options) ->
    @id = id
    @options = $.extend true, {}, $.sandbox.defaults, options or {}
    debug.setLevel(9) if @options.debug

    if typeof Worker is undefined
      debug.debug 'sandbox.worker.unavailable'
    else
      # create a worker
      debug.debug 'sandbox.worker.url', @options.url
      @worker = new Worker @options.url

    return this

  Sandbox:: =

    constructor: Sandbox

    report: (data, error) ->
      message = JSON.stringify
        id: @id
        data: data
        error: error
      debug.debug 'sandbox.report', message
      parent.postMessage message, '*'

    run: (scripts, timeout) ->
      return if not @worker or @timer
      that = this

      # set timer
      @timer = setTimeout ->
        that.terminate()
        debug.debug 'sandbox.worker.timeout'
        that.report undefined, 'timeout'
      , timeout

      # hook up onmessage
      @worker.onmessage = (e) ->
        data = e.data
        debug.assert typeof data is 'string'
        debug.debug 'sandbox.worker.onmessage', data
        data = JSON.parse data
        that.report data.data, data.error

      # send message
      message = JSON.stringify
        scripts: scripts
      debug.debug 'sandbox.worker.postMessage', message
      @worker.postMessage message

    terminate: ->
      return if not @worker
      clearTimeout @timer
      @worker.onmessage = null
      @worker.terminate()
      @worker = null
      debug.debug 'sandbox.worker.terminated'

  $.sandbox = (id, options) ->
    return new Sandbox id, options

  $.sandbox.defaults =
    debug: false
    url: '/static/js/worker.min.js'

  $.sandbox.Constructor = Sandbox

  $(window).on 'message', (e) ->
    data = e.originalEvent.data
    data = JSON.parse data
    if data.command is 'run'
      sandbox = sandboxes[data.id] = $.sandbox(data.id)
      sandbox.run data.scripts, data.timeout
    if data.command is 'terminate'
      sandboxes[data.id].terminate() if sandboxes[data.id]
      delete sandboxes[data.id]

) window.jQuery
