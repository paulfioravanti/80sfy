module Update exposing (update)

import AudioPlayer
import Config
import ControlPanel
import Debug
import Gif
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( AdjustVolume
            , AnimateControlPanel
            , AnimateVideoPlayer
            , CountdownToHideControlPanel
            , CrossFadePlayers
            , FetchNextGif
            , FetchRandomGif
            , FetchTags
            , HideControlPanel
            , InitSecretConfigTags
            , RandomTag
            , SaveConfig
            , ShowControlPanel
            , ToggleGifRotation
            , ToggleInactivityPause
            , ToggleFullScreen
            , ToggleMute
            , TogglePlaying
            , TogglePlayPause
            , ToggleSecretConfigVisibility
            , UseControlPanel
            , UpdateSecretConfigTags
            , UpdateSecretConfigSoundCloudPlaylistUrl
            )
        )
import SecretConfig
import VideoPlayer
import Task


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AdjustVolume volume ->
            let
                audioPlayer =
                    model.audioPlayer
                        |> AudioPlayer.adjustVolume volume
            in
                ( { model | audioPlayer = audioPlayer }
                , Cmd.none
                )

        AnimateControlPanel msg ->
            let
                controlPanel =
                    model.controlPanel
                        |> ControlPanel.animateStyle msg
            in
                ( { model | controlPanel = controlPanel }
                , Cmd.none
                )

        AnimateVideoPlayer msg ->
            let
                videoPlayer1 =
                    model.videoPlayer1
                        |> VideoPlayer.animateStyle msg
            in
                ( { model | videoPlayer1 = videoPlayer1 }
                , Cmd.none
                )

        CountdownToHideControlPanel time ->
            let
                ( controlPanel, cmd ) =
                    model.controlPanel
                        |> ControlPanel.determineVisibility
            in
                ( { model | controlPanel = controlPanel }, cmd )

        CrossFadePlayers time ->
            let
                ( newVideoPlayer1Visibility, nowHiddenVideoPlayerId ) =
                    model.videoPlayer1
                        |> VideoPlayer.newVisibility

                videoPlayer1 =
                    model.videoPlayer1
                        |> VideoPlayer.updateVisibility
                            newVideoPlayer1Visibility
            in
                ( { model | videoPlayer1 = videoPlayer1 }
                , Task.succeed nowHiddenVideoPlayerId
                    |> Task.perform FetchNextGif
                )

        FetchNextGif hiddenVideoPlayerId ->
            ( model, Gif.random model.config.tags hiddenVideoPlayerId )

        FetchRandomGif videoPlayerId (Ok gifUrl) ->
            if videoPlayerId == "1" then
                let
                    videoPlayer1 =
                        model.videoPlayer1
                            |> VideoPlayer.setSuccessGifUrl gifUrl
                in
                    ( { model | videoPlayer1 = videoPlayer1 }, Cmd.none )
            else
                let
                    videoPlayer2 =
                        model.videoPlayer2
                            |> VideoPlayer.setSuccessGifUrl gifUrl
                in
                    ( { model | videoPlayer2 = videoPlayer2 }, Cmd.none )

        FetchRandomGif videoPlayerId (Err error) ->
            let
                _ =
                    Debug.log
                        ("FetchRandomGif Failed for " ++ toString videoPlayerId)
                        error
            in
                ( model, Cmd.none )

        FetchTags (Ok tags) ->
            let
                config =
                    model.config
                        |> Config.setTags tags
            in
                ( { model | config = config }
                , Cmd.batch
                    [ Gif.random tags "1"
                    , Gif.random tags "2"
                    , Task.succeed tags
                        |> Task.perform InitSecretConfigTags
                    ]
                )

        FetchTags (Err error) ->
            let
                _ =
                    Debug.log "FetchTags Failed" error
            in
                ( model, Cmd.none )

        HideControlPanel () ->
            let
                controlPanel =
                    model.controlPanel
                        |> ControlPanel.hide
            in
                ( { model | controlPanel = controlPanel }, Cmd.none )

        InitSecretConfigTags tags ->
            let
                secretConfig =
                    model.secretConfig
                        |> SecretConfig.initTags tags
            in
                ( { model | secretConfig = secretConfig }
                , Cmd.none
                )

        RandomTag videoPlayerId tag ->
            ( model
            , Gif.fetchRandomGif model.config.giphyApiKey videoPlayerId tag
            )

        SaveConfig ->
            let
                config =
                    model.config
                        |> Config.updateSettings model.secretConfig
            in
                ( { model | config = config }, Cmd.none )

        ShowControlPanel ->
            let
                controlPanel =
                    model.controlPanel
                        |> ControlPanel.show
            in
                ( { model | controlPanel = controlPanel }, Cmd.none )

        ToggleGifRotation bool ->
            let
                secretConfig =
                    model.secretConfig
                        |> SecretConfig.toggleFetchNextGif bool
            in
                ( { model | secretConfig = secretConfig }
                , Task.succeed bool
                    |> Task.perform TogglePlaying
                )

        ToggleFullScreen ->
            ( model, VideoPlayer.toggleFullScreen )

        ToggleInactivityPause ->
            let
                secretConfig =
                    model.secretConfig
                        |> SecretConfig.toggleInactivityPause
            in
                ( { model | secretConfig = secretConfig }, Cmd.none )

        ToggleMute ->
            let
                audioPlayer =
                    model.audioPlayer
                        |> AudioPlayer.toggleMute
            in
                ( { model | audioPlayer = audioPlayer }, Cmd.none )

        TogglePlaying bool ->
            let
                videoPlayer1 =
                    model.videoPlayer1
                        |> VideoPlayer.togglePlaying bool

                videoPlayer2 =
                    model.videoPlayer2
                        |> VideoPlayer.togglePlaying bool
            in
                ( { model
                    | videoPlayer1 = videoPlayer1
                    , videoPlayer2 = videoPlayer2
                  }
                , VideoPlayer.toggleVideoPlay bool
                )

        TogglePlayPause ->
            let
                audioPlayer =
                    model.audioPlayer
                        |> AudioPlayer.togglePlayPause
            in
                ( { model | audioPlayer = audioPlayer }, Cmd.none )

        ToggleSecretConfigVisibility ->
            let
                secretConfig =
                    model.secretConfig
                        |> SecretConfig.toggleVisibility
            in
                ( { model | secretConfig = secretConfig }, Cmd.none )

        UseControlPanel bool ->
            let
                controlPanel =
                    model.controlPanel
                        |> ControlPanel.setInUse bool
            in
                ( { model | controlPanel = controlPanel }, Cmd.none )

        UpdateSecretConfigSoundCloudPlaylistUrl url ->
            let
                secretConfig =
                    model.secretConfig
                        |> SecretConfig.setSoundCloudPlaylistUrl url
            in
                ( { model | secretConfig = secretConfig }, Cmd.none )

        UpdateSecretConfigTags tags ->
            let
                secretConfig =
                    model.secretConfig
                        |> SecretConfig.setTags tags
            in
                ( { model | secretConfig = secretConfig }, Cmd.none )
