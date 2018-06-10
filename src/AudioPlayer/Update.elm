module AudioPlayer.Update exposing (update)

import AudioPlayer.Model exposing (AudioPlayer)
import AudioPlayer.Msg
    exposing
        ( Msg
            ( AdjustVolume
            , NextTrack
            , PauseAudio
            , PlayAudio
            , ToggleMute
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
                ( { audioPlayer | muted = False, volume = volume }
                , Ports.setVolume volume
                )

        NextTrack ->
            ( { audioPlayer | playing = True }, Ports.nextTrack () )

        PauseAudio callPort ->
            let
                cmd =
                    if callPort then
                        Ports.pauseAudio ()
                    else
                        Cmd.none
            in
                ( { audioPlayer | playing = False }, cmd )

        PlayAudio callPort ->
            let
                cmd =
                    if callPort then
                        Ports.playAudio ()
                    else
                        Cmd.none
            in
                ( { audioPlayer | playing = True }, cmd )

        ToggleMute ->
            let
                cmd =
                    if audioPlayer.muted then
                        Ports.setVolume audioPlayer.volume
                    else
                        Ports.setVolume 0
            in
                ( { audioPlayer | muted = not audioPlayer.muted }, cmd )
