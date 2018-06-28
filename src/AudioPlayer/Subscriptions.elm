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
import VideoPlayer


port pauseAudioPlayer : (() -> msg) -> Sub msg


port pauseVideoPlayer : (() -> msg) -> Sub msg


port playAudioPlayer : (() -> msg) -> Sub msg


port playVideoPlayer : (() -> msg) -> Sub msg


port setPlaylistLength : (Value -> msg) -> Sub msg


port requestNextTrackNumber : (() -> msg) -> Sub msg


subscriptions : MsgRouter msg -> AudioPlayer -> Sub msg
subscriptions { audioPlayerMsg, videoPlayerMsg } audioPlayer =
    let
        playingSubscription =
            if audioPlayer.playing then
                Sub.batch
                    [ pauseAudioPlayer (\() -> audioPlayerMsg AudioPaused)
                    , pauseVideoPlayer
                        (\() -> videoPlayerMsg (VideoPlayer.pauseVideosMsg ()))
                    ]
            else
                Sub.batch
                    [ playAudioPlayer (\() -> audioPlayerMsg AudioPlaying)
                    , playVideoPlayer
                        (\() -> videoPlayerMsg (VideoPlayer.playVideosMsg ()))
                    ]
    in
        Sub.batch
            [ playingSubscription
            , requestNextTrackNumber
                (\() -> audioPlayerMsg (NextTrackNumberRequested ()))
            , setPlaylistLength
                (audioPlayerMsg << SetPlaylistLength << extractPlaylistValue)
            ]


extractPlaylistValue : Value -> Int
extractPlaylistValue playlistLengthFlag =
    playlistLengthFlag
        |> Decode.decodeValue Decode.int
        |> Result.withDefault 1
