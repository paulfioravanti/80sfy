module AudioPlayer.Utils exposing (generatePlaylistTrackOrder)

import AudioPlayer.Msg exposing (Msg(GeneratePlaylistTrackOrder))
import Random
import Random.List


generatePlaylistTrackOrder : (Msg -> msg) -> Cmd msg
generatePlaylistTrackOrder audioPlayerMsg =
    let
        trackList =
            List.range 0 (155 - 1)

        generator =
            Random.List.shuffle trackList
    in
        generator
            |> Random.generate (audioPlayerMsg << GeneratePlaylistTrackOrder)
