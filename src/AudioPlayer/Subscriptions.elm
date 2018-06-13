port module AudioPlayer.Subscriptions exposing (subscriptions)

import AudioPlayer.Msg
    exposing
        ( Msg
            ( AudioPaused
            , AudioPlaying
            , NextTrackNumberRequested
            , SetPlaylistLength
            )
        )
import AudioPlayer.Model exposing (AudioPlayer)
import Json.Decode as Decode exposing (Value)
import MsgRouter exposing (MsgRouter)


port pauseAudioPlayer : (() -> msg) -> Sub msg


port playAudioPlayer : (() -> msg) -> Sub msg


port setPlaylistLength : (Value -> msg) -> Sub msg


port requestNextTrackNumber : (() -> msg) -> Sub msg


subscriptions : MsgRouter msg -> AudioPlayer -> Sub msg
subscriptions { audioPlayerMsg } audioPlayer =
    let
        playingSubscription =
            if audioPlayer.playing then
                pauseAudioPlayer (\() -> (audioPlayerMsg AudioPaused))
            else
                playAudioPlayer (\() -> (audioPlayerMsg AudioPlaying))
    in
        Sub.batch
            [ playingSubscription
            , requestNextTrackNumber
                (\() -> (audioPlayerMsg (NextTrackNumberRequested ())))
            , setPlaylistLength
                (audioPlayerMsg << SetPlaylistLength << extractPlaylistValue)
            ]


extractPlaylistValue : Value -> Int
extractPlaylistValue playlistLengthFlag =
    let
        intValue =
            playlistLengthFlag
                |> Decode.decodeValue Decode.int
    in
        case intValue of
            Ok playlistLength ->
                playlistLength

            Err _ ->
                1
