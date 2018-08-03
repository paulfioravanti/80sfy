module AudioPlayer.Update exposing (update)

import AudioPlayer.Model as Model
    exposing
        ( AudioPlayer
        , Status
            ( Paused
            , Playing
            )
        )
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
import VideoPlayer


update : MsgRouter msg -> Msg -> AudioPlayer -> ( AudioPlayer, Cmd msg )
update { audioPlayerMsg, videoPlayerMsg } msg audioPlayer =
    case msg of
        AdjustVolume sliderVolume ->
            let
                maxVolume =
                    100

                minVolume =
                    0

                containVolume volume =
                    if volume < minVolume then
                        minVolume
                    else if volume > maxVolume then
                        maxVolume
                    else
                        volume

                volume =
                    sliderVolume
                        |> String.toInt
                        |> Result.withDefault audioPlayer.volume
                        |> containVolume
            in
                ( { audioPlayer | muted = False, volume = volume }
                , Ports.setVolume volume
                )

        AudioPaused ->
            ( { audioPlayer | status = Paused }, Cmd.none )

        AudioPlaying ->
            ( { audioPlayer | status = Playing }, Cmd.none )

        GeneratePlaylistTrackOrder playlistTrackOrder ->
            let
                requestNextTrack =
                    audioPlayerMsg NextTrackNumberRequested
                        |> Task.succeed
                        |> Task.perform identity
            in
                ( { audioPlayer | playlistTrackOrder = playlistTrackOrder }
                , requestNextTrack
                )

        NextTrack ->
            let
                requestNextTrack =
                    audioPlayerMsg NextTrackNumberRequested
                        |> Task.succeed
                        |> Task.perform identity

                playVideos =
                    videoPlayerMsg VideoPlayer.playVideosMsg
                        |> Task.succeed
                        |> Task.perform identity
            in
                ( { audioPlayer | status = Playing }
                , Cmd.batch [ requestNextTrack, playVideos ]
                )

        NextTrackNumberRequested ->
            let
                ( playlistTrackOrder, cmd ) =
                    case audioPlayer.playlistTrackOrder of
                        head :: tail ->
                            ( tail, Ports.skipToTrack head )

                        [] ->
                            ( []
                            , Utils.generatePlaylistTrackOrder
                                audioPlayerMsg
                                audioPlayer.playlistLength
                            )
            in
                ( { audioPlayer | playlistTrackOrder = playlistTrackOrder }
                , cmd
                )

        PauseAudio ->
            ( audioPlayer, Ports.pauseAudio () )

        PlayAudio ->
            ( audioPlayer, Ports.playAudio () )

        ReInitAudioPlayer soundCloudPlaylistUrl ->
            ( Model.init soundCloudPlaylistUrl
            , Ports.initAudioPlayer audioPlayer.volume
            )

        SetPlaylistLength playlistLength ->
            let
                generatePlaylistTrackOrder =
                    playlistLength
                        |> Utils.generatePlaylistTrackOrder audioPlayerMsg
            in
                ( { audioPlayer | playlistLength = playlistLength }
                , generatePlaylistTrackOrder
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
