open Ava

test("registering a command", t => {
  let builder = RescriptCliBuilder.make(ctx => {
    ctx.command("hello", #Hello)
  })

  t->Assert.deepEqual(
    builder->RescriptCliBuilder.parse(["hello", "a", "-x", "23"]),
    Ok(({parts: ["hello"], string: "hello", tag: #Hello}, ["a", "-x", "23"])),
    (),
  )
})

test("registering two commands", t => {
  let builder = RescriptCliBuilder.make(ctx => {
    ctx.command("hello", #Hello)
    ctx.command("world", #World)
  })

  t->Assert.deepEqual(
    builder->RescriptCliBuilder.parse(["world", "a", "-x", "23"]),
    Ok(({parts: ["world"], string: "world", tag: #World}, ["a", "-x", "23"])),
    (),
  )
})

test("registering two commands (bis)", t => {
  let builder = RescriptCliBuilder.make(ctx => {
    ctx.command("hello", #Hello)
    ctx.command("world", #World)
  })

  t->Assert.deepEqual(
    builder->RescriptCliBuilder.parse(["hello", "a", "-x", "23"]),
    Ok(({parts: ["hello"], string: "hello", tag: #Hello}, ["a", "-x", "23"])),
    (),
  )
})

test("registering two words commands", t => {
  let builder = RescriptCliBuilder.make(ctx => {
    ctx.command("hello", #Hello)
    ctx.command("hello world", #HelloWorld)
  })

  t->Assert.deepEqual(
    builder->RescriptCliBuilder.parse(["hello", "world", "a", "-x", "23"]),
    Ok(({parts: ["hello", "world"], string: "hello world", tag: #HelloWorld}, ["a", "-x", "23"])),
    (),
  )
})

test("registering two words commands (bis)", t => {
  let builder = RescriptCliBuilder.make(ctx => {
    ctx.command("hello", #Hello)
    ctx.command("hello world", #HelloWorld)
  })

  t->Assert.deepEqual(
    builder->RescriptCliBuilder.parse(["hello", "a", "-x", "23"]),
    Ok(({parts: ["hello"], string: "hello", tag: #Hello}, ["a", "-x", "23"])),
    (),
  )
})

test("registering ambiguous commands throws exception", t => {
  t->Assert.throws(() => {
    let _ = RescriptCliBuilder.make(
      ctx => {
        ctx.command("hello", #Hello)
        ctx.command("hello world", #HelloWorld)
        ctx.command("hello world matteo", #HelloWorldMatteo)
        ctx.command("hello world", #HelloWorld)
      },
    )
  }, ~expectations={message: `Command "hello world" is already registered.`}, ())
})

// Not supported. TODO: Investigate
// test('looking up commands', function (t) {
//   const builder = commist()

//   function noop1 () {}
//   function noop2 () {}
//   function noop3 () {}

//   builder.register('hello', noop1)
//   builder.register('hello world matteo', noop3)
//   builder.register('hello world', noop2)

//   t.equal(builder.lookup('hello')[0].func, noop1)
//   t.equal(builder.lookup('hello world matteo')[0].func, noop3)
//   t.equal(builder.lookup('hello world')[0].func, noop2)

//   t.end()
// })

// Not supported. TODO: Investigate
// test('looking up commands with abbreviations', function (t) {
//   const builder = commist()

//   function noop1 () {}
//   function noop2 () {}
//   function noop3 () {}

//   builder.register('hello', noop1)
//   builder.register('hello world matteo', noop3)
//   builder.register('hello world', noop2)

//   t.equal(builder.lookup('hel')[0].func, noop1)
//   t.equal(builder.lookup('hel wor mat')[0].func, noop3)
//   t.equal(builder.lookup('hel wor')[0].func, noop2)

//   t.end()
// })

// Not supported. TODO: Investigate
// test('looking up strict commands', function (t) {
//   const builder = commist()

//   function noop1 () {}
//   function noop2 () {}

//   builder.register({ command: 'restore', strict: true }, noop1)
//   builder.register({ command: 'rest', strict: true }, noop2)

//   t.equal(builder.lookup('restore')[0].func, noop1)
//   t.equal(builder.lookup('rest')[0].func, noop2)
//   t.equal(builder.lookup('remove')[0], undefined)

//   t.end()
// })

// Not supported. TODO: Investigate
// test('executing commands from abbreviations', function (t) {
//   t.plan(1)

//   const builder = commist()

//   builder.register('hello', function (args) {
//     t.deepEqual(args, ['a', '-x', '23'])
//   })

//   builder.register('hello world', function (args) {
//     t.ok(false, 'must pick the right command')
//   })

//   builder.parse(['hel', 'a', '-x', '23'])
// })

// TODO: Investigate
// test('one char command', function (t) {
//   const builder = commist()

//   function noop1 () {}

//   builder.register('h', noop1)
//   t.equal(builder.lookup('h')[0].func, noop1)

//   t.end()
// })

// TODO: Investigate
// test('two char command', function (t) {
//   const builder = commist()

//   function noop1 () {}

//   builder.register('he', noop1)
//   t.equal(builder.lookup('he')[0].func, noop1)

//   t.end()
// })

// TODO: Investigate
// test('a command part must be at least 3 chars', function (t) {
//   const builder = commist()

//   function noop1 () {}

//   builder.register('h b', noop1)

//   t.equal(builder.lookup('h b')[0].func, noop1)

//   t.end()
// })

// TODO: Investigate
// test('short commands match exactly', function (t) {
//   const builder = commist()

//   function noop1 () {}
//   function noop2 () {}

//   builder.register('h', noop1)
//   builder.register('help', noop2)

//   t.equal(builder.lookup('h')[0].func, noop1)
//   t.equal(builder.lookup('he')[0].func, noop2)
//   t.equal(builder.lookup('hel')[0].func, noop2)
//   t.equal(builder.lookup('help')[0].func, noop2)

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
//   const builder = commist({ maxDistance: 2 })

//   function noop1 () {}
//   function noop2 () {}
//   function noop3 () {}

//   builder.register('hello', noop1)
//   builder.register('hello world matteo', noop3)
//   builder.register('hello world', noop2)

//   t.equal(builder.lookup('hel')[0].func, noop1)
//   t.equal(builder.lookup('hel wor mat')[0].func, noop2)
//   t.equal(builder.lookup('hello world matt')[0].func, noop3)
//   t.equal(builder.lookup('hello wor')[0].func, noop2)
//   t.deepEqual(builder.lookup('he wor'), [])

//   t.end()
// })

// TODO: Investigate
// test('help foobar vs start', function (t) {
//   const builder = commist({ maxDistance: 2 })

//   function noop1 () {}
//   function noop2 () {}

//   builder.register('help', noop1)
//   builder.register('start', noop2)

//   t.equal(builder.lookup('help')[0].func, noop1)
//   t.deepEqual(builder.lookup('help foobar')[0].func, noop1)
//   t.equal(builder.lookup('start')[0].func, noop2)

//   t.end()
// })

// TODO: Investigate
// test('registering a command with maxDistance', function (t) {
//   t.plan(2)

//   const builder = commist({ maxDistance: 2 })

//   builder.register('hello', function (args) {
//     t.deepEqual(args, ['a', '-x', '23'])
//   })

//   const result = builder.parse(['hello', 'a', '-x', '23'])

//   t.notOk(result, 'must return null, the command have been handled')
// })
