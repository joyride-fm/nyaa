module Nyaa.Custom.Builders.QuestPage where

import Prelude

import Data.Foldable (oneOf)
import Deku.Attribute ((!:=))
import Deku.Attributes (klass_)
import Deku.Control (text_)
import Deku.DOM as D
import Deku.Listeners (click_)
import Effect (Effect)
import Effect.Ref as Ref
import Nyaa.Audio (refreshAudioContext)
import Nyaa.Ionic.Attributes as I
import Nyaa.Ionic.BackButton (ionBackButton)
import Nyaa.Ionic.Button (ionButton)
import Nyaa.Ionic.Buttons (ionButtons)
import Nyaa.Ionic.Content (ionContent)
import Nyaa.Ionic.Custom (customComponent_)
import Nyaa.Ionic.Header (ionHeader)
import Nyaa.Ionic.Title (ionTitle_)
import Nyaa.Ionic.Toolbar (ionToolbar_)
import Nyaa.Types.BattleRoute (BattleRoute, battleRouteToPath)
import Ocarina.WebAPI (AudioContext)

questPage
  :: { name :: String
     , title :: String
     , showFriend :: Boolean
     , battleRoute :: BattleRoute
     , audioContextRef :: Ref.Ref AudioContext
     }
  -> Effect Unit
questPage = protoQuestPage false

tutorialQuestPage
  :: { name :: String
     , title :: String
     , showFriend :: Boolean
     , battleRoute :: BattleRoute
     , audioContextRef :: Ref.Ref AudioContext
     }
  -> Effect Unit
tutorialQuestPage = protoQuestPage true

protoQuestPage
  :: Boolean
  -> { name :: String
     , title :: String
     , showFriend :: Boolean
     , battleRoute :: BattleRoute
     , audioContextRef :: Ref.Ref AudioContext
     }
  -> Effect Unit
protoQuestPage _ i = customComponent_ i.name {} \_ ->
  [ ionHeader (oneOf [ I.Translucent !:= true ])
      [ ionToolbar_
          [ ionButtons (oneOf [ I.Slot !:= "start" ])
              [ ionBackButton (oneOf [ I.DefaultHref !:= "/" ]) []
              ]
          , ionTitle_ [ text_ i.title ]
          ]
      ]
  , ionContent (oneOf [ I.Fullscren !:= true ])
      [ D.div
          ( oneOf
              [ klass_
                  "bg-beach bg-no-repeat bg-cover bg-center w-full h-full grid grid-cols-7 grid-rows-3"
              ]
          )
          [ D.div (klass_ "row-start-2 col-start-2 row-span-1 col-span-3")
              ( [ ionButton
                    ( oneOf
                        [ D.Href !:= battleRouteToPath i.battleRoute
                        , click_ do
                            refreshAudioContext i.audioContextRef
                        ]
                    )
                    [ text_ "Start the battle"
                    ]
                ]
              -- for now we hide showing friends
              --   <> guard i.showFriend
              --     [ ionButton_ [ text_ "Battle a friend" ] ]
              )
          ]
      ]
  ]
