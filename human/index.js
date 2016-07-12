var os;
var fs;
var http;
var https;
var chalk;
var express;
var socket;
var highland;
var commander;
var child_process;

var DaemonPlugin;
var Interface;

os = require('os');
fs = require('fs');
http = require('http');
https = require('https');
chalk = require('chalk');
express = require('express');
socket = require('socket.io');
highland = require('highland');
commander = require('commander');
child_process = require('child_process');

DaemonPlugin = (function(){
	var constructor;
	var prototype;

	constructor = DaemonPlugin;
	prototype = constructor.prototype;

	DaemonPlugin.displayName = "DaemonPlugin"

	prototype.toString = function toString() {
		return "[object DaemonPlugin]";
	};

	function DaemonPlugin(program) {
		this.program = program;
	}

	return DaemonPlugin;
}());

Interface = (function(superclass){
	var constructor;
	var prototype;

	constructor = Interface;
	prototype = constructor.prototype;

	Interface.displayName = "Interface"

	prototype.toString = function toString() {
		return "[object Interface]";
	};

	function Interface(program) {
		this.program = program;
	}

	return Interface;
}(DaemonPlugin));
