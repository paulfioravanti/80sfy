module VideoPlayer.Model exposing (VideoPlayer, VideoPlayerId)

import Animation exposing (State)
import RemoteData exposing (WebData)


type alias VideoPlayerId =
    String


type alias VideoPlayer =
    { gifUrl : WebData String
    , id : VideoPlayerId
    , style : State
    , visible : Bool
    , zIndex : Int
    }
