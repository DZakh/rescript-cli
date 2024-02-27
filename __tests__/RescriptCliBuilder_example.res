module App = {
  let build = (~args as _) => ()
}

module Console = {
  let log = _ => ()
}

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
