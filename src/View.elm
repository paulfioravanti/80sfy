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
    { title = "Welcome back to the 80s -- this is 80sfy."
    , body =
        List.map Html.Styled.toUnstyled
            [ div [ attribute "data-name" "container" ]
                [ ControlPanel.view
                    Msg.AudioPlayer
                    Msg.ControlPanel
                    Msg.FullScreen
                    Msg.Pause
                    Msg.Play
                    model.browserVendor
                    model.audioPlayer
                    model.controlPanel
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
