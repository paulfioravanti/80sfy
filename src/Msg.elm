module Msg exposing (Msg(..))

import Animation
import Http exposing (Error)
import Player exposing (Player, PlayerId)
import Time exposing (Time)


type Msg
    = Animate Animation.Msg
    | CountdownToHideControlPanel Time
    | CrossFadePlayers Time
    | GetNextGif Player
    | GetRandomGif PlayerId (Result Error String)
    | HideControlPanel ()
    | RandomTag Player String
    | ShowControlPanel
    | UseControlPanel Bool
