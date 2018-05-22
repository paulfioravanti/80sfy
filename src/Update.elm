module Update exposing (update)

import Gif
import Model exposing (Model)
import Msg
    exposing
        ( Msg(Animate, CrossFade, GetNextGif, GetRandomGif, RandomTag)
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
            in
                ( { model | player1 = player1 }, Cmd.none )

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

        GetRandomGif player (Ok gifUrl) ->
            case player.id of
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

        RandomTag player tag ->
            ( model, Gif.fetchRandomGif player tag )
