module VideoPlayer.Model exposing
    ( Status(..)
    , VideoPlayer
    , gifUrlToString
    , init
    , statusToString
    )

import Animation exposing (State)
import Error
import RemoteData exposing (WebData)


type Status
    = Playing
    | Paused
    | Halted


type alias VideoPlayer =
    { fallbackGifUrl : String
    , gifUrl : WebData String
    , id : String
    , status : Status
    , style : State
    , visible : Bool
    , zIndex : Int
    }


init : String -> Int -> VideoPlayer
init id zIndex =
    { fallbackGifUrl = "/assets/tv-static.mp4"
    , gifUrl = RemoteData.NotRequested
    , id = id
    , status = Paused
    , style = Animation.style [ Animation.opacity 1 ]
    , visible = True
    , zIndex = zIndex
    }


gifUrlToString : WebData String -> String
gifUrlToString webData =
    case webData of
        RemoteData.NotRequested ->
            "NotRequested"

        RemoteData.Requesting ->
            "Requesting"

        RemoteData.Failure error ->
            "Failure: " ++ Error.toString error

        RemoteData.Success data ->
            data


statusToString : Status -> String
statusToString status =
    case status of
        Playing ->
            "Playing"

        Paused ->
            "Paused"

        Halted ->
            "Halted"
