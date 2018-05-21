module Msg exposing (Msg(..))

import Animation
import Http exposing (Error)
import Player exposing (Player, Id)
import Time exposing (Time)


type Msg
    = GetRandomGif Player (Result Error String)
    | GetNextGif Player Player Time
    | RandomTag Player String
    | NoOp
    | Animate Animation.Msg
    | CrossFade ( Id, Id )
