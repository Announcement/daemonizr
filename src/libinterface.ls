require! <[http express socket.io]>

DaemonPlugin = global.DaemonPlugin

class Interface extends DaemonPlugin
  description: 'Provides a web server and websocket protocol interface'
  enabled: no

  start-server: ->
    @configure-server!
    @server.listen @program.port or 0

    "This module is loaded and listening on port #{ @server.address!port }"

  configure-server: ->
    @server.on \request (request, response) ->
      response.end 'You are monitoring an unconfigured daemonizr instance.'

    @io.on \connection (socket) ->
      socket.send 'You are monitoring an unconfigured daemonizr instance'

  initialize: ->
    @app = express!
    @server = http.create-server @app
    @io = socket @server

    @enabled := @program.port
    @start-server! if @program.port

    return if @enabled

    'This module was loaded, but not enabled by the user.'

  verify: -> @enabled  # don't leave this, actually add some checks

  (@program) ->
    @register '-h, --server [port]', 'enables an option web server interface'
    @install!

module.exports = Interface
