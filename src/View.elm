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
view ({ browserVendor, secretConfig, videoPlayer1, videoPlayer2 } as model) =
    let
        msgs =
            { audioPlayerMsg = Msg.audioPlayer
            , browserVendorMsg = Msg.browserVendor
            , controlPanelMsg = Msg.controlPanel
            , noOpMsg = Msg.noOp
            , pauseMsg = Msg.pause
            , playMsg = Msg.play
            , saveConfigMsg = Msg.saveConfig
            , secretConfigMsg = Msg.secretConfig
            , showApplicationStateMsg = Msg.showApplicationState
            , videoPlayerMsg = Msg.videoPlayer
            }

        -- NOTE: There is a circular dependency issue if AudioPlayer is imported
        -- into VideoPlayer, so that's why this value is determined here, rather
        -- than in VideoPlayer.view
        audioPlaying =
            AudioPlayer.isPlaying model.audioPlayer
    in
    { title = "Welcome back to the 80s -- this is 80sfy."
    , body =
        List.map Html.Styled.toUnstyled
            [ div [ attribute "data-name" "container" ]
                [ ControlPanel.view msgs model
                , VideoPlayer.view audioPlaying msgs browserVendor videoPlayer1
                , VideoPlayer.view audioPlaying msgs browserVendor videoPlayer2
                , SecretConfig.view msgs secretConfig
                ]
            ]
    }
