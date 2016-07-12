class EventsDaemon extends DaemonPlugin
    description: 'allows for definitions of activities such as reload on file change'

    enabled: yes
    
    -> @install!

    configure: ->
        it.option '-a, --autonomous', 'listens to the various restart triggering signals'

        # error handling
        it.option '-e, --errors', 'watch the process for errors, provides an error event'
        it.option '-E, --enforce-errors', 'watch the process for errors, provides handlers for error types'

        # file changes
        it.option '-w, --watch', 'watch the file for changes, provides an update event'

        it.option '-d, --directory', 'watches the entire directory for changes'
        it.option '-r, --recursive', 'allows recursive directory watching'

    initialize: ->
        @parse-parameters it
        @enabled := it.autonomous
        return no unless @enabled

    verify: -> @enabled # don't leave this, actually add some checks

    notice: ->
        console.log it, @@displayName

    parse-parameters: ->
        # -e implies -a
        # -w implies -a
        # -d implies -w, but not -a
        # -r implies -d, -w but not -a
        if it.errors then it <<< {+autonomous}
        if it.watch then it <<< {+autonomous}
        if it.directory then it <<< {+watch}
        if it.recursive then it <<< {+directory, +watch}

module.exports = EventsDaemon
