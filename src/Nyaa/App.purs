module Nyaa.App where

import Prelude

import Data.Array as A
import Data.Filterable (filter)
import Data.Foldable (oneOf)
import Data.List (List(..), (:))
import Data.List as L
import Deku.Attribute ((!:=))
import Deku.Control (text_)
import Deku.Core (Domable, Nut)
import Deku.DOM as D
import Effect (Effect)
import Nyaa.Ionic.App (ionApp_)
import Nyaa.Ionic.Attributes as I
import Nyaa.Ionic.Content (ionContent)
import Nyaa.Ionic.Custom (customComponent)
import Nyaa.Ionic.Header (ionHeader)
import Nyaa.Ionic.Item (ionItem)
import Nyaa.Ionic.Label (ionLabel_)
import Nyaa.Ionic.List (ionList_)
import Nyaa.Ionic.Nav (ionNav_)
import Nyaa.Ionic.Route (ionRoute)
import Nyaa.Ionic.Router (ionRouter_)
import Nyaa.Ionic.Title (ionTitle_)
import Nyaa.Ionic.Toolbar (ionToolbar_)

-- Front page [Tutorial -> (Tutorial, Play)]
-- Tutorial quest
-- Tutorial
-- Lounge picker (after first quest is played)
-- Lounge 1 (requires sign in to unlock)
-- Game 1
-- Quest 1
-- Quest 2
-- Quest 3
-- Quest 4
-- Lounge 2
-- Game 2
-- Quest 5
-- Quest 6
-- Quest 7
-- Lounge 3
-- Game 3
-- Quest 8
-- Quest 9
-- End-of-game page (brag, continue)
-- Waiting to play (from quest)
-- Friends page (from quest)
-- Waiting to play with friend
-- Invited by friend
-- Invite accept & wait page
-- Invite reject page

basicPages :: Array String
basicPages =
  [ "story-book"
  , "intro-screen"
  , "dev-admin"
  , "tutorial-quest"
  , "hypersynthetic-quest"
  , "flat-quest"
  , "buzz-quest"
  , "glide-quest"
  , "back-quest"
  , "showmehow-quest"
  , "rotate-quest"
  , "hide-quest"
  , "dazzle-quest"
  , "lvlnn-quest"
  , "crush-quest"
  , "amplify-quest"
  , "newb-lounge"
  , "pro-lounge"
  , "deity-lounge"
  , "lounge-picker"
  , "profile-page"
  ]

levelPages :: Array String
levelPages =
  [ "tutorial-level"
  , "newb-level"
  , "pro-level"
  , "deity-level"
  ]

storybookCC :: Effect Unit
storybookCC = do
  customComponent "story-book" {} (pure unit) (pure unit) \_ -> do
    let
      basicEntries :: forall lock payload. Array (Domable lock payload)
      basicEntries = basicPages <#> \page ->
        ionItem (oneOf [ I.Button !:= true, D.Href !:= "/" <> page ])
          [ ionLabel_ [ D.h3_ [ text_ page ] ]
          ]
      levelEntries :: forall lock payload. Array (Domable lock payload)
      levelEntries = levelPages <#> \page ->
        ionItem (oneOf [ I.Button !:= true, D.Href !:= "/" <> page <> "/debug-room" ])
          [ ionLabel_ [ D.h3_ [ text_ page ] ]
          ]
    [ ionHeader (oneOf [ I.Translucent !:= true ])
        [ ionToolbar_
            [ ionTitle_ [ text_ "Storybook" ]
            ]
        ]
    , ionContent (oneOf [ I.Fullscren !:= true ])
        [ ionList_ $ basicEntries <> levelEntries ]
    ]

makeApp :: forall lock payload. Boolean -> String -> Domable lock payload
makeApp withAdmin homeIs = ionApp_
  [ ionRouter_
      ( [ ionRoute (oneOf [ I.Url !:= "/", I.Component !:= homeIs ])
            []
        ] <> basicIonRoutes <> levelIonRoutes

      )
  , ionNav_ []
  ]
  where
  basicIonRoutes :: Array (Domable lock payload)
  basicIonRoutes = basicRoutes <#> \page ->
    ionRoute (oneOf [ I.Url !:= "/" <> page, I.Component !:= page ]) []

  levelIonRoutes :: Array (Domable lock payload)
  levelIonRoutes = levelPages <#> \page ->
    ionRoute (oneOf [ I.Url !:= "/" <> page <> "/:roomId", I.Component !:= page ]) []

  basicRoutes :: Array String
  basicRoutes = (if withAdmin then identity else filter (_ /= "dev-admin")) basicPages

storybook :: Nut
storybook = makeApp true "story-book"

app :: forall lock payload. Domable lock payload
app = makeApp false "intro-screen"
