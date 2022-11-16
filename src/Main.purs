module Main where

import Prelude

import Control.Promise (toAffE)
import Data.Compactable (compact)
import Data.Maybe (Maybe(..))
import Data.Nullable (toMaybe)
import Deku.Toplevel (runInBody)
import Effect (Effect)
import Effect.Aff (apathize, launchAff_)
import Effect.Class (liftEffect)
import Effect.Ref as Ref
import Effect.Uncurried (mkEffectFn1, runEffectFn1)
import FRP.Event (burning, createO)
import Nyaa.App (app, storybook, storybookCC)
import Nyaa.Assets (akiraURL)
import Nyaa.Audio (newAudioContext)
import Nyaa.Capacitor.Utils (Platform(..), getPlatform)
import Nyaa.Custom.Pages.AmplifyQuest (amplifyQuest)
import Nyaa.Custom.Pages.BackQuest (backQuest)
import Nyaa.Custom.Pages.CameraQuest (cameraQuest)
import Nyaa.Custom.Pages.CrushQuest (crushQuest)
import Nyaa.Custom.Pages.DazzleQuest (dazzleQuest)
import Nyaa.Custom.Pages.DeityLevel (deityLevel)
import Nyaa.Custom.Pages.DeityLounge (deityLounge)
import Nyaa.Custom.Pages.DevAdmin (devAdmin)
import Nyaa.Custom.Pages.EqualizeQuest (equalizeQuest)
import Nyaa.Custom.Pages.GlideQuest (glideQuest)
import Nyaa.Custom.Pages.HideQuest (hideQuest)
import Nyaa.Custom.Pages.IntroScreen (introScreen)
import Nyaa.Custom.Pages.LoungePicker (loungePicker)
import Nyaa.Custom.Pages.NewbLevel (newbLevel)
import Nyaa.Custom.Pages.NewbLounge (newbLounge)
import Nyaa.Custom.Pages.PathTest (pathTest)
import Nyaa.Custom.Pages.ProLevel (proLevel)
import Nyaa.Custom.Pages.ProLounge (proLounge)
import Nyaa.Custom.Pages.ProfilePage (profilePage)
import Nyaa.Custom.Pages.RotateQuest (rotateQuest)
import Nyaa.Custom.Pages.TutorialLevel (tutorialLevel)
import Nyaa.Custom.Pages.TutorialQuest (tutorialQuest)
import Nyaa.FRP.Dedup (dedup)
import Nyaa.Firebase.Firebase (getCurrentUser, listenToAuthStateChange, reactToNewUser, signInWithGameCenter, signInWithPlayGames)
import Nyaa.Fullscreen (androidFullScreen)
import Nyaa.Ionic.Loading (brackedWithLoading)
import Routing.Hash (getHash, setHash)

foreign import prod :: Effect Boolean

main :: Effect Unit
main = do
  -- isProd <- prod
  unsubProfileListener <- Ref.new (pure unit)
  authListener <- createO
  profileListener <- createO
  platform <- getPlatform
  -- authState <- burning { user: null } (dedup authListener.event)
  profileState <- burning { profile: Nothing }
    (dedup profileListener.event)
  audioContext <- newAudioContext
  launchAff_ do
    when (platform == Android) do
      toAffE androidFullScreen
    -- register components
    liftEffect do
      introScreen
        { profileState: profileState.event
        }
      tutorialQuest
      equalizeQuest
      cameraQuest
      glideQuest
      backQuest
      rotateQuest
      hideQuest
      dazzleQuest
      crushQuest
      amplifyQuest
      newbLounge
      proLounge
      deityLounge
      tutorialLevel { audioContext, audioUri: akiraURL }
      newbLevel { audioContext, audioUri: akiraURL }
      proLevel { audioContext, audioUri: akiraURL }
      deityLevel { audioContext, audioUri: akiraURL }
      loungePicker
      devAdmin { platform }
      pathTest
      profilePage
        { platform
        , clearProfile: runEffectFn1 profileListener.push { profile: Nothing }
        , profileState: compact $ map
            ( \x -> case x.profile of
                Just x -> Just { profile: x }
                Nothing -> Nothing
            )
            profileState.event
        }
    -- do this just for the init side effect
    -- isProd <- liftEffect prod
    -- unless isProd do
    --   toAffE useEmulator
    liftEffect do
      h <- getHash
      when (h == "") do
        setHash "/"
      if false then do
        runInBody app
      else do
        storybookCC
        runInBody storybook
      launchAff_ do
        cu <- liftEffect getCurrentUser
        liftEffect do
          runEffectFn1 authListener.push { user: cu }
          let profileF1 = mkEffectFn1 \{ profile } -> do
               runEffectFn1 profileListener.push { profile: Just profile }
          reactToNewUser
            { user: toMaybe cu
            , push: profileF1
            , unsubProfileListener
            }
          _ <- listenToAuthStateChange $ mkEffectFn1 \u -> do
            runEffectFn1 authListener.push { user: u }
            reactToNewUser
              { user: toMaybe u
              , push: profileF1
              , unsubProfileListener
              }
          pure unit
        apathize $ brackedWithLoading "Setting phasers on stun..." do
          case platform of
            IOS -> toAffE signInWithGameCenter
            Android -> toAffE signInWithPlayGames
            Web -> pure unit
      pure unit
