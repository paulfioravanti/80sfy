module View exposing (view)

import ControlPanel
import Html.Styled exposing (Html, div)
import Html.Styled.Attributes exposing (attribute)
import Model exposing (Model)
import MsgConfig exposing (MsgConfig)
import SecretConfig
import VideoPlayer


view : MsgConfig msg -> Model -> Html msg
view msgConfig model =
    div [ attribute "data-name" "container" ]
        [ ControlPanel.view msgConfig model.audioPlayer model.controlPanel
        , VideoPlayer.view msgConfig model.videoPlayer1
        , VideoPlayer.view msgConfig model.videoPlayer2
        , SecretConfig.view msgConfig model.secretConfig
        ]
