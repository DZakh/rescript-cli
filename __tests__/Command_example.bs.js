// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Command$RescriptCli = require("../src/Command.bs.js");

function build(param) {
  
}

var App = {
  build: build
};

function log(param) {
  
}

var Console = {
  log: log
};

var program = Command$RescriptCli.program(function (ctx) {
      ctx.register("version", "version");
      ctx.register("help", "help");
      ctx.register("help build", "helpBuild");
      ctx.register("build", "build");
    });

var match = Command$RescriptCli.parse(program, undefined);

exports.App = App;
exports.Console = Console;
exports.program = program;
/* program Not a pure module */