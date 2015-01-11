'use strict'
Msg = require('./msg')
SOF = require('./stackoverflow')
GITHUB = require('./github')

#get document url, if it is stackoverflow or github, post a message to background
GITHUB_PAGE = 'github'
SOF_PAGE = 'stackoverflow'
WIKIPEDIA_PAGE = 'wikipedia'
SITES = [GITHUB_PAGE, SOF_PAGE, WIKIPEDIA_PAGE]

port = chrome.runtime.connect {name: 'content'}
console.log('Content script post message, port:', port)


# callback when article saved, here we can update the page if required
articleSavedCallback = (data) ->
  for site in SITES
    if (document.URL.indexOf(site) > -1)
      switch site
        when GITHUB_PAGE then GITHUB.answerSavedSuccessfully(data)
        when SOF_PAGE then SOF.answerSavedSuccessfully(data)

#listener to handle background messages
port.onMessage.addListener (msg) ->
  if (msg and msg.type)
    switch msg.type
      when Msg.Type.ARTICLE_SAVED then articleSavedCallback msg.data
      when Msg.Type.BADGE_UPDATED then console.log('badge updated')
      else
        console.log 'unsupported type:' + msg.type
  return

# decorate current page if it is a supported site
for site in SITES
  if (document.URL.indexOf(site) > -1)
    port.postMessage({type: 'SUPPORTED_SITE', data: {site: site}})
    switch site
      when GITHUB_PAGE then GITHUB.addMarkup(port)
      when SOF_PAGE then SOF.addMarkup(port)
