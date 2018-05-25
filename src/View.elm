module View exposing (view)

import ControlPanel
import Html.Styled as Html exposing (Html, div, text)
import Html.Styled.Attributes exposing (attribute)
import Model exposing (Model)
import Msg exposing (Msg)
import RemoteData exposing (RemoteData(Success))
import VideoPlayer exposing (VideoPlayer, VideoPlayerId(Player1, Player2))


view : Model -> Html Msg
view { controlPanel, player1, player2 } =
    let
        visiblePlayer =
            if player1.visible then
                player1
            else
                player2
    in
        case (visiblePlayer.gifUrl) of
            Success gifUrl ->
                div [ attribute "data-name" "container" ]
                    [ ControlPanel.view controlPanel
                    , VideoPlayer.view player1
                    , VideoPlayer.view player2
                    ]

            _ ->
                text ""
