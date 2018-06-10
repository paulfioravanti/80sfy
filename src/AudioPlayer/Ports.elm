port module AudioPlayer.Ports exposing (initAudioPlayer, pauseAudio, playAudio)


port initAudioPlayer : () -> Cmd msg


port pauseAudio : () -> Cmd msg


port playAudio : () -> Cmd msg
