module AudioPlayer exposing (AudioPlayer, init, adjustVolume, togglePlayPause)


type alias AudioPlayer =
    { playing : Bool
    , volume : String
    }


init : AudioPlayer
init =
    { playing = False
    , volume = "80"
    }


adjustVolume : String -> AudioPlayer -> AudioPlayer
adjustVolume volume audioPlayer =
    { audioPlayer | volume = volume }


togglePlayPause : AudioPlayer -> AudioPlayer
togglePlayPause audioPlayer =
    { audioPlayer | playing = not audioPlayer.playing }
