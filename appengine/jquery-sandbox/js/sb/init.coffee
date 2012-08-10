((window) ->
  window._gaq = window._gaq or []
  window._gaq.push ['_setAccount', '']
  window._gaq.push ['_trackPageview']

  ga = document.createElement('script')
  ga.type = 'text/javascript'
  ga.async = true
  ga.src = (if document.location.protocol is 'https:'  then 'https://ssl' else 'http://www') + '.google-analytics.com/ga.js'
  document.getElementsByTagName('body')[0].appendChild ga

  $ ->
    setInterval ->
      for i in [1..10]
        (->
          j = i
          sandbox = $.sandbox
            #url: '/sandbox/'
            scripts: ['data:application/javascript,' + encodeURIComponent('postMessage("Hello' + j + '");')]
            callback: (data, error) ->
              debug.assert data == 'Hello' + j
              this.terminate()
        )()
    , 5000
) window
