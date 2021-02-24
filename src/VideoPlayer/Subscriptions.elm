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
    { audioPlayerRawId : String
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
                context.audioPlayerRawId
                videoPlayer1.status

        handleVideosPaused () =
            Msg.videosPaused videoPlayerMsg

        handleVideosPlaying () =
            Msg.videosPlaying videoPlayerMsg
    in
    Sub.batch
        [ fetchNextGif
        , videosHalted_
        , windowEvent
        , videosPaused handleVideosPaused
        , videosPlaying handleVideosPlaying
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
    let
        handleVideosHalted () =
            Msg.videosHalted videoPlayerMsg
    in
    if (status == Status.playing) && not overrideInactivityPause then
        videosHalted handleVideosHalted

    else
        Sub.none


windowEventSubscription : Msgs msgs msg -> String -> Status -> Sub msg
windowEventSubscription { videoPlayerMsg, noOpMsg } audioPlayerRawId status =
    let
        -- NOTE: If the document target has "blurred" from the video player
        -- to the SoundCloud iframe, then the Elm app does not need to
        -- consider this a "real" blur for purposes of displaying the
        -- "Gifs Paused" overlay.
        handleWindowBlurred activeElementIdFlag =
            if audioPlayerActive activeElementIdFlag audioPlayerRawId then
                noOpMsg

            else
                Msg.haltVideos videoPlayerMsg

        handleWindowFocused () =
            Msg.playVideos videoPlayerMsg
    in
    if status == Status.playing then
        windowBlurred handleWindowBlurred

    else if status == Status.halted then
        windowFocused handleWindowFocused

    else
        Sub.none


audioPlayerActive : Value -> String -> Bool
audioPlayerActive activeElementIdFlag audioPlayerRawId =
    let
        activeElementId =
            Value.extractStringWithDefault "" activeElementIdFlag
    in
    activeElementId == audioPlayerRawId
