module Msg exposing (Msg(..))

import Animation
import Http exposing (Error)
import VideoPlayer exposing (VideoPlayerId)
import Time exposing (Time)


type Msg
    = Animate Animation.Msg
    | CountdownToHideControlPanel Time
    | CrossFadePlayers Time
    | FetchNextGif VideoPlayerId
    | FetchRandomGif VideoPlayerId (Result Error String)
    | HideControlPanel ()
    | RandomTag VideoPlayerId String
    | ShowControlPanel
    | UseControlPanel Bool
