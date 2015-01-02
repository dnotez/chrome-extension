'use strict';
Msg = require('./msg')
SOF = require('./stackoverflow')

#get document url, if it is stackoverflow or github, post a message to background
SITES = ['github', 'stackoverflow', 'wikipedia']

port = chrome.runtime.connect {name: 'content'}
console.log('Content script post message, port:', port)


# callback when article saved, here we can update the page if required
articleSaved = (data) ->
  for site in SITES
    if (document.URL.indexOf(site) > -1)
      if (site == SITES[1])
        SOF.answerSaved(data)

#listener to handle background messages
port.onMessage.addListener (msg) ->
  if (msg and msg.type)
    switch msg.type
      when Msg.Type.ARTICLE_SAVED then articleSaved msg.data
      when Msg.Type.BADGE_UPDATED then console.log('badge updated')
      else
        console.log 'unsupported type:' + msg.type
  return

for site in SITES
  if (document.URL.indexOf(site) > -1)
    port.postMessage({type: 'SUPPORTED_SITE', data: {site: site}})

    if (site == SITES[1])
      SOF.addMarkup(port);
