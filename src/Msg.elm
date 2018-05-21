module Msg exposing (Msg(..))

import Animation
import Http exposing (Error)
import Player exposing (Player, Id)
import Time exposing (Time)


type Msg
    = GetRandomGif Id (Result Error String)
    | GetNextGif Id
    | RandomTag Id String
    | NoOp
    | Animate Animation.Msg
    | CrossFade Id Id Time
