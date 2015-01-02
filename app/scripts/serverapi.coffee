'use strict';
#for communication with pList server

Api = {}

BASE = 'http://localhost:5050'
apiPath = (section) -> BASE + section

submitData = (path, url, title, body, successCallback, errorCallback) ->
  $.ajax path,
    type: 'POST'
    dataType: 'json'
    data: JSON.stringify
      url: url
      title: title
      body: body
    success: (response, textStatus, jqXhr) ->
      successCallback response
    error: (jqXhr, status, error) ->
      errorCallback error, status

Api.saveArticle = (data, successCallback, errorCallback) ->
  path = apiPath('/extension/sof/answer')
  submitData path, data.url, data.qTitle, data.answerBody, successCallback, errorCallback

Api.savePage = (url, title, successCallback, errorCallback) ->
  path = apiPath('/extension/page')
  submitData path, url, title, '', successCallback, errorCallback

Api.saveSelectedText = (url, title, selectedText, successCallback, errorCallback) ->
  path = apiPath('/extension/selected')
  submitData path, url, title, selectedText, successCallback, errorCallback

Api.suggestion = (text, successCallback, errorCallback) ->
  path = apiPath('/extension/suggestion')
  $.ajax path,
    type: 'POST'
    dataType: 'json'
    data: JSON.stringify
      query: text
    success: (response, textStatus, jqXhr) ->
      successCallback response
    error: (jqXhr, status, error) ->
      console.log status, error
      errorCallback error, status

Api.articleUrl = (id) ->
  return BASE + '/extension/redirect/' + id

module.exports = Api