module VideoPlayer.Update exposing (update)

import Animation
import Config
import Config.Msg exposing (Msg(GenerateRandomGif))
import Gif
import MsgConfig exposing (MsgConfig)
import RemoteData exposing (RemoteData(Success))
import Task
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Msg
    exposing
        ( Msg
            ( AnimateVideoPlayer
            , CrossFadePlayers
            , FetchRandomGif
            , ToggleFullScreen
            , TogglePlaying
            )
        )
import VideoPlayer.Ports as Ports


update :
    MsgConfig msg
    -> VideoPlayer.Msg.Msg
    -> VideoPlayer
    -> VideoPlayer
    -> ( VideoPlayer, VideoPlayer, Cmd msg )
update msgConfig msg videoPlayer1 videoPlayer2 =
    case msg of
        AnimateVideoPlayer msg ->
            ( { videoPlayer1 | style = Animation.update msg videoPlayer1.style }
            , videoPlayer2
            , Cmd.none
            )

        CrossFadePlayers time ->
            let
                ( newVideoPlayer1Visibility, nowHiddenVideoPlayerId ) =
                    if videoPlayer1.visible then
                        ( False, "1" )
                    else
                        ( True, "2" )

                newOpacity =
                    if videoPlayer1.visible then
                        0
                    else
                        1

                animateToNewOpacity =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.opacity newOpacity ]
                        ]
                        videoPlayer1.style
            in
                ( { videoPlayer1
                    | style = animateToNewOpacity
                    , visible = newVideoPlayer1Visibility
                  }
                , videoPlayer2
                , Task.succeed nowHiddenVideoPlayerId
                    |> Task.perform (msgConfig.configMsg << GenerateRandomGif)
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
