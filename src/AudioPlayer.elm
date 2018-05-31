port module AudioPlayer
    exposing
        ( AudioPlayer
        , init
        , adjustVolume
        , toggleFullScreen
        , toggleMute
        , togglePlayPause
        )


port toggleFullScreen : () -> Cmd msg


type alias AudioPlayer =
    { muted : Bool
    , playing : Bool
    , volume : String
    }


init : AudioPlayer
init =
    { muted = False
    , playing = False
    , volume = "80"
    }


adjustVolume : String -> AudioPlayer -> AudioPlayer
adjustVolume volume audioPlayer =
    { audioPlayer | muted = False, volume = volume }


toggleMute : AudioPlayer -> AudioPlayer
toggleMute audioPlayer =
    { audioPlayer | muted = not audioPlayer.muted }


togglePlayPause : AudioPlayer -> AudioPlayer
togglePlayPause audioPlayer =
    { audioPlayer | playing = not audioPlayer.playing }
