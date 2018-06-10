module AudioPlayer
    exposing
        ( AudioPlayer
        , Msg
        , init
        , initAudioPlayer
        , adjustVolumeMsg
        , nextTrackMsg
        , pauseAudioMsg
        , playAudioMsg
        , toggleMuteMsg
        , update
        )

import AudioPlayer.Model as Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg
import AudioPlayer.Ports as Ports
import AudioPlayer.Update as Update


type alias AudioPlayer =
    Model.AudioPlayer


type alias Msg =
    Msg.Msg


init : String -> AudioPlayer
init soundCloudPlaylistUrl =
    Model.init soundCloudPlaylistUrl


adjustVolumeMsg : String -> Msg
adjustVolumeMsg =
    Msg.AdjustVolume


initAudioPlayer : Int -> Cmd msg
initAudioPlayer volume =
    Ports.initAudioPlayer volume


nextTrackMsg : Msg
nextTrackMsg =
    Msg.NextTrack


pauseAudioMsg : Msg
pauseAudioMsg =
    Msg.PauseAudio


playAudioMsg : Msg
playAudioMsg =
    Msg.PlayAudio


toggleMuteMsg : Msg
toggleMuteMsg =
    Msg.ToggleMute


update : Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update msg audioPlayer =
    Update.update msg audioPlayer
