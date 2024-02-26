# ⚙️ Tools to work with CLI in ReScript

Provides following modules under the `RescriptCli` namespace:

- [`Command`](#command) - Helps to build command line application with multiple commands the easy way. Inspired by [commist](https://github.com/mcollina/commist).
- TBD

## Install

```sh
npm install rescript-cli
```

Then add `rescript-cli` to `bs-dependencies` in your `rescript.json`:

```diff
{
  ...
+ "bs-dependencies": ["rescript-cli"],
}
```

## `Command`

```rescript
let program = Command.program(ctx => {
  ctx.register("version", #version)
  ctx.register("help", #help)
  ctx.register("help build", #helpBuild)
  ctx.register("build", #build)
})

switch program->Command.parse {
| Ok({tag: #build}, args) => App.build(~args)
| Ok({tag: #version}, _) => Console.log("1.0.0")
| Ok({tag: #help}, _)
| Ok({tag: #helpBuild}, _) =>
  Console.log("Read documentation!")
| Error() => Console.log("Unknown command")
}
```
