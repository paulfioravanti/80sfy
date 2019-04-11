module Http.Error exposing (toString)

import Http exposing (Error)


toString : Error -> String
toString error =
    case error of
        Http.BadUrl string ->
            "BadUrl: " ++ string

        Http.Timeout ->
            "Timeout"

        Http.NetworkError ->
            "NetworkError"

        Http.BadStatus statusCode ->
            "BadStatus: " ++ String.fromInt statusCode

        Http.BadBody response ->
            "BadBody: " ++ response
