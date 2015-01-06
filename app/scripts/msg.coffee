'use strict'
# message types used in content and background
Msg = {}

Msg.Type =
  # this message will be sent from background to the content when badge has been updated
  BADGE_UPDATED: 'BADGE_UPDATED'
  # ack of saving new articles
  ARTICLE_SAVED: 'ARTICLE_SAVED'

  SUPPORTED_SITE: 'SUPPORTED_SITE'
  SAVE_ANSWER: 'SAVE_ANSWER'

module.exports = Msg