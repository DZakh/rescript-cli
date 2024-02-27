type command<'tag> = {string: string, parts: array<string>, tag: 'tag}

type t<'tag> = {commands: Js.Dict.t<command<'tag>>, commandStrings: array<string>}

type ctx<'tag> = {command: (string, 'tag) => unit}

let make: (ctx<'tag> => unit) => t<'tag>

let getProcessArgs: unit => array<string>

let parse: (t<'tag>, array<string>) => result<(command<'tag>, array<string>), unit>
