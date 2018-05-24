module View exposing (view)

import Animation
import Html.Styled as Html exposing (Html, div, p, text, video)
import Html.Styled.Attributes exposing (attribute, css, fromUnstyled)
import Html.Styled.Events exposing (onMouseEnter, onMouseLeave)
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
                    , VideoPlayer.view model.player1 player1GifUrl
                    , VideoPlayer.view model.player2 player2GifUrl
                    ]

        _ ->
            p [] [ text "" ]
