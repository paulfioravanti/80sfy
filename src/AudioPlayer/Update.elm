module AudioPlayer.Update exposing (update)

import AudioPlayer.Model exposing (AudioPlayer)
import AudioPlayer.Msg
    exposing
        ( Msg
            ( AdjustVolume
            , AudioPaused
            , AudioPlayerReady
            , AudioPlaying
            , GeneratePlaylistTrackOrder
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

        AudioPaused ->
            ( { audioPlayer | playing = False }, Cmd.none )

        AudioPlayerReady ->
            let
                ( head, tail ) =
                    case audioPlayer.playlistTrackOrder of
                        head :: tail ->
                            ( head, tail )

                        [] ->
                            ( 0, [] )
            in
                ( { audioPlayer | playlistTrackOrder = tail }
                , Ports.skipToTrack head
                )

        AudioPlaying ->
            ( { audioPlayer | playing = True }, Cmd.none )

        GeneratePlaylistTrackOrder playlistTrackOrder ->
            ( { audioPlayer | playlistTrackOrder = playlistTrackOrder }
            , Cmd.none
            )

        NextTrack ->
            ( { audioPlayer | playing = True }, Ports.nextTrack () )

        PauseAudio ->
            ( { audioPlayer | playing = False }, Ports.pauseAudio () )

        PlayAudio ->
            ( { audioPlayer | playing = True }, Ports.playAudio () )

        ToggleMute ->
            let
                cmd =
                    if audioPlayer.muted then
                        Ports.setVolume audioPlayer.volume
                    else
                        Ports.setVolume 0
            in
                ( { audioPlayer | muted = not audioPlayer.muted }, cmd )
