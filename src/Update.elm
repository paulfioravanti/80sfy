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
            ( AudioPlayerMsg
            , ConfigMsg
            , ControlPanelMsg
            , CrossFadePlayers
            , FetchTags
            , InitSecretConfigTags
            , RandomTag
            , SecretConfigMsg
            , VideoPlayerMsg
            )
        )
import MsgConfig
import SecretConfig
import VideoPlayer


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        msgConfig =
            MsgConfig.init
                AudioPlayerMsg
                ConfigMsg
                ControlPanelMsg
                SecretConfigMsg
                VideoPlayerMsg
    in
        case msg of
            AudioPlayerMsg msg ->
                let
                    ( audioPlayer, cmd ) =
                        model.audioPlayer
                            |> AudioPlayer.update msg
                in
                    ( { model | audioPlayer = audioPlayer }
                    , cmd
                    )

            ConfigMsg msg ->
                let
                    ( config, cmd ) =
                        model.config
                            |> Config.update msg
                in
                    ( { model | config = config }
                    , cmd
                    )

            ControlPanelMsg msg ->
                let
                    ( controlPanel, cmd ) =
                        model.controlPanel
                            |> ControlPanel.update msgConfig msg
                in
                    ( { model | controlPanel = controlPanel }
                    , cmd
                    )

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
                    , Gif.random model.config.tags nowHiddenVideoPlayerId
                    )

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
                        , SecretConfig.initTagsTask tags
                        ]
                    )

            FetchTags (Err error) ->
                let
                    _ =
                        Debug.log "FetchTags Failed" error
                in
                    ( model, Cmd.none )

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
                , Gif.fetchRandomGif
                    msgConfig
                    model.config.giphyApiKey
                    videoPlayerId
                    tag
                )

            SecretConfigMsg msg ->
                let
                    ( secretConfig, cmd ) =
                        model.secretConfig
                            |> SecretConfig.update msgConfig msg
                in
                    ( { model | secretConfig = secretConfig }
                    , cmd
                    )

            VideoPlayerMsg msg ->
                let
                    ( videoPlayer1, videoPlayer2, cmd ) =
                        VideoPlayer.update
                            msg
                            model.videoPlayer1
                            model.videoPlayer2
                in
                    ( { model
                        | videoPlayer1 = videoPlayer1
                        , videoPlayer2 = videoPlayer2
                      }
                    , Cmd.map VideoPlayerMsg cmd
                    )
