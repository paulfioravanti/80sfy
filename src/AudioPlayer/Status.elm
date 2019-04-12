module AudioPlayer.Status exposing (Status(..), isMuted, isPlaying, toString)


type Status
    = Playing
    | Paused
    | Muted Status


isMuted : Status -> Bool
isMuted status =
    case status of
        Muted _ ->
            True

        _ ->
            False


isPlaying : Status -> Bool
isPlaying status =
    case status of
        Playing ->
            True

        Muted Playing ->
            True

        _ ->
            False


toString : Status -> String
toString status =
    case status of
        Playing ->
            "Playing"

        Paused ->
            "Paused"

        Muted status_ ->
            "Muted " ++ toString status_
