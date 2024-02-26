// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Ava = require("ava").default;
var Command$RescriptCli = require("../src/Command.bs.js");

Ava("registering a command", (function (t) {
        var program = Command$RescriptCli.program(function (ctx) {
              ctx.register("hello", "Hello");
            });
        t.deepEqual(Command$RescriptCli.parse(program, [
                  "hello",
                  "a",
                  "-x",
                  "23"
                ]), {
              TAG: "Ok",
              _0: [
                {
                  string: "hello",
                  parts: ["hello"],
                  tag: "Hello"
                },
                [
                  "a",
                  "-x",
                  "23"
                ]
              ]
            }, undefined);
      }));

Ava("registering two commands", (function (t) {
        var program = Command$RescriptCli.program(function (ctx) {
              ctx.register("hello", "Hello");
              ctx.register("world", "World");
            });
        t.deepEqual(Command$RescriptCli.parse(program, [
                  "world",
                  "a",
                  "-x",
                  "23"
                ]), {
              TAG: "Ok",
              _0: [
                {
                  string: "world",
                  parts: ["world"],
                  tag: "World"
                },
                [
                  "a",
                  "-x",
                  "23"
                ]
              ]
            }, undefined);
      }));

Ava("registering two commands (bis)", (function (t) {
        var program = Command$RescriptCli.program(function (ctx) {
              ctx.register("hello", "Hello");
              ctx.register("world", "World");
            });
        t.deepEqual(Command$RescriptCli.parse(program, [
                  "hello",
                  "a",
                  "-x",
                  "23"
                ]), {
              TAG: "Ok",
              _0: [
                {
                  string: "hello",
                  parts: ["hello"],
                  tag: "Hello"
                },
                [
                  "a",
                  "-x",
                  "23"
                ]
              ]
            }, undefined);
      }));

Ava("registering two words commands", (function (t) {
        var program = Command$RescriptCli.program(function (ctx) {
              ctx.register("hello", "Hello");
              ctx.register("hello world", "HelloWorld");
            });
        t.deepEqual(Command$RescriptCli.parse(program, [
                  "hello",
                  "world",
                  "a",
                  "-x",
                  "23"
                ]), {
              TAG: "Ok",
              _0: [
                {
                  string: "hello world",
                  parts: [
                    "hello",
                    "world"
                  ],
                  tag: "HelloWorld"
                },
                [
                  "a",
                  "-x",
                  "23"
                ]
              ]
            }, undefined);
      }));

Ava("registering two words commands (bis)", (function (t) {
        var program = Command$RescriptCli.program(function (ctx) {
              ctx.register("hello", "Hello");
              ctx.register("hello world", "HelloWorld");
            });
        t.deepEqual(Command$RescriptCli.parse(program, [
                  "hello",
                  "a",
                  "-x",
                  "23"
                ]), {
              TAG: "Ok",
              _0: [
                {
                  string: "hello",
                  parts: ["hello"],
                  tag: "Hello"
                },
                [
                  "a",
                  "-x",
                  "23"
                ]
              ]
            }, undefined);
      }));

Ava("registering ambiguous commands throws exception", (function (t) {
        t.throws((function () {
                Command$RescriptCli.program(function (ctx) {
                      ctx.register("hello", "Hello");
                      ctx.register("hello world", "HelloWorld");
                      ctx.register("hello world matteo", "HelloWorldMatteo");
                      ctx.register("hello world", "HelloWorld");
                    });
              }), {
              message: "Command \"hello world\" is already registered."
            }, undefined);
      }));

/*  Not a pure module */