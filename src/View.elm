module View exposing (view)

import AudioPlayer
import Browser exposing (Document)
import ControlPanel
import Html.Styled exposing (div)
import Html.Styled.Attributes exposing (attribute)
import Model exposing (Model)
import Msg exposing (Msg)
import SecretConfig
import VideoPlayer


view : Model -> Document Msg
view model =
    let
        msgs =
            { audioPlayerMsg = Msg.AudioPlayer
            , controlPanelMsg = Msg.ControlPanel
            , fullScreenMsg = Msg.FullScreen
            , noOpMsg = Msg.NoOp
            , pauseMsg = Msg.Pause
            , playMsg = Msg.Play
            , saveConfigMsg = Msg.SaveConfig
            , secretConfigMsg = Msg.SecretConfig
            , showApplicationStateMsg = Msg.ShowApplicationState
            , videoPlayerMsg = Msg.VideoPlayer
            }
    in
    { title = "Welcome back to the 80s -- this is 80sfy."
    , body =
        List.map Html.Styled.toUnstyled
            [ div [ attribute "data-name" "container" ]
                [ ControlPanel.view msgs model
                , VideoPlayer.view
                    Msg.FullScreen
                    Msg.NoOp
                    Msg.VideoPlayer
                    model.browserVendor
                    (AudioPlayer.isPlaying model.audioPlayer)
                    model.videoPlayer1
                , VideoPlayer.view
                    Msg.FullScreen
                    Msg.NoOp
                    Msg.VideoPlayer
                    model.browserVendor
                    (AudioPlayer.isPlaying model.audioPlayer)
                    model.videoPlayer2
                , SecretConfig.view
                    Msg.AudioPlayer
                    Msg.ControlPanel
                    Msg.SaveConfig
                    Msg.SecretConfig
                    Msg.ShowApplicationState
                    Msg.VideoPlayer
                    model.secretConfig
                ]
            ]
    }
