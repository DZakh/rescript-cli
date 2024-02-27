open Ava

type command = Root | Help | HelpLint | Lint

test("Api", t => {
  let builder = RescriptCliBuilder.make(ctx => {
    ctx.command("", Root)
    ctx.command("help", Help)
    ctx.command("help lint", HelpLint)
    ctx.command("lint", Lint)
  })

  t->Assert.deepEqual(
    builder->RescriptCliBuilder.parse([]),
    Ok(({parts: [], string: "", tag: Root}, [])),
    (),
  )
  t->Assert.deepEqual(
    builder->RescriptCliBuilder.parse([""]),
    Ok(({parts: [], string: "", tag: Root}, [""])),
    (),
  )
  t->Assert.deepEqual(
    builder->RescriptCliBuilder.parse(["help"]),
    Ok(({parts: ["help"], string: "help", tag: Help}, [])),
    (),
  )
  t->Assert.deepEqual(
    builder->RescriptCliBuilder.parse(["lint"]),
    Ok(({parts: ["lint"], string: "lint", tag: Lint}, [])),
    (),
  )
  t->Assert.deepEqual(
    builder->RescriptCliBuilder.parse(["help", "lint"]),
    Ok(({parts: ["help", "lint"], string: "help lint", tag: HelpLint}, [])),
    (),
  )
  t->Assert.deepEqual(
    builder->RescriptCliBuilder.parse(["help lint"]),
    Ok(({parts: [], string: "", tag: Root}, ["help lint"])),
    (),
  )
  t->Assert.deepEqual(
    builder->RescriptCliBuilder.parse(["lint", "help"]),
    Ok(({parts: ["lint"], string: "lint", tag: Lint}, ["help"])),
    (),
  )
  t->Assert.deepEqual(
    builder->RescriptCliBuilder.parse(["lint help"]),
    Ok(({parts: [], string: "", tag: Root}, ["lint help"])),
    (),
  )
})
