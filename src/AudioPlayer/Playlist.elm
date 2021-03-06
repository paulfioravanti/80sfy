module AudioPlayer.Playlist exposing
    ( TrackIndex
    , generate
    , handleNextTrackNumberRequest
    , rawTrackIndex
    , trackIndex
    )

import AudioPlayer.Msg as Msg exposing (Msg)
import Ports
import Random exposing (Generator)
import Random.List


type TrackIndex
    = TrackIndex Int


generate : (Msg -> msg) -> Int -> Cmd msg
generate audioPlayerMsg playlistLength =
    let
        trackList : List Int
        trackList =
            List.range 0 (playlistLength - 1)

        generator : Generator (List Int)
        generator =
            Random.List.shuffle trackList

        playlistGeneratedMsg : List Int -> msg
        playlistGeneratedMsg =
            Msg.playlistGenerated audioPlayerMsg
    in
    Random.generate playlistGeneratedMsg generator


handleNextTrackNumberRequest :
    (Msg -> msg)
    -> List TrackIndex
    -> Int
    -> ( List TrackIndex, Cmd msg )
handleNextTrackNumberRequest audioPlayerMsg playlist playlistLength =
    case playlist of
        head :: tail ->
            let
                trackNumber : Int
                trackNumber =
                    rawTrackIndex head
            in
            ( tail, Ports.skipToTrack trackNumber )

        [] ->
            ( [], generate audioPlayerMsg playlistLength )


rawTrackIndex : TrackIndex -> Int
rawTrackIndex (TrackIndex rawTrackIndexInt) =
    rawTrackIndexInt


trackIndex : Int -> TrackIndex
trackIndex rawTrackIndexInt =
    TrackIndex rawTrackIndexInt
