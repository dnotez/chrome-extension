var fs = require('fs');
var page;
var injectFn;

beforeEach(function(){
  console.log('before-each');
  page = require('webpage').create();
});