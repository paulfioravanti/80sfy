port module AudioPlayer
    exposing
        ( AudioPlayer
        , init
        , adjustVolume
        , toggleFullScreen
        , toggleMute
        , togglePlayPause
        )

import AudioPlayer.Model as Model exposing (AudioPlayer)


port toggleFullScreen : () -> Cmd msg


type alias AudioPlayer =
    Model.AudioPlayer


init : AudioPlayer
init =
    Model.init


adjustVolume : String -> AudioPlayer -> AudioPlayer
adjustVolume volume audioPlayer =
    { audioPlayer | muted = False, volume = volume }


toggleMute : AudioPlayer -> AudioPlayer
toggleMute audioPlayer =
    { audioPlayer | muted = not audioPlayer.muted }


togglePlayPause : AudioPlayer -> AudioPlayer
togglePlayPause audioPlayer =
    { audioPlayer | playing = not audioPlayer.playing }
