module Nyaa.Custom.Pages.BackQuest where

import Prelude

import Effect (Effect)
import Nyaa.Custom.Builders.QuestPage (questPage)

backQuest :: Effect Unit
backQuest = questPage
  { name: "back-quest"
  , title: "Unlock Back!"
  , showFriend: true
  , battleRoute: "/newb-level"
  }