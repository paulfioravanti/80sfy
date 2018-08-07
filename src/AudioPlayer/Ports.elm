port module AudioPlayer.Ports
    exposing
        ( InitAudioPlayerFlags
        , initAudioPlayer
        , nextTrack
        , pauseAudio
        , playAudio
        , setVolume
        , skipToTrack
        )


type alias InitAudioPlayerFlags =
    { id : String
    , volume : Int
    }


port initAudioPlayer : InitAudioPlayerFlags -> Cmd msg


port nextTrack : () -> Cmd msg


port pauseAudio : () -> Cmd msg


port playAudio : () -> Cmd msg


port setVolume : Int -> Cmd msg


port skipToTrack : Int -> Cmd msg
