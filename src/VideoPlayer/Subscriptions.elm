port module VideoPlayer.Subscriptions exposing (subscriptions)

import Animation
import MsgRouter exposing (MsgRouter)
import Time exposing (second)
import VideoPlayer.Model exposing (Status(Playing, Halted), VideoPlayer)
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


subscriptions : MsgRouter msg -> Bool -> VideoPlayer -> Sub msg
subscriptions { videoPlayerMsg } overrideInactivityPause videoPlayer1 =
    let
        fetchNextGifSubscription =
            if videoPlayer1.status == Playing then
                Time.every (4 * second) (videoPlayerMsg << CrossFadePlayers)
            else
                Sub.none

        videoPlaySubscription =
            if videoPlayer1.status == Halted then
                restartVideos (\() -> videoPlayerMsg (PlayVideos ()))
            else
                Sub.none

        haltVideosSubscription =
            if
                (videoPlayer1.status == Playing)
                    && not overrideInactivityPause
            then
                haltVideos (\() -> videoPlayerMsg (HaltVideos ()))
            else
                Sub.none
    in
        Sub.batch
            [ fetchNextGifSubscription
            , videoPlaySubscription
            , haltVideosSubscription
            , Animation.subscription
                (videoPlayerMsg << AnimateVideoPlayer)
                [ videoPlayer1.style ]
            ]
