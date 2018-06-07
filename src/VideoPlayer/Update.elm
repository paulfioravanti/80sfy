module VideoPlayer.Update exposing (update)

import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Msg exposing (Msg(TogglePlaying))
import VideoPlayer.Ports as Ports


update :
    Msg
    -> VideoPlayer
    -> VideoPlayer
    -> ( VideoPlayer, VideoPlayer, Cmd Msg )
update msg videoPlayer1 videoPlayer2 =
    case msg of
        TogglePlaying bool ->
            ( { videoPlayer1 | playing = bool }
            , { videoPlayer2 | playing = bool }
            , Ports.toggleVideoPlay bool
            )
