module Main exposing (main)

import Animation
import Gif
import Html.Styled as Html
import Model exposing (Model)
import Msg
    exposing
        ( Msg(Animate, CrossFade, GetNextGif, GetRandomGif, RandomTag)
        )
import Player exposing (PlayerId(Player1, Player2))
import RemoteData exposing (RemoteData(Success), WebData)
import Task
import Time exposing (Time)
import View


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Animate msg ->
            let
                player1 =
                    model.player1
                        |> Player.setStyle msg
            in
                ( { model | player1 = player1 }
                , Cmd.none
                )

        CrossFade visiblePlayerId hiddenPlayerId time ->
            let
                currentPlayer1 =
                    model.player1

                ( player1Opacity, player1Visibility ) =
                    case visiblePlayerId of
                        Player1 ->
                            ( 0, False )

                        Player2 ->
                            ( 1, True )

                player1 =
                    { currentPlayer1
                        | style =
                            Animation.interrupt
                                [ Animation.to
                                    [ Animation.opacity player1Opacity ]
                                ]
                                currentPlayer1.style
                        , visible = player1Visibility
                    }
            in
                ( { model | player1 = player1 }
                , Task.succeed visiblePlayerId
                    |> Task.perform GetNextGif
                )

        GetNextGif hiddenPlayerId ->
            ( model
            , Gif.random hiddenPlayerId
            )

        GetRandomGif playerId (Ok imageUrl) ->
            let
                newModel =
                    case playerId of
                        Player1 ->
                            let
                                currentPlayer1 =
                                    model.player1

                                player1 =
                                    { currentPlayer1
                                        | gifUrl = Success imageUrl
                                    }
                            in
                                { model | player1 = player1 }

                        Player2 ->
                            let
                                currentPlayer2 =
                                    model.player2

                                player2 =
                                    { currentPlayer2
                                        | gifUrl = Success imageUrl
                                    }
                            in
                                { model | player2 = player2 }
            in
                ( newModel, Cmd.none )

        GetRandomGif player (Err error) ->
            ( model, Cmd.none )

        RandomTag playerId tag ->
            ( model, Gif.fetchRandomGif playerId tag )



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions { player1, player2 } =
    let
        ( visiblePlayerId, hiddenPlayerId ) =
            if player1.visible == True then
                ( player1.id, player2.id )
            else
                ( player2.id, player1.id )
    in
        Sub.batch
            [ Time.every (4 * Time.second)
                (CrossFade visiblePlayerId hiddenPlayerId)
            , Animation.subscription Animate
                [ player1.style
                , player2.style
                ]
            ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = View.view
        , init = Model.init
        , update = update
        , subscriptions = subscriptions
        }
