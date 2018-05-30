module Update exposing (update)

import Config
import ControlPanel
import Debug
import Gif
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( Animate
            , CountdownToHideControlPanel
            , CrossFadePlayers
            , FetchNextGif
            , FetchRandomGif
            , FetchTags
            , HideControlPanel
            , RandomTag
            , ShowControlPanel
            , UseControlPanel
            )
        )
import VideoPlayer
import Task


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Animate msg ->
            let
                videoPlayer1 =
                    model.videoPlayer1
                        |> VideoPlayer.animateStyle msg

                controlPanel =
                    model.controlPanel
                        |> ControlPanel.animateStyle msg
            in
                ( { model
                    | controlPanel = controlPanel
                    , videoPlayer1 = videoPlayer1
                  }
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
                ( { model | controlPanel = controlPanel }
                , Cmd.none
                )

        RandomTag videoPlayerId tag ->
            ( model
            , Gif.fetchRandomGif model.config.giphyApiKey videoPlayerId tag
            )

        ShowControlPanel ->
            let
                controlPanel =
                    model.controlPanel
                        |> ControlPanel.show
            in
                ( { model | controlPanel = controlPanel }
                , Cmd.none
                )

        UseControlPanel bool ->
            let
                controlPanel =
                    model.controlPanel
                        |> ControlPanel.setInUse bool
            in
                ( { model | controlPanel = controlPanel }, Cmd.none )
