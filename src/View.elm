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
import Html.Styled.Events exposing (onMouseEnter, onMouseLeave)
import Json.Encode as Encode
import Model exposing (Model)
import Msg exposing (Msg(ShowControlPanel, UseControlPanel))
import RemoteData exposing (RemoteData(Success))
import Styles
import VideoPlayer exposing (VideoPlayer, VideoPlayerId(Player1, Player2))


view : Model -> Html Msg
view model =
    case ( model.player1.gifUrl, model.player2.gifUrl ) of
        ( Success player1GifUrl, Success player2GifUrl ) ->
            let
                animations =
                    model.controlPanel.style
                        |> Animation.render
                        |> List.map fromUnstyled
            in
                div [ attribute "data-name" "container" ]
                    [ div
                        (animations
                            ++ [ css [ Styles.controlPanel ]
                               , attribute "data-name" "control-panel"
                               , onMouseEnter (UseControlPanel True)
                               , onMouseLeave (UseControlPanel False)
                               ]
                        )
                        []
                    , videoPlayer model.player1 player1GifUrl
                    , videoPlayer model.player2 player2GifUrl
                    ]

        _ ->
            p [] [ text "" ]


videoPlayer : VideoPlayer -> String -> Html msg
videoPlayer player gifUrl =
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
