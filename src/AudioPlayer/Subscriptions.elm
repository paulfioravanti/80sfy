module AudioPlayer.Subscriptions exposing (Msgs, subscriptions)

import AudioPlayer.Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg exposing (Msg)
import AudioPlayer.Status as Status
import Json.Decode exposing (Value)
import PortMessage
import Ports
import Value
import VideoPlayer


type alias Msgs msgs msg =
    { msgs
        | audioPausedMsg : msg
        , audioPlayerMsg : Msg -> msg
        , audioPlayingMsg : msg
        , noOpMsg : msg
        , videoPlayerMsg : VideoPlayer.Msg -> msg
    }


subscriptions : Msgs msgs msg -> AudioPlayer -> Sub msg
subscriptions msgs audioPlayer =
    Ports.fromSoundCloudWidget (handlePortMessage msgs audioPlayer)



-- PRIVATE


handlePortMessage : Msgs msgs msg -> AudioPlayer -> Value -> msg
handlePortMessage ({ audioPlayerMsg, noOpMsg } as msgs) audioPlayer portMessage =
    let
        { tag, payload } =
            PortMessage.decode portMessage
    in
    case tag of
        "AUDIO_PAUSED" ->
            if Status.isPlaying audioPlayer.status then
                handleAudioPaused msgs payload

            else
                noOpMsg

        "AUDIO_PLAYING" ->
            if not (Status.isPlaying audioPlayer.status) then
                handleAudioPlaying msgs payload

            else
                noOpMsg

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


handleAudioPaused : Msgs msgs msg -> Value -> msg
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


handleAudioPlaying : Msgs msgs msg -> Value -> msg
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
