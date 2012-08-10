((window) ->
  'use strict'

  namespace = (target, name, block) ->
    [target, name, block] = [window, arguments...] if arguments.length < 3
    top = target
    target = target[item] or= {} for item in name.split '.'
    block target, top

  namespace 'sb', (exports, top) ->
    exports.namespace = namespace

)(window)

sb.namespace 'sb.settings', (exports) ->
  'use strict'

  exports.initialize = ->
    $.each $('.js-settings *'), ->
      name = $(this).data('name')
      value =  $(this).data('value')
      return if not name or not value
      exports[name] = value
      debug.setLevel(9) if name == 'DEBUG' and value
      debug.info 'sb.settings.' + name + ' = ' + value
    $('.js-settings').remove()

$ ->
  sb.settings.initialize()

  $('*[title]').tooltip
    placement: 'bottom'
