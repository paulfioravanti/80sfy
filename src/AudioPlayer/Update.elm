module AudioPlayer.Update exposing (update)

import AudioPlayer.Model exposing (AudioPlayer)
import AudioPlayer.Msg
    exposing
        ( Msg
            ( AdjustVolume
            , ToggleMute
            , TogglePlayPause
            )
        )


update : AudioPlayer.Msg.Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update msg audioPlayer =
    case msg of
        AdjustVolume volume ->
            ( { audioPlayer | muted = False, volume = volume }, Cmd.none )

        ToggleMute ->
            ( { audioPlayer | muted = not audioPlayer.muted }, Cmd.none )

        TogglePlayPause ->
            ( { audioPlayer | playing = not audioPlayer.playing }, Cmd.none )
