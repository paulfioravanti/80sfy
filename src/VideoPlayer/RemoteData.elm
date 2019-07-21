module VideoPlayer.RemoteData exposing (toString)

import Error
import RemoteData exposing (WebData)


toString : WebData String -> String
toString webData =
    case webData of
        RemoteData.NotAsked ->
            "NotAsked"

        RemoteData.Loading ->
            "Loading"

        RemoteData.Failure error ->
            "Failure: " ++ Error.toString error

        RemoteData.Success data ->
            data
