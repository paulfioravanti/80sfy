port module AudioPlayer.Ports
    exposing
        ( initAudioPlayer
        , nextTrack
        , pauseAudio
        , playAudio
        , setVolume
        )


port initAudioPlayer : Int -> Cmd msg


port nextTrack : () -> Cmd msg


port pauseAudio : () -> Cmd msg


port playAudio : () -> Cmd msg


port setVolume : Int -> Cmd msg
