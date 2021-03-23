module AudioPlayer.Subscriptions exposing (ParentMsgs, subscriptions)

import AudioPlayer.Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg exposing (Msg)
import AudioPlayer.Status as Status
import Json.Decode exposing (Value)
import PortMessage
import Ports
import Value


type alias ParentMsgs msgs msg =
    { msgs
        | audioPausedMsg : msg
        , audioPlayerMsg : Msg -> msg
        , audioPlayingMsg : msg
        , noOpMsg : msg
    }


subscriptions : ParentMsgs msgs msg -> AudioPlayer -> Sub msg
subscriptions parentMsgs audioPlayer =
    Ports.inbound (handlePortMessage parentMsgs audioPlayer)



-- PRIVATE


handlePortMessage : ParentMsgs msgs msg -> AudioPlayer -> Value -> msg
handlePortMessage parentMsgs audioPlayer portMessage =
    let
        { tag, payload } =
            PortMessage.decode portMessage

        { audioPlayerMsg, noOpMsg } =
            parentMsgs
    in
    case tag of
        "AUDIO_PAUSED" ->
            if Status.isPlaying audioPlayer.status then
                handleAudioPaused parentMsgs payload

            else
                noOpMsg

        "AUDIO_PLAYING" ->
            if not (Status.isPlaying audioPlayer.status) then
                handleAudioPlaying parentMsgs payload

            else
                noOpMsg

        "NEXT_TRACK_NUMBER_REQUESTED" ->
            handleNextTrackNumberRequested audioPlayerMsg

        "PLAYLIST_LENGTH_FETCHED" ->
            handlePlaylistLengthFetched audioPlayerMsg payload

        _ ->
            noOpMsg


handleNextTrackNumberRequested : (Msg -> msg) -> msg
handleNextTrackNumberRequested audioPlayerMsg =
    Msg.nextTrackNumberRequested audioPlayerMsg


handlePlaylistLengthFetched : (Msg -> msg) -> Value -> msg
handlePlaylistLengthFetched audioPlayerMsg payload =
    let
        playlistLength =
            Value.extractIntWithDefault 1 payload
    in
    Msg.playlistLengthFetched audioPlayerMsg playlistLength


handleAudioPaused : ParentMsgs msgs msg -> Value -> msg
handleAudioPaused { audioPausedMsg, noOpMsg } payload =
    let
        currentPosition =
            Value.extractFloatWithDefault 0.0 payload
    in
    -- Only perform actions if at least some of the sound from the
    -- SoundCloud player has been actually played.
    if currentPosition > 0 then
        audioPausedMsg

    else
        noOpMsg


handleAudioPlaying : ParentMsgs msgs msg -> Value -> msg
handleAudioPlaying { audioPlayingMsg, noOpMsg } payload =
    let
        loadedProgress =
            Value.extractFloatWithDefault 0.0 payload
    in
    -- Only perform actions if at least some of the sound from the
    -- SoundCloud player has been loaded and can therefore
    -- actually play.
    if loadedProgress > 0 then
        audioPlayingMsg

    else
        noOpMsg
