module Nyaa.Firebase.Auth where

import Prelude

import Control.Promise (Promise)
import Data.Nullable (Nullable)
import Effect (Effect)
import Effect.Uncurried (EffectFn1)

type User =
  { displayName :: Nullable String
  , email :: Nullable String
  , emailVerified :: Boolean
  , isAnonymous :: Boolean
  , phoneNumber :: Nullable String
  , photoUrl :: Nullable String
  , providerId :: String
  , tenantId :: Nullable String
  , uid :: String
  }

type AuthCredential =
  { accessToken :: String
  , authorizationCode :: String
  , idToken :: String
  , nonce :: String
  , providerId :: String
  , secret :: String
  }

type SignInResult =
  { user :: Nullable User
  , credential :: Nullable AuthCredential
  }

foreign import getCurrentUser :: Effect (Promise (Nullable User))
foreign import signInWithApple :: Effect (Promise SignInResult)
foreign import signInWithGoogle :: Effect (Promise SignInResult)
foreign import signInWithPlayGames :: Effect (Promise SignInResult)
foreign import listenToAuthStateChange :: EffectFn1 { user :: Nullable User } Unit -> Effect (Effect Unit)