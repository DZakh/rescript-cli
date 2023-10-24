type command<'tag> = {string: string, parts: array<string>, tag: 'tag}

type program<'tag> = {commands: Js.Dict.t<command<'tag>>, commandStrings: array<string>}

type ctx<'tag> = {register: (string, 'tag) => unit}

let program: (ctx<'tag> => unit) => program<'tag>

let parse: (program<'tag>, ~args: array<string>=?) => result<(command<'tag>, array<string>), unit>
