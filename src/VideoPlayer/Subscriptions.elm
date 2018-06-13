module VideoPlayer.Subscriptions exposing (subscriptions)

import Animation
import MsgRouter exposing (MsgRouter)
import Time exposing (second)
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Msg exposing (Msg(AnimateVideoPlayer, CrossFadePlayers))


subscriptions : MsgRouter msg -> VideoPlayer -> Sub msg
subscriptions { videoPlayerMsg } videoPlayer1 =
    let
        fetchNextGifSubscription =
            if videoPlayer1.playing then
                Time.every (4 * second) (videoPlayerMsg << CrossFadePlayers)
            else
                Sub.none
    in
        Sub.batch
            [ fetchNextGifSubscription
            , Animation.subscription
                (videoPlayerMsg << AnimateVideoPlayer)
                [ videoPlayer1.style ]
            ]
