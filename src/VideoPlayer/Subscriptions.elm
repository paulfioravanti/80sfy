port module VideoPlayer.Subscriptions exposing (subscriptions)

import Animation
import MsgRouter exposing (MsgRouter)
import Time exposing (second)
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Msg
    exposing
        ( Msg
            ( AnimateVideoPlayer
            , CrossFadePlayers
            , HaltVideos
            , PlayVideos
            )
        )


port restartVideos : (() -> msg) -> Sub msg


port haltVideos : (() -> msg) -> Sub msg


subscriptions : MsgRouter msg -> VideoPlayer -> Sub msg
subscriptions { videoPlayerMsg } videoPlayer1 =
    let
        fetchNextGifSubscription =
            if videoPlayer1.playing && videoPlayer1.fetchNextGif then
                Time.every (4 * second) (videoPlayerMsg << CrossFadePlayers)
            else
                Sub.none

        videoPlaySubscription =
            if videoPlayer1.playing then
                restartVideos (\() -> (videoPlayerMsg (PlayVideos ())))
            else
                Sub.none
    in
        Sub.batch
            [ fetchNextGifSubscription
            , videoPlaySubscription
            , haltVideos (\() -> (videoPlayerMsg (HaltVideos ())))
            , Animation.subscription
                (videoPlayerMsg << AnimateVideoPlayer)
                [ videoPlayer1.style ]
            ]
