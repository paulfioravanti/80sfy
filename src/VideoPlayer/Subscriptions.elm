port module VideoPlayer.Subscriptions exposing (subscriptions)

import Animation
import Json.Decode as Decode exposing (Value)
import MsgRouter exposing (MsgRouter)
import Time exposing (second)
import VideoPlayer.Model exposing (Status(Playing, Halted), VideoPlayer)
import VideoPlayer.Msg
    exposing
        ( Msg
            ( AnimateVideoPlayer
            , CrossFadePlayers
            , ExitFullScreen
            , HaltVideos
            , PlayVideos
            , RequestFullScreen
            , VideosHalted
            , VideosPaused
            , VideosPlaying
            )
        )


port toggleFullScreen : (Value -> msg) -> Sub msg


port videosHalted : (() -> msg) -> Sub msg


port videosPaused : (() -> msg) -> Sub msg


port videosPlaying : (() -> msg) -> Sub msg


port windowBlurred : (Value -> msg) -> Sub msg


port windowFocused : (() -> msg) -> Sub msg


subscriptions : MsgRouter msg -> Float -> Bool -> VideoPlayer -> Sub msg
subscriptions { noOpMsg, videoPlayerMsg } gifDisplaySeconds overrideInactivityPause videoPlayer1 =
    let
        fetchNextGif =
            fetchNextGifSubscription
                videoPlayerMsg
                videoPlayer1.status
                gifDisplaySeconds

        toggleFullScreen =
            toggleFullScreenSubscription videoPlayerMsg

        videosHalted =
            videosHaltedSubscription
                videoPlayerMsg
                videoPlayer1.status
                overrideInactivityPause

        windowEvent =
            windowEventSubscription videoPlayerMsg noOpMsg videoPlayer1.status
    in
        Sub.batch
            [ fetchNextGif
            , toggleFullScreen
            , videosHalted
            , windowEvent
            , videosPaused (\() -> videoPlayerMsg VideosPaused)
            , videosPlaying (\() -> videoPlayerMsg VideosPlaying)
            , Animation.subscription
                (videoPlayerMsg << AnimateVideoPlayer)
                [ videoPlayer1.style ]
            ]


fetchNextGifSubscription : (Msg -> msg) -> Status -> Float -> Sub msg
fetchNextGifSubscription videoPlayerMsg status gifDisplaySeconds =
    if status == Playing then
        Time.every
            (gifDisplaySeconds * second)
            (videoPlayerMsg << CrossFadePlayers)
    else
        Sub.none


toggleFullScreenSubscription : (Msg -> msg) -> Sub msg
toggleFullScreenSubscription videoPlayerMsg =
    toggleFullScreen
        (\isFullScreenFlag ->
            if extractBoolValue isFullScreenFlag then
                videoPlayerMsg ExitFullScreen
            else
                videoPlayerMsg RequestFullScreen
        )


videosHaltedSubscription : (Msg -> msg) -> Status -> Bool -> Sub msg
videosHaltedSubscription videoPlayerMsg status overrideInactivityPause =
    if (status == Playing) && not overrideInactivityPause then
        videosHalted (\() -> videoPlayerMsg VideosHalted)
    else
        Sub.none


windowEventSubscription : (Msg -> msg) -> msg -> Status -> Sub msg
windowEventSubscription videoPlayerMsg noOpMsg status =
    case status of
        Playing ->
            -- NOTE: If the document target has "blurred" from the video player
            -- to the SoundCloud iframe, then the Elm app does not need to
            -- consider this a "real" blur for purposes of displaying the
            -- "Gifs Paused" overlay.
            windowBlurred
                (\activeElementIdFlag ->
                    if audioPlayerActive activeElementIdFlag then
                        noOpMsg
                    else
                        videoPlayerMsg HaltVideos
                )

        Halted ->
            windowFocused (\() -> videoPlayerMsg PlayVideos)

        _ ->
            Sub.none


audioPlayerActive : Value -> Bool
audioPlayerActive activeElementIdFlag =
    let
        activeElementId =
            activeElementIdFlag
                |> Decode.decodeValue Decode.string
                |> Result.withDefault ""
    in
        activeElementId == "track-player"


extractBoolValue : Value -> Bool
extractBoolValue boolFlag =
    boolFlag
        |> Decode.decodeValue Decode.bool
        |> Result.withDefault False
