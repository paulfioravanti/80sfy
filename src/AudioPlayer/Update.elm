module AudioPlayer.Update exposing (update)

import AudioPlayer.Msg exposing (Msg(AdjustVolume, ToggleMute, TogglePlayPause))
import AudioPlayer.Model exposing (AudioPlayer)


update : Msg -> AudioPlayer -> ( AudioPlayer, Cmd Msg )
update msg audioPlayer =
    case msg of
        AdjustVolume volume ->
            ( { audioPlayer | muted = False, volume = volume }, Cmd.none )

        ToggleMute ->
            ( { audioPlayer | muted = not audioPlayer.muted }, Cmd.none )

        TogglePlayPause ->
            ( { audioPlayer | playing = not audioPlayer.playing }, Cmd.none )
