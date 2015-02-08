'use strict'

Utils = require('./contentutil')

GITHUB = {}

generateLinkId = (elementId) ->
  return 'dzBtn_'+elementId

addIssueMarkup = (port) ->
  issueTitle = $('.js-issue-title').text().trim()
  issueId = $('.gh-header-number').text().trim()
  saveComment = (index, element) ->
    comment = $(element)
    commentId = comment.find('.timeline-comment').attr('id')
    btnId = generateLinkId(commentId)
    comment.find('.timeline-comment-avatar').parent().append('<a href="#" class="pl-btn save-it pl-github-comment" id="' + btnId + '">Save</a>')
    document.getElementById(btnId).addEventListener('click', () ->
      timestamp = comment.find('.timestamp')
      commentUrl = timestamp.attr('href')
      datetime = timestamp.find('time').attr('datetime')
      author = comment.find('.author').text()
      commentContent = comment.find('.comment-content')[0].outerHTML
      msgData =
        url: Utils.qualifyURL commentUrl
        q: issueId
        qTitle: issueTitle
        answerId: commentId
        answerBody: commentContent
        author:author
        date: datetime
      #console.log('saving github comment, message:', msgData)
      port.postMessage({type: 'SAVE_ANSWER', data: msgData})
      return
    )
    return

  $('.js-comment-container').each(saveComment)

#unique id for each save button
GITHUB.addMarkup = (port) ->
  #add save button to each issue
  addIssueMarkup port

GITHUB.answerSavedSuccessfully = (data) ->
  console.log 'answerSavedSuccessfully not impl yet, data:', data

module.exports = GITHUB