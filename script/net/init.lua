net = net or {}

function net.init()
	net.test = require "script.net.test"
	net.login = require "script.net.login"
	net.player = require "script.net.player"
	net.msg = require "script.net.msg"
	net.friend = require "script.net.friend"
	net.war = require "script.net.war"
	net.mail = require "script.net.mail"
	net.team = require "script.net.team"
	net.scene = require "script.net.scene"
end
return net
