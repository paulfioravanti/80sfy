module VideoPlayer.Update exposing (Context, Msgs, update)

import Animation
import Error
import Gif
import Json.Encode as Encode
import Ports
import RemoteData
import Tasks
import VideoPlayer.Model as Model exposing (VideoPlayer, VideoPlayerId)
import VideoPlayer.Msg as Msg exposing (Msg)
import VideoPlayer.Ports as Ports
import VideoPlayer.Status as Status


type alias Context a =
    { a
        | videoPlayer1 : VideoPlayer
        , videoPlayer2 : VideoPlayer
    }


type alias Msgs msgs msg =
    { msgs
        | generateRandomTagMsg : VideoPlayerId -> msg
    }


update :
    Msgs msgs msg
    -> Msg
    -> Context a
    -> ( VideoPlayer, VideoPlayer, Cmd msg )
update { generateRandomTagMsg } msg { videoPlayer1, videoPlayer2 } =
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
                        ( False, videoPlayer1.id, 0 )

                    else
                        ( True, videoPlayer2.id, 1 )

                animateToNewOpacity =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.opacity opacity ]
                        ]
                        videoPlayer1.style

                performRandomTagGenerationForHiddenVideoPlayer =
                    Tasks.performRandomTagGeneration
                        (generateRandomTagMsg nowHiddenVideoPlayerId)
            in
            ( { videoPlayer1
                | style = animateToNewOpacity
                , visible = newVideoPlayer1Visibility
              }
            , videoPlayer2
            , performRandomTagGenerationForHiddenVideoPlayer
            )

        Msg.RandomGifUrlFetched videoPlayerId (Ok url) ->
            let
                gifUrl =
                    RemoteData.Success (Gif.url url)
            in
            if videoPlayerId == videoPlayer1.id then
                ( { videoPlayer1 | gifUrl = gifUrl }
                , videoPlayer2
                , Cmd.none
                )

            else
                ( videoPlayer1
                , { videoPlayer2 | gifUrl = gifUrl }
                , Cmd.none
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
            ( videoPlayer1, videoPlayer2, Ports.log message )

        Msg.HaltVideos ->
            ( videoPlayer1, videoPlayer2, Ports.haltVideos )

        Msg.PauseVideos ->
            ( videoPlayer1, videoPlayer2, Ports.pauseVideos )

        Msg.PlayVideos ->
            ( videoPlayer1, videoPlayer2, Ports.playVideos )

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
