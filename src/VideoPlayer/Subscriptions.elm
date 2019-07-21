port module VideoPlayer.Subscriptions exposing (Context, Msgs, subscriptions)

import Animation
import Json.Decode exposing (Value)
import Time
import Value
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Msg as Msg exposing (Msg)
import VideoPlayer.Status as Status exposing (Status)


port videosHalted : (() -> msg) -> Sub msg


port videosPaused : (() -> msg) -> Sub msg


port videosPlaying : (() -> msg) -> Sub msg


port windowBlurred : (Value -> msg) -> Sub msg


port windowFocused : (() -> msg) -> Sub msg


type alias Context =
    { audioPlayerId : String
    , gifDisplaySeconds : Float
    , overrideInactivityPause : Bool
    }


type alias Msgs msgs msg =
    { msgs
        | noOpMsg : msg
        , videoPlayerMsg : Msg -> msg
    }


subscriptions : Msgs msgs msg -> Context -> VideoPlayer -> Sub msg
subscriptions ({ videoPlayerMsg } as msgs) context videoPlayer1 =
    let
        fetchNextGif =
            fetchNextGifSubscription
                videoPlayerMsg
                videoPlayer1.status
                context.gifDisplaySeconds

        videosHalted_ =
            videosHaltedSubscription
                videoPlayerMsg
                videoPlayer1.status
                context.overrideInactivityPause

        windowEvent =
            windowEventSubscription
                msgs
                context.audioPlayerId
                videoPlayer1.status
    in
    Sub.batch
        [ fetchNextGif
        , videosHalted_
        , windowEvent
        , videosPaused (\() -> Msg.videosPaused videoPlayerMsg)
        , videosPlaying (\() -> Msg.videosPlaying videoPlayerMsg)
        , Animation.subscription
            (Msg.animateVideoPlayer videoPlayerMsg)
            [ videoPlayer1.style ]
        ]



-- PRIVATE


fetchNextGifSubscription : (Msg -> msg) -> Status -> Float -> Sub msg
fetchNextGifSubscription videoPlayerMsg status gifDisplaySeconds =
    if status == Status.playing then
        Time.every
            (gifDisplaySeconds * 1000)
            (Msg.crossFadePlayers videoPlayerMsg)

    else
        Sub.none


videosHaltedSubscription : (Msg -> msg) -> Status -> Bool -> Sub msg
videosHaltedSubscription videoPlayerMsg status overrideInactivityPause =
    if (status == Status.playing) && not overrideInactivityPause then
        videosHalted (\() -> Msg.videosHalted videoPlayerMsg)

    else
        Sub.none


windowEventSubscription : Msgs msgs msg -> String -> Status -> Sub msg
windowEventSubscription { videoPlayerMsg, noOpMsg } audioPlayerId status =
    if status == Status.playing then
        -- NOTE: If the document target has "blurred" from the video player
        -- to the SoundCloud iframe, then the Elm app does not need to
        -- consider this a "real" blur for purposes of displaying the
        -- "Gifs Paused" overlay.
        windowBlurred
            (\activeElementIdFlag ->
                if audioPlayerActive activeElementIdFlag audioPlayerId then
                    noOpMsg

                else
                    Msg.haltVideos videoPlayerMsg
            )

    else if status == Status.halted then
        windowFocused (\() -> Msg.playVideos videoPlayerMsg)

    else
        Sub.none


audioPlayerActive : Value -> String -> Bool
audioPlayerActive activeElementIdFlag audioPlayerId =
    let
        activeElementId =
            activeElementIdFlag
                |> Value.extractStringWithDefault ""
    in
    activeElementId == audioPlayerId
