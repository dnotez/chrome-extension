'use strict';

Utils = {}
Utils.qualifyURL = (url) ->
  img = document.createElement 'img'
  img.src = url
  url = img.src
  img.src = null
  return url

Utils.escapeXml = (str) ->
  return str.replace(/&/g, '&amp;')
  .replace(/</g, '&lt;')
  .replace(/>/g, '&gt;')
  .replace(/"/g, '&quot;')
  .replace(/'/g, '&apos;')

module.exports = Utils