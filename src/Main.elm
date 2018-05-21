module Main exposing (main)

import Animation
import Gif
import Html exposing (Html, text, div, h1, img, p, video)
import Html.Attributes exposing (attribute, property, src, style)
import Http exposing (Error)
import Json.Encode as Encode
import Model exposing (Model)
import Msg exposing (Msg(..))
import RemoteData exposing (RemoteData(..), WebData)
import Task
import Time exposing (Time)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Animate msg ->
            ( { model
                | player1Style = Animation.update msg model.player1Style
              }
            , Cmd.none
            )

        FadeOutFadeIn () ->
            ( { model
                | player1Style =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.opacity 0 ]
                        , Animation.to
                            [ Animation.opacity 1 ]
                        ]
                        model.player1Style
              }
            , Cmd.none
            )

        GetNextGif time ->
            ( model
            , Cmd.batch
                [ Gif.random
                , Task.succeed ()
                    |> Task.perform FadeOutFadeIn
                ]
            )

        GetRandomGif (Ok imageUrl) ->
            ( { model | player1GifUrl = Success imageUrl }, Cmd.none )

        GetRandomGif (Err error) ->
            ( model, Cmd.none )

        RandomTag tag ->
            ( model, Gif.fetchRandomGif tag )

        _ ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    case model.player1GifUrl of
        NotRequested ->
            p [] [ text "" ]

        Requesting ->
            p [] [ text "" ]

        Success player1GifUrl ->
            div [ attribute "data-name" "container" ]
                [ div (Animation.render model.player1Style)
                    [ video
                        [ src player1GifUrl
                        , attribute "data-name" "player-1"
                        , style
                            [ ( "height", "100%" )
                            , ( "maxWidth", "100%" )
                            , ( "width", "100%" )
                            , ( "margin", "0 auto" )
                            ]
                        , property "autoplay" (Encode.string "true")
                        , property "loop" (Encode.string "true")
                        ]
                        []
                    ]
                , div [ style [ ( "display", "none" ) ] ]
                    [ video
                        [ src player1GifUrl
                        , attribute "data-name" "player-2"
                        , style
                            [ ( "height", "100%" )
                            , ( "maxWidth", "100%" )
                            , ( "width", "100%" )
                            , ( "margin", "0 auto" )
                            ]
                        , property "autoplay" (Encode.string "true")
                        , property "loop" (Encode.string "true")
                        ]
                        []
                    ]
                ]

        _ ->
            p [] [ text "Something went wrong" ]



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every (7 * Time.second) GetNextGif
        , Animation.subscription Animate [ model.player1Style ]
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
