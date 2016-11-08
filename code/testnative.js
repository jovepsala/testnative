#!/usr/bin/env node
/**
 * TestNative, 18.10.2013 Spaceify Oy
 *
 * @class TestNative
 */

var spaceify = require("/var/lib/spaceify/code/www/libs/spaceifyapplication.js");

function TestNative()
{
var self = this;

var testNativeService = null;

var getRand = function(connObj, callback)
	{
	callback(null, parseInt(Math.random() * 1000));
	}

self.start = function()
	{
	testNativeService = spaceify.getProvidedService("spaceify.org/services/testnative");

	testNativeService.exposeRpcMethod("getRand", self, getRand);
	}

self.fail = function(err)
	{
	}

var stop = function()
	{
	spaceify.stop();
	}

}

var testNative = new TestNative();
spaceify.start(testNative, {/*webServers: {http: true, https: true},*/ webSocketServers: {unsecure: true, secure: true}});
