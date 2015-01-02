'use strict';

Utils = require('./contentutil')

Suggestion = {}

Suggestion.install = (API) ->
  #omnibox listeners
  # This event is fired each time the user updates the text in the omnibox,
  # as long as the extension's keyword mode is still active.
  chrome.omnibox.onInputChanged.addListener (text, suggest) ->
    if text.length is 0
      return
    successCallback = (response) ->
      if response.error
        suggest [{content: 'Server Error:' + Utils.escapeXml(response.errorMessage), description: 'Backend error'}]
      else
        suggestions = response.results.map (result) -> {content: result.id, description: Utils.escapeXml(result.suggestion)}
        suggest suggestions
    #console.log suggestions
    errorCallback = (error, status) ->
      suggest [{content: 'Server Error:' + Utils.escapeXml(error), description: 'status:' + status}]
      chrome.browserAction.setBadgeText({text: 'S-Err'})
    API.suggestion(text, successCallback, errorCallback)

  # This event is fired with the user accepts the input in the omnibox.
  chrome.omnibox.onInputEntered.addListener (text) ->
    tabCallback = (tab) ->
      url = API.articleUrl(text)
      chrome.tabs.update tab.id, {url: url}
    chrome.tabs.getSelected null, tabCallback
#here we can redirect user to our website

module.exports = Suggestion