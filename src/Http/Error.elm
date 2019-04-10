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

        Http.BadStatus response ->
            "BadStatus: " ++ String.fromInt response.status.code

        Http.BadPayload payload response ->
            "BadPayload: "
                ++ String.fromInt response.status.code
                ++ " "
                ++ payload
