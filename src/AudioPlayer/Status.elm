module AudioPlayer.Status exposing
    ( Status
    , isMuted
    , isPlaying
    , mute
    , pause
    , paused
    , play
    , toString
    , unMute
    )


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


mute : Status -> Status
mute status =
    case status of
        Muted _ ->
            status

        _ ->
            Muted status


pause : Status -> Status
pause status =
    case status of
        Muted _ ->
            Muted Paused

        _ ->
            Paused


paused : Status
paused =
    Paused


play : Status -> Status
play status =
    case status of
        Muted _ ->
            Muted Playing

        _ ->
            Playing


toString : Status -> String
toString status =
    case status of
        Playing ->
            "Playing"

        Paused ->
            "Paused"

        Muted secondaryStatus ->
            "Muted " ++ toString secondaryStatus


unMute : Status -> Status
unMute status =
    case status of
        Muted status_ ->
            status_

        _ ->
            status
