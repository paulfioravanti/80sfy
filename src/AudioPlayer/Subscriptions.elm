port module AudioPlayer.Subscriptions exposing (subscriptions)

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


subscriptions :
    (Msg -> msg)
    -> msg
    -> (VideoPlayer.Msg -> msg)
    -> AudioPlayer
    -> Sub msg
subscriptions audioPlayerMsg noOpMsg videoPlayerMsg audioPlayer =
    let
        playingSubscription =
            if Status.isPlaying audioPlayer.status then
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
            (audioPlayerMsg << Msg.SetPlaylistLength << Value.extractInt 1)
        ]



-- PRIVATE


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
                if Value.extractFloat 0.0 currentPositionFlag > 0 then
                    audioPlayerMsg Msg.AudioPaused

                else
                    noOpMsg
            )
        , audioPaused
            (\currentPositionFlag ->
                if Value.extractFloat 0.0 currentPositionFlag > 0 then
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
                if Value.extractFloat 0.0 loadedProgressFlag > 0 then
                    audioPlayerMsg Msg.AudioPlaying

                else
                    noOpMsg
            )
        , audioPlaying
            (\loadedProgressFlag ->
                if Value.extractFloat 0.0 loadedProgressFlag > 0 then
                    videoPlayerMsg VideoPlayer.playVideosMsg

                else
                    noOpMsg
            )
        ]
