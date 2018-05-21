module Msg exposing (Msg(..))

import Animation
import Http exposing (Error)
import Time exposing (Time)


type Msg
    = GetRandomGif (Result Error String)
    | GetNextGif Time
    | RandomTag String
    | NoOp
    | Animate Animation.Msg
    | FadeOutFadeIn ()
