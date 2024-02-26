open Ava

type command = Root | Help | HelpLint | Lint

test("Api", t => {
  let program = Command.program(ctx => {
    ctx.register("", Root)
    ctx.register("help", Help)
    ctx.register("help lint", HelpLint)
    ctx.register("lint", Lint)
  })

  t->Assert.deepEqual(
    program->Command.parse(~args=[]),
    Ok(({parts: [], string: "", tag: Root}, [])),
    (),
  )
  t->Assert.deepEqual(
    program->Command.parse(~args=[""]),
    Ok(({parts: [], string: "", tag: Root}, [""])),
    (),
  )
  t->Assert.deepEqual(
    program->Command.parse(~args=["help"]),
    Ok(({parts: ["help"], string: "help", tag: Help}, [])),
    (),
  )
  t->Assert.deepEqual(
    program->Command.parse(~args=["lint"]),
    Ok(({parts: ["lint"], string: "lint", tag: Lint}, [])),
    (),
  )
  t->Assert.deepEqual(
    program->Command.parse(~args=["help", "lint"]),
    Ok(({parts: ["help", "lint"], string: "help lint", tag: HelpLint}, [])),
    (),
  )
  t->Assert.deepEqual(
    program->Command.parse(~args=["help lint"]),
    Ok(({parts: [], string: "", tag: Root}, ["help lint"])),
    (),
  )
  t->Assert.deepEqual(
    program->Command.parse(~args=["lint", "help"]),
    Ok(({parts: ["lint"], string: "lint", tag: Lint}, ["help"])),
    (),
  )
  t->Assert.deepEqual(
    program->Command.parse(~args=["lint help"]),
    Ok(({parts: [], string: "", tag: Root}, ["lint help"])),
    (),
  )
})
