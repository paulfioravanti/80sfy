module VideoPlayer.Status exposing (Status(..), toString)


type Status
    = Playing
    | Paused
    | Halted


toString : Status -> String
toString status =
    case status of
        Playing ->
            "Playing"

        Paused ->
            "Paused"

        Halted ->
            "Halted"
