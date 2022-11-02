{ name = "ocarina"
, dependencies =
  [ "aff"
  , "aff-promise"
  , "arraybuffer-types"
  , "arrays"
  , "bolson"
  , "control"
  , "convertable-options"
  , "debug"
  , "deku"
  , "effect"
  , "fast-vect"
  , "filterable"
  , "foldable-traversable"
  , "foreign"
  , "foreign-object"
  , "homogeneous"
  , "hyrule"
  , "integers"
  , "js-timers"
  , "lcg"
  , "lists"
  , "maybe"
  , "newtype"
  , "nullable"
  , "numbers"
  , "ordered-collections"
  , "prelude"
  , "profunctor"
  , "profunctor-lenses"
  , "quickcheck"
  , "refs"
  , "routing"
  , "routing-duplex"
  , "safe-coerce"
  , "simple-json"
  , "sized-vectors"
  , "st"
  , "tuples"
  , "type-equality"
  , "typelevel"
  , "typelevel-prelude"
  , "unsafe-coerce"
  , "unsafe-reference"
  , "variant"
  , "web-events"
  , "web-file"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
