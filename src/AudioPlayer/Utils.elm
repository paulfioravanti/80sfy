module AudioPlayer.Utils exposing (generatePlaylistTrackOrder)

import AudioPlayer.Msg exposing (Msg(GeneratePlaylistTrackOrder))
import Random
import Random.List


generatePlaylistTrackOrder : (Msg -> msg) -> Int -> Cmd msg
generatePlaylistTrackOrder audioPlayerMsg playlistLength =
    let
        trackList =
            List.range 0 (playlistLength - 1)

        generator =
            Random.List.shuffle trackList
    in
        generator
            |> Random.generate (audioPlayerMsg << GeneratePlaylistTrackOrder)
