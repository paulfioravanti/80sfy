port module AudioPlayer.Ports exposing
    ( initAudioPlayer
    , nextTrack
    , pauseAudio
    , playAudio
    , setVolume
    , skipToTrack
    )

import AudioPlayer.Flags exposing (Flags)


port initAudioPlayer : Flags -> Cmd msg


port nextTrack : () -> Cmd msg


port pauseAudio : () -> Cmd msg


port playAudio : () -> Cmd msg


port setVolume : Int -> Cmd msg


port skipToTrack : Int -> Cmd msg
