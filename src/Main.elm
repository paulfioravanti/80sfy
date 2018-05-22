module Main exposing (main)

import Animation
import Gif
import Html.Styled as Html exposing (Html, text, div, h1, img, p, video)
import Html.Styled.Attributes exposing (attribute, css, fromUnstyled, property, src, style)
import Json.Encode as Encode
import Model exposing (Model)
import Msg exposing (Msg(..))
import Player exposing (..)
import RemoteData exposing (RemoteData(..), WebData)
import Styles
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

        _ ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    case ( model.player1.gifUrl, model.player2.gifUrl ) of
        ( Success player1GifUrl, Success player2GifUrl ) ->
            div [ attribute "data-name" "container" ]
                [ player model.player1 player1GifUrl
                , player model.player2 player2GifUrl
                ]

        _ ->
            p [] [ text "" ]


player : Player -> String -> Html msg
player player gifUrl =
    let
        ( zIndex, name ) =
            case player.id of
                Player1 ->
                    ( 0, "player-1" )

                Player2 ->
                    ( 1, "player-2" )

        true =
            Encode.string "true"
    in
        div
            (List.map fromUnstyled (Animation.render player.style)
                ++ [ css [ Styles.playerGifContainer zIndex ]
                   , attribute "data-name" "player-gif-container"
                   ]
            )
            [ video
                [ src gifUrl
                , css [ Styles.videoPlayer ]
                , attribute "data-name" name
                , property "autoplay" true
                , property "loop" true
                ]
                []
            ]



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
        { view = view
        , init = Model.init
        , update = update
        , subscriptions = subscriptions
        }
