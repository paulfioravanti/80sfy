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
                ( newPlayer1Visibility, nowHiddenPlayer ) =
                    model
                        |> Model.determineNewPlayerVisibility

                player1 =
                    model.player1
                        |> Player.updateVisibility newPlayer1Visibility
            in
                ( { model | player1 = player1 }
                , Task.succeed nowHiddenPlayer
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
                controlPanel =
                    model.controlPanel
                        |> ControlPanel.hide
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

        Tick time ->
            let
                controlPanel =
                    model.controlPanel

                ( newControlPanel, cmd ) =
                    if controlPanel.secondsOpen > 2 then
                        ( ControlPanel.resetSecondsOpen controlPanel
                        , Task.perform HideControlPanel (Task.succeed ())
                        )
                    else
                        ( ControlPanel.incrementSecondsOpen controlPanel
                        , Cmd.none
                        )
            in
                ( { model | controlPanel = newControlPanel }, cmd )
