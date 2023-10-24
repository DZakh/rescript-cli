open Ava

test("Tmp", t => {
  let program = Command.program(ctx => {
    ctx.register("", #Help)
    ctx.register("help", #Help)
    ctx.register("help lint", #HelpLint)
    ctx.register("lint", #Lint)
  })

  t->Assert.deepEqual(
    program->Command.parse(~args=[""]),
    Ok(({parts: [], string: "", tag: #Help}, [""])),
    (),
  )
  t->Assert.deepEqual(
    program->Command.parse(~args=["help"]),
    Ok(({parts: ["help"], string: "help", tag: #Help}, [])),
    (),
  )
  t->Assert.deepEqual(
    program->Command.parse(~args=["lint"]),
    Ok(({parts: ["lint"], string: "lint", tag: #Lint}, [])),
    (),
  )
  t->Assert.deepEqual(
    program->Command.parse(~args=["help lint"]),
    Ok(({parts: ["help", "lint"], string: "help lint", tag: #HelpLint}, [])),
    (),
  )
  t->Assert.deepEqual(
    program->Command.parse(~args=["lint help"]),
    Ok(({parts: ["lint"], string: "lint", tag: #Lint}, [])),
    (),
  )
  t->Assert.deepEqual(program->Command.parse(~args=["lins help"]), Error(), ())
})
