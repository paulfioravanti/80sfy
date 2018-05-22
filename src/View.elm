module View exposing (view)

import Animation
import Html.Styled as Html exposing (Html, text, div, p, video)
import Html.Styled.Attributes
    exposing
        ( attribute
        , css
        , fromUnstyled
        , property
        , src
        , style
        )
import Json.Encode as Encode
import Model exposing (Model)
import Msg exposing (Msg)
import Player exposing (Player, PlayerId(Player1, Player2))
import RemoteData exposing (RemoteData(Success))
import Styles


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
        videoName =
            player.id
                |> toString
                |> String.toLower

        true =
            Encode.string "true"

        animations =
            player.style
                |> Animation.render
                |> List.map fromUnstyled

        attributes =
            [ css [ Styles.playerGifContainer player.zIndex ]
            , attribute "data-name" "player-gif-container"
            ]
    in
        div (List.append animations attributes)
            [ video
                [ src gifUrl
                , css [ Styles.videoPlayer ]
                , attribute "data-name" videoName
                , property "autoplay" true
                , property "loop" true
                ]
                []
            ]
