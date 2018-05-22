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
                currentPlayer1 =
                    model.player1

                player1 =
                    { currentPlayer1
                        | style = Animation.update msg currentPlayer1.style
                    }

                currentPlayer2 =
                    model.player2

                player2 =
                    { currentPlayer2
                        | style = Animation.update msg currentPlayer2.style
                    }
            in
                ( { model | player1 = player1, player2 = player2 }
                , Cmd.none
                )

        CrossFade visiblePlayerId hiddenPlayerId time ->
            let
                currentPlayer1 =
                    model.player1

                currentPlayer2 =
                    model.player2

                ( player1Opacity, player1Visibility, player1ZIndex, player2Opacity, player2Visibility ) =
                    case visiblePlayerId of
                        Player1 ->
                            ( 0, False, "0", 1, True )

                        Player2 ->
                            ( 1, True, "1000", 0, False )

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

                player2 =
                    { currentPlayer2
                        | style =
                            Animation.interrupt
                                [ Animation.to
                                    [ Animation.opacity player2Opacity ]
                                ]
                                currentPlayer2.style
                        , visible = player2Visibility
                    }
            in
                ( { model | player1 = player1, player2 = player2 }
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

        RandomTag player tag ->
            ( model, Gif.fetchRandomGif player tag )



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        ( player1, player2 ) =
            ( model.player1, model.player2 )

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
