module VideoPlayer.Update exposing (Context, update)

import Animation
import Error
import Json.Encode as Encode
import Ports
import RemoteData
import Task_
import VideoPlayer.Model as Model exposing (VideoPlayer, VideoPlayerId)
import VideoPlayer.Msg as Msg exposing (Msg)
import VideoPlayer.Ports as Ports
import VideoPlayer.Status as Status


type alias Context a =
    { a
        | videoPlayer1 : VideoPlayer
        , videoPlayer2 : VideoPlayer
    }


update :
    (VideoPlayerId -> msg)
    -> Msg
    -> Context a
    -> ( VideoPlayer, VideoPlayer, Cmd msg )
update generateRandomGifMsg msg { videoPlayer1, videoPlayer2 } =
    case msg of
        Msg.AnimateVideoPlayer animationMsg ->
            ( { videoPlayer1
                | style = Animation.update animationMsg videoPlayer1.style
              }
            , videoPlayer2
            , Cmd.none
            )

        -- unused variable is `time`
        Msg.CrossFadePlayers _ ->
            let
                ( newVideoPlayer1Visibility, nowHiddenVideoPlayerId, opacity ) =
                    if videoPlayer1.visible then
                        ( False, Model.wrappedId "1", 0 )

                    else
                        ( True, Model.wrappedId "2", 1 )

                animateToNewOpacity =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.opacity opacity ]
                        ]
                        videoPlayer1.style

                generateRandomGifForHiddenVideoPlayer =
                    Task_.generateRandomGif
                        (generateRandomGifMsg nowHiddenVideoPlayerId)
            in
            ( { videoPlayer1
                | style = animateToNewOpacity
                , visible = newVideoPlayer1Visibility
              }
            , videoPlayer2
            , generateRandomGifForHiddenVideoPlayer
            )

        Msg.RandomGifUrlFetched videoPlayerId (Ok url) ->
            let
                cmd =
                    Cmd.none

                gifUrl =
                    RemoteData.Success url

                videoPlayerRawId =
                    Model.rawId videoPlayerId
            in
            if videoPlayerRawId == "1" then
                ( { videoPlayer1 | gifUrl = gifUrl }
                , videoPlayer2
                , cmd
                )

            else
                ( videoPlayer1
                , { videoPlayer2 | gifUrl = gifUrl }
                , cmd
                )

        Msg.RandomGifUrlFetched videoPlayerId (Err error) ->
            let
                videoPlayerRawId =
                    Model.rawId videoPlayerId

                message =
                    Encode.object
                        [ ( "fetchRandomGifUrl Failed for " ++ videoPlayerRawId
                          , Encode.string (Error.toString error)
                          )
                        ]
            in
            ( videoPlayer1, videoPlayer2, Ports.consoleLog message )

        Msg.HaltVideos ->
            ( videoPlayer1, videoPlayer2, Ports.haltVideos () )

        Msg.PauseVideos ->
            ( videoPlayer1, videoPlayer2, Ports.pauseVideos () )

        Msg.PlayVideos ->
            ( videoPlayer1, videoPlayer2, Ports.playVideos () )

        Msg.VideosHalted ->
            ( { videoPlayer1 | status = Status.halted }
            , { videoPlayer2 | status = Status.halted }
            , Cmd.none
            )

        Msg.VideosPaused ->
            ( { videoPlayer1 | status = Status.paused }
            , { videoPlayer2 | status = Status.paused }
            , Cmd.none
            )

        Msg.VideosPlaying ->
            ( { videoPlayer1 | status = Status.playing }
            , { videoPlayer2 | status = Status.playing }
            , Cmd.none
            )
