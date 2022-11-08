module Nyaa.Custom.Pages.ProfilePage where


import Prelude

import Control.Plus (empty)
import Data.Foldable (oneOf)
import Deku.Attribute ((!:=))
import Deku.Attributes (klass_)
import Deku.Control (text_)
import Deku.DOM as D
import Effect (Effect)
import Nyaa.Ionic.Attributes as I
import Nyaa.Ionic.BackButton (ionBackButton)
import Nyaa.Ionic.Buttons (ionButtons)
import Nyaa.Ionic.Content (ionContent)
import Nyaa.Ionic.Custom (customComponent)
import Nyaa.Ionic.Header (ionHeader)
import Nyaa.Ionic.Title (ionTitle_)
import Nyaa.Ionic.Toolbar (ionToolbar_)

profilePage :: Effect Unit
profilePage = customComponent "profile-page" { } \_ -> [
    ionHeader (oneOf [I.Translucent !:= true ]) [
        ionToolbar_ [
            ionButtons (oneOf [I.Slot !:= "start" ]) [
                ionBackButton empty {-(oneOf [I.DefaultHref !:= "/" ])-} []
            ],
            ionTitle_ [text_ "Profile page"]
        ]
    ],
    ionContent (oneOf [klass_ "ion-padding", I.Fullscren !:= true]) [
      D.p_ [text_ "Oh hello."]
    ]
]