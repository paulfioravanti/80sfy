module VideoPlayer.Subscriptions exposing (Context, Msgs, subscriptions)

import Animation
import Gif exposing (GifDisplayIntervalSeconds)
import Json.Decode exposing (Value)
import Port
import PortMessage
import Time
import Value
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Msg as Msg exposing (Msg)
import VideoPlayer.Status as Status exposing (Status)


type alias Context =
    { rawAudioPlayerId : String
    , gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
    , overrideInactivityPause : Bool
    }


type alias Msgs msgs msg =
    { msgs
        | noOpMsg : msg
        , portMsg : Port.Msg -> msg
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

        animateVideoPlayer =
            Animation.subscription
                (Msg.animateVideoPlayer videoPlayerMsg)
                [ videoPlayer1.style ]
    in
    Sub.batch
        [ fetchNextGif
        , animateVideoPlayer
        , Port.inbound (handlePortMessage msgs context videoPlayer1)
        ]



-- PRIVATE


handlePortMessage : Msgs msgs msg -> Context -> VideoPlayer -> Value -> msg
handlePortMessage msgs context videoPlayer1 portMessage =
    let
        { videoPlayerMsg, noOpMsg, portMsg } =
            msgs

        { tag, payload } =
            PortMessage.decode portMessage
    in
    case tag of
        "VIDEOS_HALTED" ->
            if
                (videoPlayer1.status == Status.playing)
                    && not context.overrideInactivityPause
            then
                Msg.videosHalted videoPlayerMsg

            else
                noOpMsg

        "VIDEOS_PAUSED" ->
            Msg.videosPaused videoPlayerMsg

        "VIDEOS_PLAYING" ->
            Msg.videosPlaying videoPlayerMsg

        "WINDOW_BLURRED" ->
            if videoPlayer1.status == Status.playing then
                handleWindowBlurred msgs context.rawAudioPlayerId payload

            else
                noOpMsg

        "WINDOW_FOCUSED" ->
            if videoPlayer1.status == Status.halted then
                Port.playVideosMsg portMsg

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


handleWindowBlurred : Msgs msgs msg -> String -> Value -> msg
handleWindowBlurred { noOpMsg, portMsg } rawAudioPlayerId payload =
    let
        activeElementId =
            Value.extractStringWithDefault "" payload
    in
    -- NOTE: If the document target has "blurred" from the video player
    -- to the SoundCloud iframe, then the Elm app does not need to
    -- consider this a "real" blur for purposes of displaying the
    -- "Gifs Paused" overlay.
    if activeElementId == rawAudioPlayerId then
        noOpMsg

    else
        Port.haltVideosMsg portMsg
