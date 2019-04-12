module VideoPlayer.RemoteData exposing (toString)

import Error
import RemoteData exposing (WebData)


toString : WebData String -> String
toString webData =
    case webData of
        RemoteData.NotRequested ->
            "NotRequested"

        RemoteData.Requesting ->
            "Requesting"

        RemoteData.Failure error ->
            "Failure: " ++ Error.toString error

        RemoteData.Success data ->
            data
