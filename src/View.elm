module View exposing (view)

import ControlPanel
import Html.Styled as Html exposing (Html, div, text)
import Html.Styled.Attributes exposing (attribute)
import Model exposing (Model)
import Msg exposing (Msg(ConfigMsg, SecretConfigMsg, VideoPlayerMsg))
import MsgConfig
import SecretConfig
import VideoPlayer exposing (VideoPlayer)


view : Model -> Html Msg
view { audioPlayer, controlPanel, secretConfig, videoPlayer1, videoPlayer2 } =
    let
        msgConfig =
            MsgConfig.init ConfigMsg SecretConfigMsg VideoPlayerMsg
    in
        div [ attribute "data-name" "container" ]
            [ ControlPanel.view audioPlayer controlPanel
            , VideoPlayer.view msgConfig videoPlayer1
            , VideoPlayer.view msgConfig videoPlayer2
            , SecretConfig.view msgConfig secretConfig
            ]
