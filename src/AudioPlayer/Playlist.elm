module AudioPlayer.Playlist exposing (generate)

import AudioPlayer.Msg as Msg exposing (Msg)
import Random
import Random.List


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
