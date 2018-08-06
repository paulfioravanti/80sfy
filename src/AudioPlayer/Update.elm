module AudioPlayer.Update exposing (update)

import AudioPlayer.Model as Model
    exposing
        ( AudioPlayer
        , Status(Paused, Playing, Muted)
        )
import AudioPlayer.Msg
    exposing
        ( Msg
            ( AdjustVolume
            , AudioPaused
            , AudioPlaying
            , GeneratePlaylist
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
                volume =
                    sliderVolume
                        |> String.toInt
                        |> Result.withDefault audioPlayer.volume
                        |> containVolume

                cmd =
                    if Model.isMuted audioPlayer then
                        Cmd.none
                    else
                        Ports.setVolume volume
            in
                ( { audioPlayer | volume = volume }, cmd )

        AudioPaused ->
            let
                status =
                    if Model.isMuted audioPlayer then
                        Muted Paused
                    else
                        Paused
            in
                ( { audioPlayer | status = status }, Cmd.none )

        AudioPlaying ->
            let
                status =
                    if Model.isMuted audioPlayer then
                        Muted Playing
                    else
                        Playing
            in
                ( { audioPlayer | status = status }, Cmd.none )

        GeneratePlaylist playlist ->
            let
                requestNextTrack =
                    nextTrackNumberRequested audioPlayerMsg
            in
                ( { audioPlayer | playlist = playlist }
                , requestNextTrack
                )

        NextTrack ->
            let
                requestNextTrack =
                    nextTrackNumberRequested audioPlayerMsg

                playVideos =
                    videoPlayerMsg VideoPlayer.playVideosMsg
                        |> Task.succeed
                        |> Task.perform identity

                status =
                    if Model.isMuted audioPlayer then
                        Muted Playing
                    else
                        Playing
            in
                ( { audioPlayer | status = status }
                , Cmd.batch [ requestNextTrack, playVideos ]
                )

        NextTrackNumberRequested ->
            let
                ( playlist, cmd ) =
                    case audioPlayer.playlist of
                        head :: tail ->
                            ( tail, Ports.skipToTrack head )

                        [] ->
                            ( []
                            , Utils.generatePlaylist
                                audioPlayerMsg
                                audioPlayer.playlistLength
                            )
            in
                ( { audioPlayer | playlist = playlist }
                , cmd
                )

        PauseAudio ->
            ( audioPlayer, Ports.pauseAudio () )

        PlayAudio ->
            ( audioPlayer, Ports.playAudio () )

        ReInitAudioPlayer soundCloudPlaylistUrl ->
            ( Model.init soundCloudPlaylistUrl
            , Ports.initAudioPlayer ( audioPlayer.volume, audioPlayer.id )
            )

        SetPlaylistLength playlistLength ->
            let
                generatePlaylist =
                    playlistLength
                        |> Utils.generatePlaylist audioPlayerMsg
            in
                ( { audioPlayer | playlistLength = playlistLength }
                , generatePlaylist
                )

        ToggleMute ->
            let
                ( cmd, newStatus ) =
                    case audioPlayer.status of
                        Muted status ->
                            ( Ports.setVolume audioPlayer.volume, status )

                        status ->
                            ( Ports.setVolume 0, Muted status )
            in
                ( { audioPlayer | status = newStatus }, cmd )


containVolume : Int -> Int
containVolume volume =
    let
        maxVolume =
            100

        minVolume =
            0
    in
        if volume < minVolume then
            minVolume
        else if volume > maxVolume then
            maxVolume
        else
            volume


nextTrackNumberRequested : (Msg -> msg) -> Cmd msg
nextTrackNumberRequested audioPlayerMsg =
    audioPlayerMsg NextTrackNumberRequested
        |> Task.succeed
        |> Task.perform identity
