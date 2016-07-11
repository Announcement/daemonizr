
DaemonPlugin = global.DaemonPlugin

class EventsDaemon extends DaemonPlugin
  description: 'allows for definitions of activities such as reload on file change'

  initialize: ->
    @enabled := @program.autonomous
    return no unless @enabled

  verify: -> @enabled # don't leave this, actually add some checks

  notice: ->
    console.log it, @@displayName

  parse-parameters: ->
    # -e implies -a
    # -w implies -a
    # -d implies -w, but not -a
    # -r implies -d, -w but not -a

    if @program.errors then @program <<< {+autonomous}
    if @program.watch then @program <<< {+autonomous}
    if @program.directory then @program <<< {+watch}
    if @program.recursive then @program <<< {+directory, +watch}

  (@program) ->
    @install!

    @parse-parameters!

    @register '-a, --autonomous', 'listens to the various restart triggering signals'

    # error handling
    @register '-e, --errors', 'watch the process for errors, provides an error event'
    @register '-E, --enforce-errors', 'watch the process for errors, provides handlers for error types'

    # file changes
    @register '-w, --watch', 'watch the file for changes, provides an update event'

    @register '-d, --directory', 'watches the entire directory for changes'
    @register '-r, --recursive', 'allows recursive directory watching'


module.exports = EventsDaemon
