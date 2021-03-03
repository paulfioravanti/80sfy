port module AudioPlayer.Subscriptions exposing (Msgs, subscriptions)

import AudioPlayer.Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg exposing (Msg)
import AudioPlayer.Status as Status
import Json.Decode exposing (Value)
import PortMessage
import Ports
import Value
import VideoPlayer


port audioPaused : (Value -> msg) -> Sub msg


port audioPlaying : (Value -> msg) -> Sub msg


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
        , Ports.fromSoundCloudWidget (handlePortMessage msgs)
        ]



-- PRIVATE


handlePortMessage : Msgs msgs msg -> Value -> msg
handlePortMessage { audioPlayerMsg, noOpMsg } portMessage =
    let
        { tag, payload } =
            PortMessage.decode portMessage
    in
    case tag of
        "NEXT_TRACK_NUMBER_REQUESTED" ->
            handleNextTrackNumberRequested audioPlayerMsg

        "PLAYLIST_LENGTH_SET" ->
            handlePlaylistLengthSet audioPlayerMsg payload

        _ ->
            noOpMsg


handleNextTrackNumberRequested : (Msg -> msg) -> msg
handleNextTrackNumberRequested audioPlayerMsg =
    Msg.nextTrackNumberRequested audioPlayerMsg


handlePlaylistLengthSet : (Msg -> msg) -> Value -> msg
handlePlaylistLengthSet audioPlayerMsg payload =
    let
        playlistLength =
            Value.extractIntWithDefault 1 payload
    in
    Msg.setPlaylistLength audioPlayerMsg playlistLength


audioPausedSubscriptions : Msgs msgs msg -> Sub msg
audioPausedSubscriptions { audioPlayerMsg, noOpMsg, videoPlayerMsg } =
    let
        audioPausedMsg =
            Msg.audioPaused audioPlayerMsg

        pauseVideosMsg =
            VideoPlayer.pauseVideosMsg videoPlayerMsg

        handleCurrentPositionFlag msg currentPositionFlag =
            let
                currentPosition =
                    Value.extractFloatWithDefault 0.0 currentPositionFlag
            in
            -- Only perform actions if at least some of the sound from the
            -- SoundCloud player has been actually played.
            if currentPosition > 0 then
                msg

            else
                noOpMsg
    in
    Sub.batch
        [ audioPaused (handleCurrentPositionFlag audioPausedMsg)
        , audioPaused (handleCurrentPositionFlag pauseVideosMsg)
        ]


audioPlayingSubscriptions : Msgs msgs msg -> Sub msg
audioPlayingSubscriptions { audioPlayerMsg, noOpMsg, videoPlayerMsg } =
    let
        audioPlayingMsg =
            Msg.audioPlaying audioPlayerMsg

        playVideosMsg =
            VideoPlayer.playVideosMsg videoPlayerMsg

        handleLoadedProgressFlag msg loadedProgressFlag =
            let
                loadedProgress =
                    Value.extractFloatWithDefault 0.0 loadedProgressFlag
            in
            -- Only perform actions if at least some of the sound from the
            -- SoundCloud player has been loaded and can therefore
            -- actually play.
            if loadedProgress > 0 then
                msg

            else
                noOpMsg
    in
    Sub.batch
        [ audioPlaying (handleLoadedProgressFlag audioPlayingMsg)
        , audioPlaying (handleLoadedProgressFlag playVideosMsg)
        ]
