module View exposing (view)

import AudioPlayer
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
        [ ControlPanel.view
            msgRouter
            model.browser
            model.audioPlayer
            model.controlPanel
        , VideoPlayer.view
            msgRouter
            model.browser
            (AudioPlayer.isPlaying model.audioPlayer)
            model.videoPlayer1
        , VideoPlayer.view
            msgRouter
            model.browser
            (AudioPlayer.isPlaying model.audioPlayer)
            model.videoPlayer2
        , SecretConfig.view msgRouter model.secretConfig
        ]
