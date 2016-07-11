require! <[http socket.io]>

DaemonPlugin = global.DaemonPlugin

class MimesDaemon extends DaemonPlugin
  description: 'Provides filetype detection and executable registration methods'

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

  initialize: ->
    # always being loaded
    # will definately require some hooks

  (@program) ->
    @register '-x, --executable <program>', 'uses the specified executable'
    @install!


module.exports = MimesDaemon
