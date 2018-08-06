port module AudioPlayer.Ports
    exposing
        ( initAudioPlayer
        , nextTrack
        , pauseAudio
        , playAudio
        , setVolume
        , skipToTrack
        )


port initAudioPlayer : ( Int, String ) -> Cmd msg


port nextTrack : () -> Cmd msg


port pauseAudio : () -> Cmd msg


port playAudio : () -> Cmd msg


port setVolume : Int -> Cmd msg


port skipToTrack : Int -> Cmd msg
