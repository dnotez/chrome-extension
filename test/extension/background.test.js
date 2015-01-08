/*
 * Background page tests
 */


describe('background page', function() {

  // sometimes it takes time to start phantomjs
  this.timeout(4000);

  // empty html page aka generated background page
  var filename = 'empty.html';

  it('should create context menu and suggestion omnibox', function(done) {
    // having
    injectFn = function() {
      page.evaluate(function(tabs) {
        // stub `chrome.tabs.query`
        chrome.tabs.query.yields(JSON.parse(tabs));
      }, fs.read('test/extension/data/tabs.json'));

      // run background js
      //page.injectJs('.tmp/scripts/serverapi.js');
      //page.injectJs('.tmp/scripts/msg.js');
      //page.injectJs('.tmp/scripts/suggestion.js');
      //page.injectJs('.tmp/scripts/context-menu.js');
      page.injectJs('.tmp/scripts/background.js');

    };
    // when
    page.open(filename, function(status) {
      page.evaluate(function() {
        // then
        sinon.assert.calledOnce(chrome.runtime.onInstalled.addListener);
        sinon.assert.calledOnce(chrome.runtime.onConnect.addListener);
        //title, `save page` an `save selection`
        sinon.assert.calledThrice(chrome.contextMenus.create);
        sinon.assert.calledOnce(chrome.omnibox.onInputChanged.addListener);
      });
      done();
    });
  });

  /*
  it('should retrieve IP when `get-ip` message comes', function(done) {
    // having
    injectFn = function() {
      page.evaluate(function(response) {
        server = sinon.fakeServer.create();
        server.respondWith("http://httpbin.org/ip", [
          200,
          { "Content-Type": "application/json" },
          response
        ]);
      }, fs.read('test/data/ip-ok.json'));

      // run background js
      page.injectJs('src/background.js');

      // trigger `get-ip` event
      page.evaluate(function() {
        sendResponse = sinon.spy();
        chrome.runtime.onMessage.trigger('get-ip', {}, sendResponse);
        server.respond();
      });
    };
    // when
    page.open(filename, function(status) {
      page.evaluate(function() {
        // then
        sinon.assert.calledOnce(sendResponse);
        sinon.assert.calledWith(sendResponse, '1.2.3.4');
      });
      done();
    });
  });
  */
});