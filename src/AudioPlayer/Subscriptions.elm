port module AudioPlayer.Subscriptions exposing (subscriptions)

import AudioPlayer.Model as Model exposing (AudioPlayer)
import AudioPlayer.Msg as Msg exposing (Msg)
import Json.Decode as Decode exposing (Value)
import VideoPlayer


port audioPaused : (Value -> msg) -> Sub msg


port audioPlaying : (Value -> msg) -> Sub msg


port setPlaylistLength : (Value -> msg) -> Sub msg


port requestNextTrackNumber : (() -> msg) -> Sub msg


subscriptions :
    (Msg -> msg)
    -> msg
    -> (VideoPlayer.Msg -> msg)
    -> AudioPlayer
    -> Sub msg
subscriptions audioPlayerMsg noOpMsg videoPlayerMsg audioPlayer =
    let
        playingSubscription =
            if Model.isPlaying audioPlayer then
                audioPausedSubscriptions
                    audioPlayerMsg
                    noOpMsg
                    videoPlayerMsg

            else
                audioPlayingSubscriptions
                    audioPlayerMsg
                    noOpMsg
                    videoPlayerMsg
    in
    Sub.batch
        [ playingSubscription
        , requestNextTrackNumber
            (\() -> audioPlayerMsg Msg.NextTrackNumberRequested)
        , setPlaylistLength
            (audioPlayerMsg << Msg.SetPlaylistLength << extractIntValue)
        ]


audioPausedSubscriptions :
    (Msg -> msg)
    -> msg
    -> (VideoPlayer.Msg -> msg)
    -> Sub msg
audioPausedSubscriptions audioPlayerMsg noOpMsg videoPlayerMsg =
    -- Only perform actions if at least some of the sound from the
    -- SoundCloud player has been actually played.
    Sub.batch
        [ audioPaused
            (\currentPositionFlag ->
                if extractFloatValue currentPositionFlag > 0 then
                    audioPlayerMsg Msg.AudioPaused

                else
                    noOpMsg
            )
        , audioPaused
            (\currentPositionFlag ->
                if extractFloatValue currentPositionFlag > 0 then
                    videoPlayerMsg VideoPlayer.pauseVideosMsg

                else
                    noOpMsg
            )
        ]


audioPlayingSubscriptions :
    (Msg -> msg)
    -> msg
    -> (VideoPlayer.Msg -> msg)
    -> Sub msg
audioPlayingSubscriptions audioPlayerMsg noOpMsg videoPlayerMsg =
    -- Only perform actions if at least some of the sound from the
    -- SoundCloud player has been loaded and can therefore
    -- actually play.
    Sub.batch
        [ audioPlaying
            (\loadedProgressFlag ->
                if extractFloatValue loadedProgressFlag > 0 then
                    audioPlayerMsg Msg.AudioPlaying

                else
                    noOpMsg
            )
        , audioPlaying
            (\loadedProgressFlag ->
                if extractFloatValue loadedProgressFlag > 0 then
                    videoPlayerMsg VideoPlayer.playVideosMsg

                else
                    noOpMsg
            )
        ]


extractIntValue : Value -> Int
extractIntValue intFlag =
    intFlag
        |> Decode.decodeValue Decode.int
        |> Result.withDefault 1


extractFloatValue : Value -> Float
extractFloatValue floatFlag =
    floatFlag
        |> Decode.decodeValue Decode.float
        |> Result.withDefault 0.0
