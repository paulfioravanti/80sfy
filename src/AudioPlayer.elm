module AudioPlayer exposing (AudioPlayer, init, togglePlayPause)


type alias AudioPlayer =
    { playing : Bool }


init : AudioPlayer
init =
    { playing = False }


togglePlayPause : AudioPlayer -> AudioPlayer
togglePlayPause audioPlayer =
    { audioPlayer | playing = not audioPlayer.playing }
