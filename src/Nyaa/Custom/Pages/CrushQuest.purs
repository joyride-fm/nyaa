module Nyaa.Custom.Pages.CrushQuest where

import Prelude

import Deku.Attributes (klass_)
import Deku.Control (text_)
import Deku.DOM as D
import Effect (Effect)
import Effect.Ref as Ref
import Nyaa.Custom.Builders.QuestPage (questPage)
import Nyaa.Types.BattleRoute (BattleRoute(..))
import Ocarina.WebAPI (AudioContext)

crushQuest :: { audioContextRef :: Ref.Ref AudioContext } -> Effect Unit
crushQuest { audioContextRef } = questPage
  { name: "crush-quest"
  , title: "Unlock Crush!"
  , showFriend: true
  , explainer:
      [ text_
          "Through diligent work and forking over two bucks, you've ascended to the level of the Gods. Score over 40,000 points on LVL.99 to unlock the"
      , D.span (klass_ "font-bold") [ text_ "Crush" ]
      , text_ " effect. Good luck... you'll be needing it..."
      ]
  , audioContextRef
  , battleRoute: DeityLevel
  }