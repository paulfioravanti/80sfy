module VideoPlayer.Update exposing (update)

import Animation
import RemoteData exposing (RemoteData(Success))
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Msg
    exposing
        ( Msg
            ( AnimateVideoPlayer
            , FetchRandomGif
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

        FetchRandomGif videoPlayerId (Ok url) ->
            let
                cmd =
                    Cmd.none

                gifUrl =
                    Success url
            in
                if videoPlayerId == "1" then
                    ( { videoPlayer1 | gifUrl = gifUrl }
                    , videoPlayer2
                    , cmd
                    )
                else
                    ( videoPlayer1
                    , { videoPlayer2 | gifUrl = gifUrl }
                    , cmd
                    )

        FetchRandomGif videoPlayerId (Err error) ->
            let
                _ =
                    Debug.log
                        ("FetchRandomGif Failed for " ++ toString videoPlayerId)
                        error
            in
                ( videoPlayer1, videoPlayer2, Cmd.none )

        ToggleFullScreen ->
            ( videoPlayer1, videoPlayer2, Ports.toggleFullScreen () )

        TogglePlaying bool ->
            ( { videoPlayer1 | playing = bool }
            , { videoPlayer2 | playing = bool }
            , Ports.toggleVideoPlay bool
            )
