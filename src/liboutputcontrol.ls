require! <[chalk os]>

DaemonPlugin = global.DaemonPlugin

class OutputControl extends DaemonPlugin
  ->
    @install!
    @register '-c, --no-color' 'disable colors in the output'
    @register '-v, --verbose' 'displays debugging information'
    @register '-w, --warnings' 'displays optional warnings, useful for debugging'
    @register '-s, --silent' 'silences both all nonessential and essential output'

  @enabled = yes
  verify: -> yes

  initialize: ->
    "#{it}"

module.exports = OutputControl


/*

verbosity =
  debug: !program.silent and program.verbose
  warn: !program.silent and (program.verbose or program.warnings)
  info: !program.silent and yes

print-line = ->
  print os.EOL

print-string = ->
  print it

print-array = ->
  @level ||= 1

  buffer = ' ' * 2 * @level

  level = 1 + @level

  display = ~> say!call {level: level} it

  for item in it
    unless item@@ is Array then say buffer
    display item

print-format =  (format) ->
  (...parameters) ->
    format
      .replace /%(\(?\-?)(\d*)(\.\d*[dnf]|s)/gi, ->
        console.log it
        it
      .replace /[^\\]#\{([^}]+)\}/gi, ->
        console.log it
        it

print-format '%s'

print-util-length = ->
  it.length or 80

print-object = ->
  @level ||= 1

  keys = []
  values = []

  for own let k, v of it
    keys.push k if k@@ is String
    values.push v if v@@ is String

  longest-key = keys.map (.length) .reduce (-> Math.max &0, &1 )
  longest-value = values.map (.length) .reduce (-> Math.max &0, &1 )

  for own let k, v of it
    say k
    say ' ' * (longest-key - k.length + 1)
    say! v

print-number = ->
  if program.color? then chalk.green it

say = (first) ->
  handle = ->
    switch it@@
      when String then print-string ...
      when Array  then print-array  ...
      when Object then print-object ...
      when Number then print-number ...
    unless first? then print-line   ...
  if first? then handle.apply {} <<<< @, & else handle

puts = -> # newline
  process.stdout.write "#{it}#{os.EOL}"

print = -> # no newline
  process.stdout.write "#{it}"

module.exports = ->
  importance = 0

  aliases =
    label:
      priority: \normal
      mutators: chalk.gray

    variable:
      priority: \normal
      mutators: chalk.blue

    emphasis:
      priority: \raised
      mutators: chalk.bold

    important:
      priority: \warn
      mutators: (chalk.bold >> chalk.yellow)

    critical:
      priority: \urgent
      mutators: (chalk.bold >> chalk.red)

  for own let key, value of aliases
    @[key] = ->
      set-importance value.priority
      if program.colors then value.mutators it else it

  unless it@@ is Function then say! it else say! it ...
*/
