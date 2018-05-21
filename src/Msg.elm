module Msg exposing (Msg(..))

import Animation
import Http exposing (Error)
import Player exposing (Player)
import Time exposing (Time)


type Msg
    = GetRandomGif Player (Result Error String)
    | GetNextGif Time
    | RandomTag Player String
    | NoOp
    | Animate Animation.Msg
    | FadeOutFadeIn ()
