module AudioPlayer.Playlist exposing
    ( TrackIndex
    , generate
    , rawTrackIndex
    , trackIndex
    )

import AudioPlayer.Msg as Msg exposing (Msg)
import Random
import Random.List


type TrackIndex
    = TrackIndex Int


generate : (Msg -> msg) -> Int -> Cmd msg
generate audioPlayerMsg playlistLength =
    let
        trackList =
            List.range 0 (playlistLength - 1)

        generator =
            Random.List.shuffle trackList

        playlistGeneratedMsg =
            Msg.playlistGenerated audioPlayerMsg
    in
    Random.generate playlistGeneratedMsg generator


rawTrackIndex : TrackIndex -> Int
rawTrackIndex (TrackIndex rawTrackIndexInt) =
    rawTrackIndexInt


trackIndex : Int -> TrackIndex
trackIndex rawTrackIndexInt =
    TrackIndex rawTrackIndexInt
