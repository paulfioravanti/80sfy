module View exposing (view)

import AudioPlayer
import Browser exposing (Document)
import ControlPanel
import Html.Styled exposing (div)
import Html.Styled.Attributes exposing (attribute)
import Model exposing (Model)
import MsgRouter exposing (MsgRouter)
import SecretConfig
import VideoPlayer


view : MsgRouter msg -> Model -> Document msg
view msgRouter model =
    let
        { audioPlayerMsg, controlPanelMsg, fullScreenMsg, noOpMsg, pauseMsg, playMsg, videoPlayerMsg } =
            msgRouter
    in
    { title = "Welcome back to the 80s -- this is 80sfy."
    , body =
        List.map Html.Styled.toUnstyled
            [ div [ attribute "data-name" "container" ]
                [ ControlPanel.view
                    audioPlayerMsg
                    controlPanelMsg
                    fullScreenMsg
                    pauseMsg
                    playMsg
                    model.browserVendor
                    model.audioPlayer
                    model.controlPanel
                , VideoPlayer.view
                    fullScreenMsg
                    noOpMsg
                    videoPlayerMsg
                    model.browserVendor
                    (AudioPlayer.isPlaying model.audioPlayer)
                    model.videoPlayer1
                , VideoPlayer.view
                    fullScreenMsg
                    noOpMsg
                    videoPlayerMsg
                    model.browserVendor
                    (AudioPlayer.isPlaying model.audioPlayer)
                    model.videoPlayer2
                , SecretConfig.view msgRouter model.secretConfig
                ]
            ]
    }
