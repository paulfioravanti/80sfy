module VideoPlayer.Subscriptions exposing (Context, ParentMsgs, subscriptions)

import Gif exposing (GifDisplayIntervalSeconds)
import Json.Decode exposing (Value)
import PortMessage
import Ports
import Time
import Value
import VideoPlayer.Animation as Animation
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Msg as Msg exposing (Msg)
import VideoPlayer.Status as Status exposing (Status)


type alias Context =
    { rawAudioPlayerId : String
    , gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
    , overrideInactivityPause : Bool
    }


type alias ParentMsgs msgs msg =
    { msgs
        | noOpMsg : msg
        , portsMsg : Ports.Msg -> msg
        , videoPlayerMsg : Msg -> msg
    }


subscriptions : ParentMsgs msgs msg -> Context -> VideoPlayer -> Sub msg
subscriptions ({ videoPlayerMsg } as parentMsgs) context videoPlayer1 =
    let
        fetchNextGif : Sub msg
        fetchNextGif =
            fetchNextGifSubscription
                videoPlayerMsg
                videoPlayer1.status
                context.gifDisplayIntervalSeconds

        animateVideoPlayer : Sub msg
        animateVideoPlayer =
            Animation.subscription videoPlayerMsg videoPlayer1.style
    in
    Sub.batch
        [ fetchNextGif
        , animateVideoPlayer
        , Ports.inbound (handlePortMessage parentMsgs context videoPlayer1)
        ]



-- PRIVATE


handlePortMessage :
    ParentMsgs msgs msg
    -> Context
    -> VideoPlayer
    -> Value
    -> msg
handlePortMessage parentMsgs context videoPlayer1 portMessage =
    let
        { videoPlayerMsg, noOpMsg, portsMsg } =
            parentMsgs

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
                handleWindowBlurred parentMsgs context.rawAudioPlayerId payload

            else
                noOpMsg

        "WINDOW_FOCUSED" ->
            if videoPlayer1.status == Status.halted then
                Ports.playVideosMsg portsMsg

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
            rawGifDisplayMilliSeconds : Float
            rawGifDisplayMilliSeconds =
                Gif.rawDisplayIntervalSeconds gifDisplayIntervalSeconds * 1000
        in
        Time.every
            rawGifDisplayMilliSeconds
            (Msg.crossFadePlayers videoPlayerMsg)

    else
        Sub.none


handleWindowBlurred : ParentMsgs msgs msg -> String -> Value -> msg
handleWindowBlurred { noOpMsg, portsMsg } rawAudioPlayerId payload =
    let
        activeElementId : String
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
        Ports.haltVideosMsg portsMsg
