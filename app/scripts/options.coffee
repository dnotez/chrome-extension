saveOptions = () ->
  serverIP = document.getElementById('serverIP').value
  chrome.storage.sync.set({
    serverIP: serverIP
  }, () ->
    status = document.getElementById 'status'
    status.textContent = 'Options saved.'
    setTimeout () ->
      status.textContent = ''
      return
    , 750
    return
  )
  return
loadOptions = () ->
  chrome.storage.sync.get({
    serverIP: 'localhost:5050'
  }, (items) ->
    document.getElementById('serverIP').value = items.serverIP
    return
  )

document.addEventListener 'DOMContentLoaded', loadOptions
document.getElementById('save').addEventListener('click', saveOptions)