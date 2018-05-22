module Msg exposing (Msg(..))

import Animation
import Http exposing (Error)
import Player exposing (Player, PlayerId)
import Time exposing (Time)


type Msg
    = Animate Animation.Msg
    | CrossFade PlayerId PlayerId Time
    | GetNextGif PlayerId
    | GetRandomGif PlayerId (Result Error String)
    | RandomTag PlayerId String
