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
            , PlayVideos
            , VideosHalted
            , VideosPaused
            , VideosPlaying
            )
        )


port videosHalted : (() -> msg) -> Sub msg


port videosPaused : (() -> msg) -> Sub msg


port videosPlaying : (() -> msg) -> Sub msg


subscriptions : MsgRouter msg -> Float -> Bool -> VideoPlayer -> Sub msg
subscriptions { videoPlayerMsg } gifDisplaySeconds overrideInactivityPause videoPlayer1 =
    let
        fetchNextGifSubscription =
            if videoPlayer1.status == Playing then
                Time.every
                    (gifDisplaySeconds * second)
                    (videoPlayerMsg << CrossFadePlayers)
            else
                Sub.none

        videosHaltedSubscription =
            if
                (videoPlayer1.status == Playing)
                    && not overrideInactivityPause
            then
                videosHalted (\() -> videoPlayerMsg VideosHalted)
            else
                Sub.none
    in
        Sub.batch
            [ fetchNextGifSubscription
            , videosHaltedSubscription
            , videosPaused (\() -> videoPlayerMsg VideosPaused)
            , videosPlaying (\() -> videoPlayerMsg VideosPlaying)
            , Animation.subscription
                (videoPlayerMsg << AnimateVideoPlayer)
                [ videoPlayer1.style ]
            ]
