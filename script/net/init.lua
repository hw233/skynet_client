net = net or {}

function net.init()
	net.test = require "script.net.test"
	net.login = require "script.net.login"
	net.player = require "script.net.player"
	net.msg = require "script.net.msg"
	net.friend = require "script.net.friend"
	net.war = require "script.net.war"
end
return net
