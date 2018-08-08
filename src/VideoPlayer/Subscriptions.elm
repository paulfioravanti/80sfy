port module VideoPlayer.Subscriptions exposing (Context, subscriptions)

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
            , HaltVideos
            , PlayVideos
            , VideosHalted
            , VideosPaused
            , VideosPlaying
            )
        )


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


subscriptions : MsgRouter msg -> Context -> VideoPlayer -> Sub msg
subscriptions { noOpMsg, videoPlayerMsg } context videoPlayer1 =
    let
        fetchNextGif =
            fetchNextGifSubscription
                videoPlayerMsg
                videoPlayer1.status
                context.gifDisplaySeconds

        videosHalted =
            videosHaltedSubscription
                videoPlayerMsg
                videoPlayer1.status
                context.overrideInactivityPause

        windowEvent =
            windowEventSubscription
                videoPlayerMsg
                noOpMsg
                context.audioPlayerId
                videoPlayer1.status
    in
        Sub.batch
            [ fetchNextGif
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


videosHaltedSubscription : (Msg -> msg) -> Status -> Bool -> Sub msg
videosHaltedSubscription videoPlayerMsg status overrideInactivityPause =
    if (status == Playing) && not overrideInactivityPause then
        videosHalted (\() -> videoPlayerMsg VideosHalted)
    else
        Sub.none


windowEventSubscription : (Msg -> msg) -> msg -> String -> Status -> Sub msg
windowEventSubscription videoPlayerMsg noOpMsg audioPlayerId status =
    case status of
        Playing ->
            -- NOTE: If the document target has "blurred" from the video player
            -- to the SoundCloud iframe, then the Elm app does not need to
            -- consider this a "real" blur for purposes of displaying the
            -- "Gifs Paused" overlay.
            windowBlurred
                (\activeElementIdFlag ->
                    if audioPlayerActive activeElementIdFlag audioPlayerId then
                        noOpMsg
                    else
                        videoPlayerMsg HaltVideos
                )

        Halted ->
            windowFocused (\() -> videoPlayerMsg PlayVideos)

        _ ->
            Sub.none


audioPlayerActive : Value -> String -> Bool
audioPlayerActive activeElementIdFlag audioPlayerId =
    let
        activeElementId =
            activeElementIdFlag
                |> Decode.decodeValue Decode.string
                |> Result.withDefault ""
    in
        activeElementId == audioPlayerId
