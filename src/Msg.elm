module Msg exposing (Msg(..))

import Animation
import Http exposing (Error)
import VideoPlayer exposing (VideoPlayerId)
import Time exposing (Time)


type Msg
    = AdjustVolume String
    | Animate Animation.Msg
    | CountdownToHideControlPanel Time
    | CrossFadePlayers Time
    | FetchNextGif VideoPlayerId
    | FetchRandomGif VideoPlayerId (Result Error String)
    | FetchTags (Result Error (List String))
    | HideControlPanel ()
    | RandomTag VideoPlayerId String
    | SaveConfig
    | ShowControlPanel
    | ToggleFullScreen
    | ToggleInactivityPause
    | ToggleMute
    | TogglePlayPause
    | ToggleSecretConfigVisibility
    | UpdateSecretConfigSoundCloudPlaylistUrl String
    | UpdateSecretConfigTags String
    | UseControlPanel Bool
