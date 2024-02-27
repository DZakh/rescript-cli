# ⚙️ Tools to work with CLI in ReScript

Provides following modules under the `RescriptCli` namespace:

- [`Command`](#command) - Helps to build command line application with multiple commands the easy way. Inspired by [commist](https://github.com/mcollina/commist).
- TBD

## Install

```sh
npm install rescript-cli-builder
```

Then add `rescript-cli-builder` to `bs-dependencies` in your `rescript.json`:

```diff
{
  ...
+ "bs-dependencies": ["rescript-cli-builder"],
}
```

## `Command`

```rescript
let builder = RescriptCliBuilder.make(ctx => {
  ctx.command("version", #version)
  ctx.command("help", #help)
  ctx.command("help build", #helpBuild)
  ctx.command("build", #build)
})

switch builder->RescriptCliBuilder.parse(RescriptCliBuilder.getProcessArgs()) {
| Ok({tag: #build}, args) => App.build(~args)
| Ok({tag: #version}, _) => Console.log("1.0.0")
| Ok({tag: #help}, _)
| Ok({tag: #helpBuild}, _) =>
  Console.log("Read documentation!")
| Error() => Console.log("Unknown command")
}
```
