module AudioPlayer exposing (AudioPlayer, Msg, init, update)

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


update : Msg -> AudioPlayer -> ( AudioPlayer, Cmd Msg )
update msg audioPlayer =
    Update.update msg audioPlayer
