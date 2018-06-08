module Msg exposing (Msg(..))

import AudioPlayer
import Animation
import Config.Msg
import Http exposing (Error)
import SecretConfig.Msg
import Time exposing (Time)
import VideoPlayer.Msg


type Msg
    = AnimateControlPanel Animation.Msg
    | AnimateVideoPlayer Animation.Msg
    | AudioPlayerMsg AudioPlayer.Msg
    | ConfigMsg Config.Msg.Msg
    | CountdownToHideControlPanel Time
    | CrossFadePlayers Time
    | FetchRandomGif String (Result Error String)
    | FetchTags (Result Error (List String))
    | HideControlPanel ()
    | InitSecretConfigTags (List String)
    | RandomTag String String
    | SaveConfig String String
    | SecretConfigMsg SecretConfig.Msg.Msg
    | ShowControlPanel
    | ToggleFullScreen
    | TogglePlaying Bool
    | UseControlPanel Bool
    | VideoPlayerMsg VideoPlayer.Msg.Msg
