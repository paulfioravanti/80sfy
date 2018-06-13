module View exposing (view)

import ControlPanel
import Html.Styled exposing (Html, div)
import Html.Styled.Attributes exposing (attribute)
import Model exposing (Model)
import MsgRouter exposing (MsgRouter)
import SecretConfig
import VideoPlayer


view : MsgRouter msg -> Model -> Html msg
view msgRouter model =
    div [ attribute "data-name" "container" ]
        [ ControlPanel.view msgRouter model.audioPlayer model.controlPanel
        , VideoPlayer.view
            msgRouter
            model.videoPlayer1
            model.audioPlayer.playing
        , VideoPlayer.view
            msgRouter
            model.videoPlayer2
            model.audioPlayer.playing
        , SecretConfig.view msgRouter model.secretConfig
        ]
