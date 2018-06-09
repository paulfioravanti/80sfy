module AudioPlayer
    exposing
        ( AudioPlayer
        , Msg
        , init
        , initAudioPlayer
        , adjustVolumeMsg
        , toggleMuteMsg
        , togglePlayPauseMsg
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


initAudioPlayer : String -> Cmd msg
initAudioPlayer soundCloudClientId =
    Ports.initAudioPlayer soundCloudClientId


toggleMuteMsg : Msg
toggleMuteMsg =
    Msg.ToggleMute


togglePlayPauseMsg : Msg
togglePlayPauseMsg =
    Msg.TogglePlayPause


update : Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update msg audioPlayer =
    Update.update msg audioPlayer
