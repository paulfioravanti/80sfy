port module AudioPlayer.Ports exposing
    ( nextTrack
    , pauseAudio
    , playAudio
    , setVolume
    , skipToTrack
    )


port nextTrack : () -> Cmd msg


port pauseAudio : () -> Cmd msg


port playAudio : () -> Cmd msg


port setVolume : Int -> Cmd msg


port skipToTrack : Int -> Cmd msg
