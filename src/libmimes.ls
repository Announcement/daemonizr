require! <[http socket.io]>

DaemonPlugin = global.DaemonPlugin

class MimesDaemon extends DaemonPlugin
    description: 'Provides filetype detection and executable registration methods'

    enabled: yes

    verify: -> yes

    extensions =
        js: \javascript
        rb: \ruby
        ls: \livescript
        coffee: \coffee-script
        p6: \perl6
        pl: \perl5
        py: \python
        sh: \shell
        bat: \batch
        cmd: \batch

    handlers =
        javascript: \node
        'coffee-script': \coffee
        livescript: \lsc
        perl5: \perl
        bat: <[cmd /C]>
        cmd: @bat

    configure: ->
        it.option '-x, --executable <program>', 'uses the specified executable'

    initialize: ->
        # always being loaded
        # will definately require some hooks

    -> @install!


module.exports = MimesDaemon
