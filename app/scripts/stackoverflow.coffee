'use strict';

Utils = require('./contentutil')

SOF = {}
#unique id for each save button
saveBtnId = (answerId) ->
  return 'plSaveBtn_' + answerId

#private helper method to add save button to each answer div
answerHandler = (element, questionTitle, questionId, port) ->
  answer = $(element)
  answerId = answer.data('answerid')
  btnId = saveBtnId(answerId)
  answer.find('.vote').append('<a class="pl-btn save-it" id="' + btnId + '">Save</a>')
  document.getElementById(btnId).addEventListener('click', () ->
    answerBody = answer.find('.post-text')[0].outerHTML
    shortUrl = answer.find('.short-link').attr('href')
    #here we can post the message to background script
    msgData =
      url: Utils.qualifyURL shortUrl
      q: questionId
      qTitle: questionTitle
      answerId: answerId
      answerBody: answerBody
    port.postMessage({type: 'SAVE_ANSWER', data: msgData})
  )

#public method, call this to add 'save' button to each answer
SOF.addMarkup = (port) ->
  questionTitle = $('#question-header').text().trim()
  questionId = $('.question').data('questionid')
  eachCallback = (index, element) ->
    answerHandler(element, questionTitle, questionId, port)
  $('.answer').each(eachCallback)

#this is called when answer successfully saved
SOF.answerSaved = (data) ->
  #find save button
  saveBtn = $('#' + saveBtnId(data.answerId))
  saveBtn.text('Saved')
  saveBtn.attr('class', 'pl-btn saved')

module.exports = SOF