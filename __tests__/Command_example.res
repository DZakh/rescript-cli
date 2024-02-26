module App = {
  let build = (~args as _) => ()
}

module Console = {
  let log = _ => ()
}

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
