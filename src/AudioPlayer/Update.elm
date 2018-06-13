module AudioPlayer.Update exposing (update)

import AudioPlayer.Model as Model exposing (AudioPlayer)
import AudioPlayer.Msg
    exposing
        ( Msg
            ( AdjustVolume
            , AudioPaused
            , AudioPlaying
            , GeneratePlaylistTrackOrder
            , NextTrack
            , NextTrackNumberRequested
            , PauseAudio
            , PlayAudio
            , ReInitAudioPlayer
            , SetPlaylistLength
            , ToggleMute
            )
        )
import AudioPlayer.Ports as Ports
import AudioPlayer.Utils as Utils
import MsgRouter exposing (MsgRouter)
import Task


update : MsgRouter msg -> Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update msgRouter msg audioPlayer =
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

        AudioPlaying ->
            ( { audioPlayer | playing = True }, Cmd.none )

        GeneratePlaylistTrackOrder playlistTrackOrder ->
            ( { audioPlayer | playlistTrackOrder = playlistTrackOrder }
            , Task.succeed ()
                |> Task.perform
                    (msgRouter.audioPlayerMsg << NextTrackNumberRequested)
            )

        NextTrack () ->
            ( { audioPlayer | playing = True }
            , Task.succeed ()
                |> Task.perform
                    (msgRouter.audioPlayerMsg << NextTrackNumberRequested)
            )

        NextTrackNumberRequested () ->
            let
                ( playlistTrackOrder, cmd ) =
                    case audioPlayer.playlistTrackOrder of
                        head :: tail ->
                            ( tail, Ports.skipToTrack head )

                        [] ->
                            ( []
                            , Utils.generatePlaylistTrackOrder
                                msgRouter.audioPlayerMsg
                                audioPlayer.playlistLength
                            )
            in
                ( { audioPlayer | playlistTrackOrder = playlistTrackOrder }
                , cmd
                )

        PauseAudio ->
            ( { audioPlayer | playing = False }, Ports.pauseAudio () )

        PlayAudio ->
            ( { audioPlayer | playing = True }, Ports.playAudio () )

        ReInitAudioPlayer soundCloudPlaylistUrl ->
            ( Model.init soundCloudPlaylistUrl
            , Ports.initAudioPlayer audioPlayer.volume
            )

        SetPlaylistLength playlistLength ->
            ( { audioPlayer | playlistLength = playlistLength }
            , Utils.generatePlaylistTrackOrder
                msgRouter.audioPlayerMsg
                playlistLength
            )

        ToggleMute ->
            let
                cmd =
                    if audioPlayer.muted then
                        Ports.setVolume audioPlayer.volume
                    else
                        Ports.setVolume 0
            in
                ( { audioPlayer | muted = not audioPlayer.muted }, cmd )
