// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Js_exn = require("rescript/lib/js/js_exn.js");
var Process = require("process");

function make(definer) {
  var commands = {};
  var commandStrings = [];
  definer({
        command: (function (string, tag) {
            if (commands[string] !== (void 0)) {
              Js_exn.raiseError("Command \"" + string + "\" is already registered.");
            }
            commandStrings.push(string);
            var tmp = string === "" ? [] : string.split(" ");
            commands[string] = {
              string: string,
              parts: tmp,
              tag: tag
            };
          })
      });
  return {
          commands: commands,
          commandStrings: commandStrings
        };
}

function getProcessArgs() {
  return Process.argv.slice(2);
}

function parse(builder, args) {
  var matchingCommandRef;
  for(var idx = 0 ,idx_finish = builder.commandStrings.length; idx < idx_finish; ++idx){
    var commandString = builder.commandStrings[idx];
    var command = builder.commands[commandString];
    var partsLength = command.parts.length;
    if (args.length >= partsLength) {
      var isMatching = command.parts.every(function (part, index) {
            return part === args[index];
          });
      if (isMatching) {
        var matchingCommand = matchingCommandRef;
        if (!(matchingCommand !== undefined && matchingCommand.parts.length > partsLength)) {
          matchingCommandRef = command;
        }
        
      }
      
    }
    
  }
  var matchingCommand$1 = matchingCommandRef;
  if (matchingCommand$1 !== undefined) {
    return {
            TAG: "Ok",
            _0: [
              matchingCommand$1,
              args.slice(matchingCommand$1.parts.length)
            ]
          };
  } else {
    return {
            TAG: "Error",
            _0: undefined
          };
  }
}

exports.make = make;
exports.getProcessArgs = getProcessArgs;
exports.parse = parse;
/* process Not a pure module */