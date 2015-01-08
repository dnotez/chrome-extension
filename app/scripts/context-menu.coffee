'use strict'

ContextMenu = {}

#selectionCallback = (selection) ->
#document.getElementById("output").value = selection[0];
#console.log selection[0];

#chrome.tabs.executeScript
#code: 'window.getSelection().toString();',
#selectionCallback

ContextMenu.createMenu = (API) ->
  parent = chrome.contextMenus.create
    'title': 'dNotez'
    'contexts':['page', 'selection']

  successCallback = (response) ->
    console.log 'saved, response:', response

  errorCallback = (error, status) ->
    chrome.browserAction.setBadgeText
      text: 'Error'
    console.log 'error', status, error

  #a sub menu for saving full page
  savePageClickHandler = (e, tab) ->
    API.savePage e.pageUrl, tab.title, successCallback, errorCallback
  chrome.contextMenus.create
    'title': 'Save Page'
    'parentId': parent
    'contexts': ['page', 'selection']
    'onclick': savePageClickHandler

  #a sub menu for saving selected text
  saveSelectedTextHandler = (e, tab) ->
    API.saveSelectedText e.pageUrl, tab.title, e.selectionText, successCallback, errorCallback
  chrome.contextMenus.create
    'title': 'Save selection',
    'parentId': parent,
    'contexts': ['selection'],
    'onclick': saveSelectedTextHandler

  return

module.exports = ContextMenu