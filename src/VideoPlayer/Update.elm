module VideoPlayer.Update exposing (update)

import Animation
import RemoteData exposing (RemoteData(Success))
import Task
import VideoPlayer.Model exposing (Status(Playing, Paused, Halted), VideoPlayer)
import VideoPlayer.Msg
    exposing
        ( Msg
            ( AnimateVideoPlayer
            , CrossFadePlayers
            , FetchRandomGif
            , HaltVideos
            , PauseVideos
            , PlayVideos
            , ToggleFullScreen
            )
        )
import VideoPlayer.Ports as Ports


update :
    (String -> msg)
    -> Msg
    -> VideoPlayer
    -> VideoPlayer
    -> ( VideoPlayer, VideoPlayer, Cmd msg )
update generateRandomGifMsg msg videoPlayer1 videoPlayer2 =
    case msg of
        AnimateVideoPlayer animationMsg ->
            ( { videoPlayer1
                | style = Animation.update animationMsg videoPlayer1.style
              }
            , videoPlayer2
            , Cmd.none
            )

        -- unused variable is `time`
        CrossFadePlayers _ ->
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
                    |> Task.perform generateRandomGifMsg
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

        HaltVideos () ->
            ( { videoPlayer1 | status = Halted }
            , { videoPlayer2 | status = Halted }
            , Ports.pauseVideos ()
            )

        PauseVideos () ->
            ( { videoPlayer1 | status = Paused }
            , { videoPlayer2 | status = Paused }
            , Ports.pauseVideos ()
            )

        PlayVideos () ->
            ( { videoPlayer1 | status = Playing }
            , { videoPlayer2 | status = Playing }
            , Ports.playVideos ()
            )

        ToggleFullScreen ->
            ( videoPlayer1, videoPlayer2, Ports.toggleFullScreen () )
