module Update exposing (update)

import ControlPanel
import Gif
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( Animate
            , CrossFade
            , GetNextGif
            , GetRandomGif
            , HideControlPanel
            , RandomTag
            , ShowControlPanel
            , Tick
            , UseControlPanel
            )
        )
import Player exposing (PlayerId(Player1, Player2))
import Task


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Animate msg ->
            let
                player1 =
                    model.player1
                        |> Player.updateStyle msg

                controlPanel =
                    model.controlPanel
                        |> ControlPanel.updateStyle msg
            in
                ( { model
                    | controlPanel = controlPanel
                    , player1 = player1
                  }
                , Cmd.none
                )

        CrossFade time ->
            let
                { player1, player2 } =
                    model

                willBeHiddenPlayer =
                    if player1.visible then
                        player1
                    else
                        player2

                newPlayer1 =
                    player1
                        |> Player.updateVisibility
            in
                ( { model | player1 = newPlayer1 }
                , Task.succeed willBeHiddenPlayer
                    |> Task.perform GetNextGif
                )

        GetNextGif hiddenPlayer ->
            ( model, Gif.random hiddenPlayer )

        GetRandomGif playerId (Ok gifUrl) ->
            case playerId of
                Player1 ->
                    let
                        player1 =
                            model.player1
                                |> Player.setGifUrl gifUrl
                    in
                        ( { model | player1 = player1 }, Cmd.none )

                Player2 ->
                    let
                        player2 =
                            model.player2
                                |> Player.setGifUrl gifUrl
                    in
                        ( { model | player2 = player2 }, Cmd.none )

        GetRandomGif player (Err error) ->
            ( model, Cmd.none )

        HideControlPanel () ->
            let
                newControlPanel =
                    model.controlPanel
                        |> ControlPanel.hide
            in
                ( { model | controlPanel = newControlPanel }
                , Cmd.none
                )

        UseControlPanel bool ->
            let
                newControlPanel =
                    model.controlPanel
                        |> ControlPanel.setInUse bool
            in
                ( { model | controlPanel = newControlPanel }, Cmd.none )

        RandomTag player tag ->
            ( model, Gif.fetchRandomGif player tag )

        ShowControlPanel ->
            let
                newControlPanel =
                    model.controlPanel
                        |> ControlPanel.show
            in
                ( { model | controlPanel = newControlPanel }
                , Cmd.none
                )

        Tick time ->
            let
                ( seconds, cmd ) =
                    if model.controlPanelSecondsOpen > 2 then
                        ( 0, Task.perform HideControlPanel (Task.succeed ()) )
                    else
                        ( model.controlPanelSecondsOpen + 1, Cmd.none )
            in
                ( { model | controlPanelSecondsOpen = seconds }, cmd )
