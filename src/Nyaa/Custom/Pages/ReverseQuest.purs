module Nyaa.Custom.Pages.ReverseQuest where

import Prelude

import Effect (Effect)
import Nyaa.Custom.Builders.QuestPage (questPage)

reverseQuest :: Effect Unit
reverseQuest = questPage
  { name: "reverse-quest"
  , img: "bg-spacecat"
  , text: "Lorem ipsum"
  , next: pure unit
  }