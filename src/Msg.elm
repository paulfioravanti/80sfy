module Msg exposing (Msg(..))

import Animation
import Http exposing (Error)
import Player exposing (Player, PlayerId)
import Time exposing (Time)


type Msg
    = GetRandomGif PlayerId (Result Error String)
    | GetNextGif PlayerId
    | RandomTag PlayerId String
    | NoOp
    | Animate Animation.Msg
    | CrossFade PlayerId PlayerId Time
