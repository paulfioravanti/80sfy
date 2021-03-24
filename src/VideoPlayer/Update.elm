module VideoPlayer.Update exposing (Context, update)

import Gif exposing (GifUrl)
import Ports
import RemoteData
import Tag exposing (Tag)
import VideoPlayer.Animation as Animation exposing (AnimationState)
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Msg as Msg exposing (Msg)
import VideoPlayer.Status as Status
import VideoPlayer.VideoPlayerId as VideoPlayerId exposing (VideoPlayerId)


type alias Context a =
    { a
        | videoPlayer1 : VideoPlayer
        , videoPlayer2 : VideoPlayer
    }


update :
    Msg
    -> (VideoPlayerId -> Tag -> msg)
    -> List Tag
    -> Context a
    -> ( VideoPlayer, VideoPlayer, Cmd msg )
update msg randomTagGeneratedMsg tags { videoPlayer1, videoPlayer2 } =
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

                animateToNewOpacity : AnimationState
                animateToNewOpacity =
                    Animation.toOpacity opacity videoPlayer1.style

                generateRandomTagForHiddenVideoPlayer : Cmd msg
                generateRandomTagForHiddenVideoPlayer =
                    Tag.generateRandomTag
                        (randomTagGeneratedMsg nowHiddenVideoPlayerId)
                        tags
            in
            ( { videoPlayer1
                | style = animateToNewOpacity
                , visible = newVideoPlayer1Visibility
              }
            , videoPlayer2
            , generateRandomTagForHiddenVideoPlayer
            )

        Msg.RandomGifUrlFetched videoPlayerId (Ok url) ->
            let
                gifUrl : RemoteData.WebData GifUrl
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
                rawVideoPlayerId : String
                rawVideoPlayerId =
                    VideoPlayerId.rawId videoPlayerId

                message : String
                message =
                    "fetchRandomGifUrl Failed for " ++ rawVideoPlayerId
            in
            ( videoPlayer1, videoPlayer2, Ports.logError message error )

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
