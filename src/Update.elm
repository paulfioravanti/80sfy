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
                player1 =
                    model.player1
                        |> VideoPlayer.animateStyle msg

                controlPanel =
                    model.controlPanel
                        |> ControlPanel.animateStyle msg
            in
                ( { model | controlPanel = controlPanel, player1 = player1 }
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
                ( newPlayer1Visibility, nowHiddenPlayerId ) =
                    model.player1
                        |> VideoPlayer.newVisibility

                player1 =
                    model.player1
                        |> VideoPlayer.updateVisibility newPlayer1Visibility
            in
                ( { model | player1 = player1 }
                , Task.succeed nowHiddenPlayerId
                    |> Task.perform FetchNextGif
                )

        FetchNextGif hiddenPlayerId ->
            ( model, Gif.random model.config.tags hiddenPlayerId )

        FetchRandomGif playerId (Ok gifUrl) ->
            if playerId == "1" then
                let
                    player1 =
                        model.player1
                            |> VideoPlayer.setSuccessGifUrl gifUrl
                in
                    ( { model | player1 = player1 }, Cmd.none )
            else
                let
                    player2 =
                        model.player2
                            |> VideoPlayer.setSuccessGifUrl gifUrl
                in
                    ( { model | player2 = player2 }, Cmd.none )

        FetchRandomGif playerId (Err error) ->
            let
                _ =
                    Debug.log
                        ("FetchRandomGif Failed for " ++ toString playerId)
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

        RandomTag playerId tag ->
            ( model
            , Gif.fetchRandomGif model.config.giphyApiKey playerId tag
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
