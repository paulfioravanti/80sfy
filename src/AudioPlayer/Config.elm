module AudioPlayer.Config exposing (Config, init)

import AudioPlayer.Msg


type alias Config msg =
    { audioPlayerMsg : AudioPlayer.Msg.Msg -> msg
    , togglePlayingMsg : Bool -> msg
    }


init : (AudioPlayer.Msg.Msg -> msg) -> (Bool -> msg) -> Config msg
init audioPlayerMsg togglePlayingMsg =
    { audioPlayerMsg = audioPlayerMsg
    , togglePlayingMsg = togglePlayingMsg
    }
