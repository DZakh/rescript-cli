open Ava

test("registering a command", t => {
  let program = Command.program(ctx => {
    ctx.register("hello", #Hello)
  })

  t->Assert.deepEqual(
    program->Command.parse(~args=["hello", "a", "-x", "23"]),
    Ok(({parts: ["hello"], string: "hello", tag: #Hello}, ["a", "-x", "23"])),
    (),
  )
})

test("registering two commands", t => {
  let program = Command.program(ctx => {
    ctx.register("hello", #Hello)
    ctx.register("world", #World)
  })

  t->Assert.deepEqual(
    program->Command.parse(~args=["world", "a", "-x", "23"]),
    Ok(({parts: ["world"], string: "world", tag: #World}, ["a", "-x", "23"])),
    (),
  )
})

test("registering two commands (bis)", t => {
  let program = Command.program(ctx => {
    ctx.register("hello", #Hello)
    ctx.register("world", #World)
  })

  t->Assert.deepEqual(
    program->Command.parse(~args=["hello", "a", "-x", "23"]),
    Ok(({parts: ["hello"], string: "hello", tag: #Hello}, ["a", "-x", "23"])),
    (),
  )
})

test("registering two words commands", t => {
  let program = Command.program(ctx => {
    ctx.register("hello", #Hello)
    ctx.register("hello world", #HelloWorld)
  })

  t->Assert.deepEqual(
    program->Command.parse(~args=["hello", "world", "a", "-x", "23"]),
    Ok(({parts: ["hello", "world"], string: "hello world", tag: #HelloWorld}, ["a", "-x", "23"])),
    (),
  )
})

test("registering two words commands (bis)", t => {
  let program = Command.program(ctx => {
    ctx.register("hello", #Hello)
    ctx.register("hello world", #HelloWorld)
  })

  t->Assert.deepEqual(
    program->Command.parse(~args=["hello", "a", "-x", "23"]),
    Ok(({parts: ["hello"], string: "hello", tag: #Hello}, ["a", "-x", "23"])),
    (),
  )
})

test("registering ambiguous commands throws exception", t => {
  t->Assert.throws(() => {
    let _ = Command.program(
      ctx => {
        ctx.register("hello", #Hello)
        ctx.register("hello world", #HelloWorld)
        ctx.register("hello world matteo", #HelloWorldMatteo)
        ctx.register("hello world", #HelloWorld)
      },
    )
  }, ~expectations={message: `Command "hello world" is already registered.`}, ())
})

// Not supported. TODO: Investigate
// test('looking up commands', function (t) {
//   const program = commist()

//   function noop1 () {}
//   function noop2 () {}
//   function noop3 () {}

//   program.register('hello', noop1)
//   program.register('hello world matteo', noop3)
//   program.register('hello world', noop2)

//   t.equal(program.lookup('hello')[0].func, noop1)
//   t.equal(program.lookup('hello world matteo')[0].func, noop3)
//   t.equal(program.lookup('hello world')[0].func, noop2)

//   t.end()
// })

// Not supported. TODO: Investigate
// test('looking up commands with abbreviations', function (t) {
//   const program = commist()

//   function noop1 () {}
//   function noop2 () {}
//   function noop3 () {}

//   program.register('hello', noop1)
//   program.register('hello world matteo', noop3)
//   program.register('hello world', noop2)

//   t.equal(program.lookup('hel')[0].func, noop1)
//   t.equal(program.lookup('hel wor mat')[0].func, noop3)
//   t.equal(program.lookup('hel wor')[0].func, noop2)

//   t.end()
// })

// Not supported. TODO: Investigate
// test('looking up strict commands', function (t) {
//   const program = commist()

//   function noop1 () {}
//   function noop2 () {}

//   program.register({ command: 'restore', strict: true }, noop1)
//   program.register({ command: 'rest', strict: true }, noop2)

//   t.equal(program.lookup('restore')[0].func, noop1)
//   t.equal(program.lookup('rest')[0].func, noop2)
//   t.equal(program.lookup('remove')[0], undefined)

//   t.end()
// })

// Not supported. TODO: Investigate
// test('executing commands from abbreviations', function (t) {
//   t.plan(1)

//   const program = commist()

//   program.register('hello', function (args) {
//     t.deepEqual(args, ['a', '-x', '23'])
//   })

//   program.register('hello world', function (args) {
//     t.ok(false, 'must pick the right command')
//   })

//   program.parse(['hel', 'a', '-x', '23'])
// })

// TODO: Investigate
// test('one char command', function (t) {
//   const program = commist()

//   function noop1 () {}

//   program.register('h', noop1)
//   t.equal(program.lookup('h')[0].func, noop1)

//   t.end()
// })

// TODO: Investigate
// test('two char command', function (t) {
//   const program = commist()

//   function noop1 () {}

//   program.register('he', noop1)
//   t.equal(program.lookup('he')[0].func, noop1)

//   t.end()
// })

// TODO: Investigate
// test('a command part must be at least 3 chars', function (t) {
//   const program = commist()

//   function noop1 () {}

//   program.register('h b', noop1)

//   t.equal(program.lookup('h b')[0].func, noop1)

//   t.end()
// })

// TODO: Investigate
// test('short commands match exactly', function (t) {
//   const program = commist()

//   function noop1 () {}
//   function noop2 () {}

//   program.register('h', noop1)
//   program.register('help', noop2)

//   t.equal(program.lookup('h')[0].func, noop1)
//   t.equal(program.lookup('he')[0].func, noop2)
//   t.equal(program.lookup('hel')[0].func, noop2)
//   t.equal(program.lookup('help')[0].func, noop2)

//   t.end()
// })

// TODO: Investigate
// test('leven', function (t) {
//   t.is(leven('a', 'b'), 1)
//   t.is(leven('ab', 'ac'), 1)
//   t.is(leven('ac', 'bc'), 1)
//   t.is(leven('abc', 'axc'), 1)
//   t.is(leven('kitten', 'sitting'), 3)
//   t.is(leven('xabxcdxxefxgx', '1ab2cd34ef5g6'), 6)
//   t.is(leven('cat', 'cow'), 2)
//   t.is(leven('xabxcdxxefxgx', 'abcdefg'), 6)
//   t.is(leven('javawasneat', 'scalaisgreat'), 7)
//   t.is(leven('example', 'samples'), 3)
//   t.is(leven('sturgeon', 'urgently'), 6)
//   t.is(leven('levenshtein', 'frankenstein'), 6)
//   t.is(leven('distance', 'difference'), 5)
//   t.is(leven('因為我是中國人所以我會說中文', '因為我是英國人所以我會說英文'), 2)
//   t.end()
// })

// TODO: Investigate
// test('max distance', function (t) {
//   const program = commist({ maxDistance: 2 })

//   function noop1 () {}
//   function noop2 () {}
//   function noop3 () {}

//   program.register('hello', noop1)
//   program.register('hello world matteo', noop3)
//   program.register('hello world', noop2)

//   t.equal(program.lookup('hel')[0].func, noop1)
//   t.equal(program.lookup('hel wor mat')[0].func, noop2)
//   t.equal(program.lookup('hello world matt')[0].func, noop3)
//   t.equal(program.lookup('hello wor')[0].func, noop2)
//   t.deepEqual(program.lookup('he wor'), [])

//   t.end()
// })

// TODO: Investigate
// test('help foobar vs start', function (t) {
//   const program = commist({ maxDistance: 2 })

//   function noop1 () {}
//   function noop2 () {}

//   program.register('help', noop1)
//   program.register('start', noop2)

//   t.equal(program.lookup('help')[0].func, noop1)
//   t.deepEqual(program.lookup('help foobar')[0].func, noop1)
//   t.equal(program.lookup('start')[0].func, noop2)

//   t.end()
// })

// TODO: Investigate
// test('registering a command with maxDistance', function (t) {
//   t.plan(2)

//   const program = commist({ maxDistance: 2 })

//   program.register('hello', function (args) {
//     t.deepEqual(args, ['a', '-x', '23'])
//   })

//   const result = program.parse(['hello', 'a', '-x', '23'])

//   t.notOk(result, 'must return null, the command have been handled')
// })
