module NodeJs = {
  module Process = {
    @module("process") external argv: array<string> = "argv"
  }
}

type command<'tag> = {string: string, parts: array<string>, tag: 'tag}

type program<'tag> = {commands: Js.Dict.t<command<'tag>>, commandStrings: array<string>}

type ctx<'tag> = {register: (string, 'tag) => unit}

let program = (definer: ctx<'tag> => unit): program<'tag> => {
  let commands = Js.Dict.empty()
  let commandStrings = []
  definer({
    register: (string, tag) => {
      if commands->Js.Dict.unsafeGet(string) !== %raw(`void 0`) {
        Js.Exn.raiseError(`Command "${string}" is already registered.`)
      }
      commandStrings->Js.Array2.push(string)->ignore
      commands->Js.Dict.set(
        string,
        {
          string,
          parts: switch string {
          | "" => []
          | _ => string->Js.String2.split(" ")
          },
          tag,
        },
      )
    },
  })
  {
    commands,
    commandStrings,
  }
}

let parse = (program: program<'command>, ~args as maybeArgs=?) => {
  let args = switch maybeArgs {
  | Some(args) => args
  // TODO: Support electron out of the box
  | None => NodeJs.Process.argv->Js.Array2.sliceFrom(2)
  }

  let matchingCommandRef = ref(None)
  for idx in 0 to program.commandStrings->Array.length - 1 {
    let commandString = program.commandStrings->Js.Array2.unsafe_get(idx)
    let command = program.commands->Js.Dict.unsafeGet(commandString)
    let partsLength = command.parts->Js.Array2.length
    if args->Js.Array2.length >= partsLength {
      let isMatching =
        command.parts->Js.Array2.everyi((part, index) => part === args->Js.Array2.unsafe_get(index))
      if isMatching {
        switch matchingCommandRef.contents {
        | Some(matchingCommand) if matchingCommand.parts->Js.Array2.length > partsLength => ()
        // TODO: Support equal lenght
        | _ => matchingCommandRef.contents = Some(command)
        }
      }
    }
  }

  switch matchingCommandRef.contents {
  | Some(matchingCommand) =>
    Ok(matchingCommand, args->Js.Array2.sliceFrom(matchingCommand.parts->Js.Array2.length))
  | None => Error()
  }
}
