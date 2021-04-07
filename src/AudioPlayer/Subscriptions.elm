module AudioPlayer.Subscriptions exposing (ParentMsgs, subscriptions)

import AudioPlayer.Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg exposing (Msg)
import AudioPlayer.Status as Status
import Json.Decode exposing (Value)
import Ports
import Value


type alias ParentMsgs msgs msg =
    { msgs
        | audioPlayerMsg : Msg -> msg
        , audioPlayingMsg : msg
        , noOpMsg : msg
    }


subscriptions : ParentMsgs msgs msg -> AudioPlayer -> Sub msg
subscriptions parentMsgs audioPlayer =
    Ports.inbound (handlePortMessage parentMsgs audioPlayer)



-- PRIVATE


handlePortMessage : ParentMsgs msgs msg -> AudioPlayer -> Value -> msg
handlePortMessage parentMsgs audioPlayer payload =
    let
        { tag, data } =
            Ports.decodePayload payload

        { audioPlayerMsg, noOpMsg } =
            parentMsgs
    in
    case tag of
        "AUDIO_PAUSED" ->
            if Status.isPlaying audioPlayer.status then
                handleAudioPaused parentMsgs data

            else
                noOpMsg

        "AUDIO_PLAYING" ->
            if not (Status.isPlaying audioPlayer.status) then
                handleAudioPlaying parentMsgs data

            else
                noOpMsg

        "NEXT_TRACK_NUMBER_REQUESTED" ->
            audioPlayerMsg Msg.NextTrackNumberRequested

        "PLAYLIST_LENGTH_FETCHED" ->
            handlePlaylistLengthFetched audioPlayerMsg data

        _ ->
            noOpMsg


handlePlaylistLengthFetched : (Msg -> msg) -> Value -> msg
handlePlaylistLengthFetched audioPlayerMsg data =
    let
        playlistLength : Int
        playlistLength =
            Value.extractIntWithDefault 1 data
    in
    Msg.playlistLengthFetched audioPlayerMsg playlistLength


handleAudioPaused : ParentMsgs msgs msg -> Value -> msg
handleAudioPaused { audioPlayerMsg, noOpMsg } data =
    let
        currentPosition : Float
        currentPosition =
            Value.extractFloatWithDefault 0.0 data
    in
    -- Only perform actions if at least some of the sound from the
    -- SoundCloud player has been actually played.
    if currentPosition > 0 then
        audioPlayerMsg Msg.AudioPaused

    else
        noOpMsg


handleAudioPlaying : ParentMsgs msgs msg -> Value -> msg
handleAudioPlaying { audioPlayingMsg, noOpMsg } data =
    let
        loadedProgress : Float
        loadedProgress =
            Value.extractFloatWithDefault 0.0 data
    in
    -- Only perform actions if at least some of the sound from the
    -- SoundCloud player has been loaded and can therefore
    -- actually play.
    if loadedProgress > 0 then
        audioPlayingMsg

    else
        noOpMsg
