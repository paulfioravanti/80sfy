module VideoPlayer.Subscriptions exposing (subscriptions)

import Animation
import MsgConfig exposing (MsgConfig)
import Time exposing (second)
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Msg exposing (Msg(AnimateVideoPlayer, CrossFadePlayers))


subscriptions : MsgConfig msg -> Bool -> VideoPlayer -> Sub msg
subscriptions { videoPlayerMsg } fetchNextGif videoPlayer1 =
    let
        fetchNextGifSubscription =
            if fetchNextGif then
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
