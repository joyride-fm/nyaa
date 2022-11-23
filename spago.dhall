{ name = "nyaa"
, dependencies =
  [ "aff"
  , "aff-promise"
  , "affjax"
  , "affjax-web"
  , "arraybuffer-types"
  , "arrays"
  , "bolson"
  , "console"
  , "control"
  , "datetime"
  , "debug"
  , "deku"
  , "effect"
  , "either"
  , "exceptions"
  , "exists"
  , "filterable"
  , "foldable-traversable"
  , "foreign"
  , "foreign-object"
  , "functions"
  , "http-methods"
  , "hyrule"
  , "integers"
  , "js-date"
  , "js-timers"
  , "maybe"
  , "newtype"
  , "now"
  , "nullable"
  , "ocarina"
  , "parallel"
  , "prelude"
  , "refs"
  , "routing"
  , "simple-json"
  , "st"
  , "transformers"
  , "tuples"
  , "unsafe-coerce"
  , "untagged-union"
  , "web-dom"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
