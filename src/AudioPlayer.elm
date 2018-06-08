module AudioPlayer
    exposing
        ( AudioPlayer
        , Msg
        , init
        , adjustVolumeMsg
        , toggleMuteMsg
        , togglePlayPauseMsg
        , update
        )

import AudioPlayer.Model as Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg
import AudioPlayer.Update as Update


type alias AudioPlayer =
    Model.AudioPlayer


type alias Msg =
    Msg.Msg


init : AudioPlayer
init =
    Model.init


adjustVolumeMsg : String -> Msg
adjustVolumeMsg =
    Msg.AdjustVolume


toggleMuteMsg : Msg
toggleMuteMsg =
    Msg.ToggleMute


togglePlayPauseMsg : Msg
togglePlayPauseMsg =
    Msg.TogglePlayPause


update : Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update msg audioPlayer =
    Update.update msg audioPlayer
