module Main exposing (main)

import Animation
import Gif
import Html exposing (Html, text, div, h1, img, p, video)
import Html.Attributes exposing (attribute, property, src, style)
import Json.Encode as Encode
import Model exposing (Model)
import Msg exposing (Msg(..))
import Player exposing (..)
import RemoteData exposing (RemoteData(..), WebData)
import Task
import Time exposing (Time)


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

        CrossFade ( visiblePlayerId, hiddenPlayerId ) ->
            let
                currentPlayer1 =
                    model.player1

                currentPlayer2 =
                    model.player2

                ( player1Opacity, player1Visibility, player2Opacity, player2Visibility ) =
                    case visiblePlayerId of
                        Player1 ->
                            ( 0, False, 1, True )

                        Player2 ->
                            ( 1, True, 0, False )

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
                , Cmd.none
                )

        GetNextGif visiblePlayer hiddenPlayer time ->
            ( model
            , Cmd.batch
                [ Gif.random visiblePlayer
                , Task.succeed ( visiblePlayer.id, hiddenPlayer.id )
                    |> Task.perform CrossFade
                ]
            )

        GetRandomGif player (Ok imageUrl) ->
            let
                newModel =
                    case player.id of
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

        _ ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    case ( model.player1.gifUrl, model.player2.gifUrl ) of
        ( Success player1GifUrl, Success player2GifUrl ) ->
            div [ attribute "data-name" "container" ]
                [ div (Animation.render model.player1.style)
                    [ video
                        [ src player1GifUrl
                        , attribute "data-name" "player-1"
                        , style
                            [ ( "height", "100%" )
                            , ( "maxWidth", "100%" )
                            , ( "width", "100%" )
                            , ( "margin", "0 auto" )
                            , ( "object-fit", "cover" )
                            ]
                        , property "autoplay" (Encode.string "true")
                        , property "loop" (Encode.string "true")
                        ]
                        []
                    ]
                , div (Animation.render model.player2.style)
                    [ video
                        [ src player2GifUrl
                        , attribute "data-name" "player-2"
                        , style
                            [ ( "height", "100%" )
                            , ( "maxWidth", "100%" )
                            , ( "width", "100%" )
                            , ( "margin", "0 auto" )
                            , ( "object-fit", "cover" )
                            ]
                        , property "autoplay" (Encode.string "true")
                        , property "loop" (Encode.string "true")
                        ]
                        []
                    ]
                ]

        _ ->
            p [] [ text "" ]



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        ( visiblePlayer, hiddenPlayer ) =
            if model.player1.visible == True then
                ( model.player1, model.player2 )
            else
                ( model.player2, model.player1 )
    in
        Sub.batch
            [ Time.every (7 * Time.second)
                (GetNextGif visiblePlayer hiddenPlayer)
            , Animation.subscription Animate
                [ model.player1.style
                , model.player2.style
                ]
            ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = Model.init
        , update = update
        , subscriptions = subscriptions
        }
