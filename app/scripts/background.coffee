'use strict'

API = require('./serverapi')
Msg = require('./msg')
Suggestion = require('./suggestion')
ContextMenu = require('./context-menu')

chrome.runtime.onInstalled.addListener (details) ->
  console.log('previousVersion', details)

  Suggestion.install API
  ContextMenu.createMenu API

#submit article to server using server api
submitArticle = (data, port) ->
  successCallback = (response) ->
    #send back the data object, so the content scripts knows how to handle the response
    port.postMessage({type: Msg.Type.ARTICLE_SAVED, response: response, data: data})
  errorCallback = (error, status) ->
    chrome.browserAction.setBadgeText({text: 'Error'})
    console.log('error', status, error)

  API.saveArticle(data, successCallback, errorCallback)

updateBadge = (data, port) ->
  chrome.browserAction.setBadgeText({text: data.site.charAt(0)})
  port.postMessage({type: 'BADGE_UPDATED', data: data})


chrome.runtime.onConnect.addListener (port) ->
  console.log('content port opened:', port)
  chrome.browserAction.setBadgeText({text: ''})
  port.onMessage.addListener (msg) ->
    if (msg and msg.type)
      switch msg.type
        when Msg.Type.SUPPORTED_SITE then updateBadge msg.data, port
        when Msg.Type.SAVE_ANSWER then submitArticle msg.data, port

        else
          console.log 'unsupported type:' + msg.type
    return
  return
