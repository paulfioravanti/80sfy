module AudioPlayer
    exposing
        ( AudioPlayer
        , Msg
        , init
        , toggleMuteMsg
        , togglePlayPauseMsg
        , update
        )

import AudioPlayer.Config exposing (Config)
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


toggleMuteMsg : Msg
toggleMuteMsg =
    Msg.ToggleMute


togglePlayPauseMsg : Msg
togglePlayPauseMsg =
    Msg.TogglePlayPause


update : Config msg -> Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update config msg audioPlayer =
    ( Update.updateModel msg audioPlayer
    , Update.updateCmd config msg audioPlayer
    )
