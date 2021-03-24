module VideoPlayer.Update exposing (Context, update)

import Gif exposing (GifUrl)
import Ports
import RemoteData
import VideoPlayer.Animation as Animation
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Msg as Msg exposing (Msg)
import VideoPlayer.Status as Status
import VideoPlayer.VideoPlayerId as VideoPlayerId


type alias Context a =
    { a
        | videoPlayer1 : VideoPlayer
        , videoPlayer2 : VideoPlayer
    }


update : Msg -> Context a -> ( VideoPlayer, VideoPlayer, Cmd msg )
update msg { videoPlayer1, videoPlayer2 } =
    case msg of
        Msg.AnimateVideoPlayer animationMsg ->
            ( { videoPlayer1
                | style = Animation.update animationMsg videoPlayer1.style
              }
            , videoPlayer2
            , Cmd.none
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
