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
import AudioPlayer.Ports as Ports


update : AudioPlayer.Msg.Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update msg audioPlayer =
    case msg of
        AdjustVolume sliderVolume ->
            let
                volume =
                    sliderVolume
                        |> String.toInt
                        |> Result.withDefault audioPlayer.volume
            in
                ( { audioPlayer | muted = False, volume = volume }, Cmd.none )

        ToggleMute ->
            ( { audioPlayer | muted = not audioPlayer.muted }, Cmd.none )

        TogglePlayPause ->
            let
                cmd =
                    if audioPlayer.playing then
                        Ports.pauseAudio ()
                    else
                        Ports.playAudio ()
            in
                ( { audioPlayer | playing = not audioPlayer.playing }, cmd )
