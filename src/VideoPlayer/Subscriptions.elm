module VideoPlayer.Subscriptions exposing (Context, ParentMsgs, subscriptions)

import Gif exposing (GifDisplayIntervalSeconds)
import Json.Decode exposing (Value)
import Ports
import Time exposing (Posix)
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
        | crossFadePlayersMsg : Posix -> msg
        , noOpMsg : msg
        , portsMsg : Ports.Msg -> msg
        , videoPlayerMsg : Msg -> msg
    }


subscriptions : ParentMsgs msgs msg -> Context -> VideoPlayer -> Sub msg
subscriptions parentMsgs context videoPlayer1 =
    let
        fetchNextGif : Sub msg
        fetchNextGif =
            fetchNextGifSubscription
                parentMsgs.crossFadePlayersMsg
                videoPlayer1.status
                context.gifDisplayIntervalSeconds

        animateVideoPlayer : Sub msg
        animateVideoPlayer =
            Animation.subscription parentMsgs.videoPlayerMsg videoPlayer1.style
    in
    Sub.batch
        [ fetchNextGif
        , animateVideoPlayer
        , Ports.inbound (handlePayload parentMsgs context videoPlayer1)
        ]



-- PRIVATE


handlePayload :
    ParentMsgs msgs msg
    -> Context
    -> VideoPlayer
    -> Value
    -> msg
handlePayload parentMsgs context videoPlayer1 payload =
    let
        { videoPlayerMsg, noOpMsg, portsMsg } =
            parentMsgs

        { tag, data } =
            Ports.decodePayload payload
    in
    case tag of
        "VIDEOS_HALTED" ->
            if
                (videoPlayer1.status == Status.playing)
                    && not context.overrideInactivityPause
            then
                videoPlayerMsg Msg.VideosHalted

            else
                noOpMsg

        "VIDEOS_PAUSED" ->
            videoPlayerMsg Msg.VideosPaused

        "VIDEOS_PLAYING" ->
            videoPlayerMsg Msg.VideosPlaying

        "WINDOW_BLURRED" ->
            if videoPlayer1.status == Status.playing then
                handleWindowBlurred parentMsgs context.rawAudioPlayerId data

            else
                noOpMsg

        "WINDOW_FOCUSED" ->
            if videoPlayer1.status == Status.halted then
                portsMsg Ports.playVideosMsg

            else
                noOpMsg

        _ ->
            noOpMsg


fetchNextGifSubscription :
    (Posix -> msg)
    -> Status
    -> GifDisplayIntervalSeconds
    -> Sub msg
fetchNextGifSubscription crossFadePlayersMsg status gifDisplayIntervalSeconds =
    if status == Status.playing then
        let
            rawGifDisplayMilliSeconds : Float
            rawGifDisplayMilliSeconds =
                Gif.rawDisplayIntervalSeconds gifDisplayIntervalSeconds * 1000
        in
        Time.every rawGifDisplayMilliSeconds crossFadePlayersMsg

    else
        Sub.none


handleWindowBlurred : ParentMsgs msgs msg -> String -> Value -> msg
handleWindowBlurred { noOpMsg, portsMsg } rawAudioPlayerId data =
    let
        activeElementId : String
        activeElementId =
            Value.extractStringWithDefault "" data
    in
    -- NOTE: If the document target has "blurred" from the video player
    -- to the SoundCloud iframe, then the Elm app does not need to
    -- consider this a "real" blur for purposes of displaying the
    -- "Gifs Paused" overlay.
    if activeElementId == rawAudioPlayerId then
        noOpMsg

    else
        portsMsg Ports.haltVideosMsg
