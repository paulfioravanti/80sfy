module AudioPlayer.Status exposing (Status(..), toString)


type Status
    = Playing
    | Paused
    | Muted Status


toString : Status -> String
toString status =
    case status of
        Playing ->
            "Playing"

        Paused ->
            "Paused"

        Muted status_ ->
            "Muted " ++ toString status_
