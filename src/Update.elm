module Update exposing (update)

import ControlPanel
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
            , HideControlPanel
            , RandomTag
            , ShowControlPanel
            , UseControlPanel
            )
        )
import VideoPlayer exposing (VideoPlayerId(Player1, Player2))
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
                ( newPlayer1Visibility, nowHiddenPlayer ) =
                    model
                        |> Model.determineNewPlayerVisibility

                player1 =
                    model.player1
                        |> VideoPlayer.updateVisibility newPlayer1Visibility
            in
                ( { model | player1 = player1 }
                , Task.succeed nowHiddenPlayer.id
                    |> Task.perform FetchNextGif
                )

        FetchNextGif hiddenPlayerId ->
            ( model, Gif.random hiddenPlayerId )

        FetchRandomGif playerId (Ok gifUrl) ->
            case playerId of
                Player1 ->
                    let
                        player1 =
                            model.player1
                                |> VideoPlayer.setSuccessGifUrl gifUrl
                    in
                        ( { model | player1 = player1 }, Cmd.none )

                Player2 ->
                    let
                        player2 =
                            model.player2
                                |> VideoPlayer.setSuccessGifUrl gifUrl
                    in
                        ( { model | player2 = player2 }, Cmd.none )

        FetchRandomGif playerId (Err error) ->
            case playerId of
                Player1 ->
                    let
                        player1 =
                            model.player1
                                |> VideoPlayer.setFailureGifUrl error
                    in
                        ( { model | player1 = player1 }, Cmd.none )

                Player2 ->
                    let
                        player2 =
                            model.player2
                                |> VideoPlayer.setFailureGifUrl error
                    in
                        ( { model | player2 = player2 }, Cmd.none )

        HideControlPanel () ->
            let
                controlPanel =
                    model.controlPanel
                        |> ControlPanel.hide
            in
                ( { model | controlPanel = controlPanel }
                , Cmd.none
                )

        RandomTag player tag ->
            ( model, Gif.fetchRandomGif player tag )

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
