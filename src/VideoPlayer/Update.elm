module VideoPlayer.Update exposing (update)

import Animation
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Msg
    exposing
        ( Msg
            ( AnimateVideoPlayer
            , ToggleFullScreen
            , TogglePlaying
            )
        )
import VideoPlayer.Ports as Ports


update :
    Msg
    -> VideoPlayer
    -> VideoPlayer
    -> ( VideoPlayer, VideoPlayer, Cmd Msg )
update msg videoPlayer1 videoPlayer2 =
    case msg of
        AnimateVideoPlayer msg ->
            ( { videoPlayer1 | style = Animation.update msg videoPlayer1.style }
            , videoPlayer2
            , Cmd.none
            )

        ToggleFullScreen ->
            ( videoPlayer1, videoPlayer2, Ports.toggleFullScreen () )

        TogglePlaying bool ->
            ( { videoPlayer1 | playing = bool }
            , { videoPlayer2 | playing = bool }
            , Ports.toggleVideoPlay bool
            )
