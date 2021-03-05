port module VideoPlayer.Subscriptions exposing (Context, Msgs, subscriptions)

import Animation
import Gif exposing (GifDisplayIntervalSeconds)
import Json.Decode exposing (Value)
import PortMessage
import Time
import Value
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Msg as Msg exposing (Msg)
import VideoPlayer.Status as Status exposing (Status)


port videoPlayerIn : (Value -> msg) -> Sub msg


port videosHalted : (() -> msg) -> Sub msg


port videosPaused : (() -> msg) -> Sub msg


type alias Context =
    { audioPlayerRawId : String
    , gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
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
                context.gifDisplayIntervalSeconds

        videosHalted_ =
            videosHaltedSubscription
                videoPlayerMsg
                videoPlayer1.status
                context.overrideInactivityPause

        handleVideosPaused () =
            Msg.videosPaused videoPlayerMsg
    in
    Sub.batch
        [ fetchNextGif
        , videosHalted_
        , videosPaused handleVideosPaused
        , Animation.subscription
            (Msg.animateVideoPlayer videoPlayerMsg)
            [ videoPlayer1.style ]
        , videoPlayerIn (handlePortMessage msgs context videoPlayer1)
        ]



-- PRIVATE


handlePortMessage : Msgs msgs msg -> Context -> VideoPlayer -> Value -> msg
handlePortMessage ({ videoPlayerMsg, noOpMsg } as msgs) context videoPlayer1 portMessage =
    let
        { tag, payload } =
            PortMessage.decode portMessage
    in
    case tag of
        "VIDEOS_PLAYING" ->
            Msg.videosPlaying videoPlayerMsg

        "WINDOW_BLURRED" ->
            if videoPlayer1.status == Status.playing then
                handleWindowBlurred msgs context.audioPlayerRawId payload

            else
                noOpMsg

        "WINDOW_FOCUSED" ->
            if videoPlayer1.status == Status.halted then
                Msg.playVideos videoPlayerMsg

            else
                noOpMsg

        _ ->
            noOpMsg


fetchNextGifSubscription :
    (Msg -> msg)
    -> Status
    -> GifDisplayIntervalSeconds
    -> Sub msg
fetchNextGifSubscription videoPlayerMsg status gifDisplayIntervalSeconds =
    if status == Status.playing then
        let
            rawGifDisplayMilliSeconds =
                Gif.rawDisplayIntervalSeconds gifDisplayIntervalSeconds * 1000
        in
        Time.every
            rawGifDisplayMilliSeconds
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


handleWindowBlurred : Msgs msgs msg -> String -> Value -> msg
handleWindowBlurred { videoPlayerMsg, noOpMsg } audioPlayerRawId payload =
    let
        activeElementId =
            Value.extractStringWithDefault "" payload
    in
    -- NOTE: If the document target has "blurred" from the video player
    -- to the SoundCloud iframe, then the Elm app does not need to
    -- consider this a "real" blur for purposes of displaying the
    -- "Gifs Paused" overlay.
    if activeElementId == audioPlayerRawId then
        noOpMsg

    else
        Msg.haltVideos videoPlayerMsg
