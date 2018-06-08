module View exposing (view)

import ControlPanel
import Html.Styled as Html exposing (Html, div, text)
import Html.Styled.Attributes exposing (attribute)
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( AudioPlayerMsg
            , ConfigMsg
            , ControlPanelMsg
            , SecretConfigMsg
            , VideoPlayerMsg
            )
        )
import MsgConfig exposing (MsgConfig)
import SecretConfig
import VideoPlayer exposing (VideoPlayer)


view : MsgConfig msg -> Model -> Html msg
view msgConfig { audioPlayer, controlPanel, secretConfig, videoPlayer1, videoPlayer2 } =
    div [ attribute "data-name" "container" ]
        [ ControlPanel.view msgConfig audioPlayer controlPanel
        , VideoPlayer.view msgConfig videoPlayer1
        , VideoPlayer.view msgConfig videoPlayer2
        , SecretConfig.view msgConfig secretConfig
        ]
