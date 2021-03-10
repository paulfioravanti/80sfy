module VideoPlayer.Update exposing (Context, update)

import Animation
import Gif
import Port
import RemoteData
import Tag exposing (Tag)
import VideoPlayer.Model as Model exposing (VideoPlayer, VideoPlayerId)
import VideoPlayer.Msg as Msg exposing (Msg)
import VideoPlayer.Status as Status


type alias Context a =
    { a
        | videoPlayer1 : VideoPlayer
        , videoPlayer2 : VideoPlayer
    }


update :
    (VideoPlayerId -> Tag -> msg)
    -> List Tag
    -> Msg
    -> Context a
    -> ( VideoPlayer, VideoPlayer, Cmd msg )
update randomTagGeneratedMsg tags msg { videoPlayer1, videoPlayer2 } =
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

                generateRandomTagForHiddenVideoPlayer videoPlayerId =
                    -- Tasks.performRandomTagGeneration
                    --     (generateRandomTagMsg nowHiddenVideoPlayerId)
                    Tag.generateRandomTag
                        (randomTagGeneratedMsg videoPlayerId)
                        tags
            in
            ( { videoPlayer1
                | style = animateToNewOpacity
                , visible = newVideoPlayer1Visibility
              }
            , videoPlayer2
            , generateRandomTagForHiddenVideoPlayer nowHiddenVideoPlayerId
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
                    "fetchRandomGifUrl Failed for " ++ videoPlayerRawId
            in
            ( videoPlayer1, videoPlayer2, Port.logError message error )

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
