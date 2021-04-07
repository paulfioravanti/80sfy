module View exposing (view)

import AudioPlayer
import Browser exposing (Document)
import ControlPanel
import Html.Styled as Html exposing (div)
import Html.Styled.Attributes exposing (attribute)
import Model exposing (Model)
import Msg exposing (Msg)
import Ports
import SecretConfig
import VideoPlayer


type alias Msgs msgs =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> Msg
        , controlPanelMsg : ControlPanel.Msg -> Msg
        , noOpMsg : Msg
        , pauseMsg : Msg
        , playMsg : Msg
        , portsMsg : Ports.Msg -> Msg
        , secretConfigMsg : SecretConfig.Msg -> Msg
        , showApplicationStateMsg : Msg
        , videoPlayerMsg : VideoPlayer.Msg -> Msg
    }


view : Msgs msgs -> Model -> Document Msg
view msgs ({ secretConfig, videoPlayer1, videoPlayer2 } as model) =
    let
        -- NOTE: There is a circular dependency issue if AudioPlayer is imported
        -- into VideoPlayer, so that's why this value is determined here, rather
        -- than in VideoPlayer.view
        audioPlaying : Bool
        audioPlaying =
            AudioPlayer.isPlaying model.audioPlayer
    in
    { title = "Welcome back to the 80s -- this is 80sfy."
    , body =
        List.map Html.toUnstyled
            [ div [ attribute "data-name" "container" ]
                [ ControlPanel.view msgs model
                , VideoPlayer.view msgs audioPlaying videoPlayer1
                , VideoPlayer.view msgs audioPlaying videoPlayer2
                , SecretConfig.view msgs secretConfig
                ]
            ]
    }
