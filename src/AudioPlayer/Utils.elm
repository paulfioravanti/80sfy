module AudioPlayer.Utils exposing (generatePlaylist)

import AudioPlayer.Msg exposing (Msg(GeneratePlaylist))
import Random
import Random.List


generatePlaylist : (Msg -> msg) -> Int -> Cmd msg
generatePlaylist audioPlayerMsg playlistLength =
    let
        trackList =
            List.range 0 (playlistLength - 1)

        generator =
            Random.List.shuffle trackList
    in
        generator
            |> Random.generate (audioPlayerMsg << GeneratePlaylist)
