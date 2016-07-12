require! <[http express socket.io]>

class Interface extends DaemonPlugin
    description: 'Provides a web server and websocket protocol interface'

    -> @install!

    enabled: yes
    verify: -> yes
    
    configure: ->
        it.option '-h, --server [port]' 'enables an option web server interface'

    initialize: ->
        @app = express!
        @server = http.create-server @app
        @io = socket @server

        @enabled := it.port
        @start-server! if it.port

        return if @enabled

        'This module was loaded, but not enabled by the user.'

    start-server: ->
        @configure-server!
        @server.listen @program.port or 0

        "This module is loaded and listening on port #{ @server.address!port }"

    configure-server: ->
        @server.on \request (request, response) ->
        response.end 'You are monitoring an unconfigured daemonizr instance.'

        @io.on \connection (socket) ->
        socket.send 'You are monitoring an unconfigured daemonizr instance'

    verify: -> @enabled  # don't leave this, actually add some checks

module.exports = Interface
