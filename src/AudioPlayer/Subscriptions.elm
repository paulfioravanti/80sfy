port module AudioPlayer.Subscriptions exposing (Msgs, subscriptions)

import AudioPlayer.Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg exposing (Msg)
import AudioPlayer.Status as Status
import Json.Decode exposing (Value)
import Value
import VideoPlayer


port audioPaused : (Value -> msg) -> Sub msg


port audioPlaying : (Value -> msg) -> Sub msg


port setPlaylistLength : (Value -> msg) -> Sub msg


port requestNextTrackNumber : (() -> msg) -> Sub msg


type alias Msgs msgs msg =
    { msgs
        | audioPlayerMsg : Msg -> msg
        , noOpMsg : msg
        , videoPlayerMsg : VideoPlayer.Msg -> msg
    }


subscriptions : Msgs msgs msg -> AudioPlayer -> Sub msg
subscriptions ({ audioPlayerMsg } as msgs) audioPlayer =
    let
        playingSubscription =
            if Status.isPlaying audioPlayer.status then
                audioPausedSubscriptions msgs

            else
                audioPlayingSubscriptions msgs
    in
    Sub.batch
        [ playingSubscription
        , requestNextTrackNumber
            (\() -> Msg.nextTrackNumberRequested audioPlayerMsg)
        , setPlaylistLength
            (\value ->
                Msg.setPlaylistLength audioPlayerMsg
                    (Value.extractIntWithDefault 1 value)
            )
        ]



-- PRIVATE


audioPausedSubscriptions : Msgs msgs msg -> Sub msg
audioPausedSubscriptions { audioPlayerMsg, noOpMsg, videoPlayerMsg } =
    -- Only perform actions if at least some of the sound from the
    -- SoundCloud player has been actually played.
    let
        pauseMedia msg currentPositionFlag =
            let
                currentPosition =
                    currentPositionFlag
                        |> Value.extractFloatWithDefault 0.0
            in
            if currentPosition > 0 then
                msg

            else
                noOpMsg
    in
    Sub.batch
        [ audioPaused
            (pauseMedia (Msg.audioPaused audioPlayerMsg))
        , audioPaused
            (pauseMedia (VideoPlayer.pauseVideosMsg videoPlayerMsg))
        ]


audioPlayingSubscriptions : Msgs msgs msg -> Sub msg
audioPlayingSubscriptions { audioPlayerMsg, noOpMsg, videoPlayerMsg } =
    -- Only perform actions if at least some of the sound from the
    -- SoundCloud player has been loaded and can therefore
    -- actually play.
    let
        playMedia msg loadedProgressFlag =
            let
                loadedProgress =
                    loadedProgressFlag
                        |> Value.extractFloatWithDefault 0.0
            in
            if loadedProgress > 0 then
                msg

            else
                noOpMsg
    in
    Sub.batch
        [ audioPlaying
            (playMedia (Msg.audioPlaying audioPlayerMsg))
        , audioPlaying
            (playMedia (VideoPlayer.playVideosMsg videoPlayerMsg))
        ]
