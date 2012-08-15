((self) ->
  'use strict'

  report = (id, data, error) ->
    message = JSON.stringify
      id: id
      data: data
      error: error
    parent.postMessage message, '*'

  Worker = self.Worker
  return report undefined, undefined, 'unsupported' unless Worker

  defaults =
    worker: 'worker.js'
    timeout: 0
    scripts: []

  sandboxes = {}

  Sandbox = (id, options) ->
    @id = id
    @options = defaults
    for key, value of options or {}
      @options[key] = value
    @worker = null
    @timer = null
    return this

  Sandbox:: =

    constructor: Sandbox

    report: (data, error) ->
      report @id, data, error

    run: ->
      that = this

      # set timer
      if @options.timeout
        @timer = setTimeout ->
          that.terminate()
          that.report undefined, 'timeout'
        , @options.timeout

      # create worker
      @worker = new Worker @options.worker
      @worker.onmessage = (e) ->
        data = JSON.parse e.data
        that.report data.data, data.error

      # send message
      message = JSON.stringify
        scripts: @options.scripts
      @worker.postMessage message

    terminate: ->
      return unless @worker
      clearTimeout @timer if @timer
      @timer = null
      @worker.onmessage = null
      @worker.terminate()
      @worker = null
      delete sandboxes[@id]

  self.addEventListener 'message', (e) ->
    data = JSON.parse e.data

    if data.command is 'run'
      return report data.id, undefined, 'running' if data.id of sandboxes
      sandbox = new Sandbox(data.id, data.options)
      sandboxes[data.id] = sandbox
      sandbox.run()

    if data.command is 'terminate'
      return report data.id, undefined, 'terminated' unless data.id of sandboxes
      sandboxes[data.id].terminate()

) window
