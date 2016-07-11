require! {
  os
  fs
  http
  https
  chalk
  express
  highland
  commander
  child_process
  'socket.io': \io
}


# helpers = require './helpers.js'

global import require \prelude-ls

class DaemonPlugin
  enabled: yes
  description: 'This module does not have a description specified'

  install: ->
    global[@@displayName] = this

  register: ->
    @program.option.apply @program, arguments

  notice: (name, parameters, scope) ->

  handle: (name) ->
    $self = this
    -> $self.notice.call $self, name, &, @

  verify: -> no
  initialize: -> no

  (@program) -> 

global.DaemonPlugin = DaemonPlugin
program = commander

console.log new DaemonPlugin(commander)

commander
  .version '1.0.0'

commander.option '-C, --command' 'specify the command to be run'
commander.option '-W, --cwd' 'specify the current working directory for the child process'
commander.option '-D, --detached' 'wether it should be detached or not'
commander.option '-S, --shell [string]' 'if true, runs command inside of a shell. a different shell can be specified as a string', false

global.libraries = []

function library name
  Library = require("./lib#{name}")
  instance = new Library(commander);
  global.libraries.push instance

library \outputcontrol
library \interface
library \events
library \mimes

commander.parse process.argv

[..initialize! for libraries]

source = (name) -> -> [..handle(name) & for libraries]

do function configure-spawn-options
  if commander.cwd is true then commander.cwd = process.cwd!

  global.spawn-options = {}
  global.spawn-options[ \detached ] = commander.detached if commander.detached
  global.spawn-options[ \cwd ] = commander.cwd if commander.cwd
  global.spawn-options[ \shell ] = commander.shell if commander.shell

  return global.spawn-options

do function main
  executable = program.executable or \node
  args = program.args or []
  options = global.spawn-options

  spawned = child_process.spawn executable, args, spawn-options

  process.on \message -> source(\message) @, &
  process.on \warning -> source(\warning) @, &
  process.on \rejectionHandled -> source(\rejectionHandled) @, &
  process.on \uncaughtException -> source(\uncaughtException) @, &
  process.on \unhandledRejection -> source(\unhandledRejection) @, &
  process.on \disconnect -> source(\disconnected) @, &
  process.on \beforeExit -> source(\beforeExit) @, &
  process.on \exit -> source(\exit) @, &

  spawned.stdout.on \data -> source('process stdout') @, &
  spawned.stderr.on \data -> source('process stderr') @, &

  spawned.on \message -> source('process message') @, &
  spawned.on \disconnect -> source('process disconnect') @, &
  spawned.on \error -> source('process error') @, &
  spawned.on \close -> source('process close') @, &
  spawned.on \exit -> source('process exit') @, &

  spawned

global.main = main
