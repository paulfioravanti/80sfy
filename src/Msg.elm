module Msg exposing (Msg(..))

import Animation
import Http exposing (Error)
import VideoPlayer exposing (VideoPlayer, VideoPlayerId)
import Time exposing (Time)


type Msg
    = Animate Animation.Msg
    | CountdownToHideControlPanel Time
    | CrossFadePlayers Time
    | FetchRandomGif VideoPlayerId (Result Error String)
    | GetNextGif VideoPlayer
    | HideControlPanel ()
    | RandomTag VideoPlayer String
    | ShowControlPanel
    | UseControlPanel Bool
