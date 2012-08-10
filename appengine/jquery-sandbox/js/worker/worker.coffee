((self) ->
  'use strict'

  # save stuffs we need
  postMessage = self.postMessage
  importScripts = self.importScripts
  jsonParse = JSON.parse
  jsonStringify = JSON.stringify

  handler = (e) ->
    try
      request = jsonParse e.data
      for script in request.scripts
        importScripts script
        delete self.onmessage
    catch error
      delete self.onmessage
      postMessage jsonStringify
        error: error or null

  # provide a way to send message back
  self.postMessage = (data) ->
    postMessage jsonStringify
      data: data

  self.addEventListener 'message', handler, false

  # undefine unsafe functions
  self.Woker = undefined
  self.importScripts = undefined
  self.ActiveXObject = undefined

) self