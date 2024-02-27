module NodeJs = {
  module Process = {
    @module("process") external argv: array<string> = "argv"
  }
}

type command<'tag> = {string: string, parts: array<string>, tag: 'tag}

type t<'tag> = {commands: Js.Dict.t<command<'tag>>, commandStrings: array<string>}

type ctx<'tag> = {command: (string, 'tag) => unit}

let make = (definer: ctx<'tag> => unit): t<'tag> => {
  let commands = Js.Dict.empty()
  let commandStrings = []
  definer({
    command: (string, tag) => {
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

let getProcessArgs = () => {
  // TODO: Support electron out of the box
  NodeJs.Process.argv->Js.Array2.sliceFrom(2)
}

let parse = (builder: t<'command>, args) => {
  let matchingCommandRef = ref(None)
  for idx in 0 to builder.commandStrings->Array.length - 1 {
    let commandString = builder.commandStrings->Js.Array2.unsafe_get(idx)
    let command = builder.commands->Js.Dict.unsafeGet(commandString)
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
