module View exposing (view)

import AudioPlayer
import Browser exposing (Document)
import ControlPanel
import Gif
import Html.Styled exposing (div)
import Html.Styled.Attributes exposing (attribute)
import Model exposing (Model)
import Msg exposing (Msg)
import Ports
import SecretConfig
import SoundCloud
import Tag
import VideoPlayer


type alias ParentMsgs msgs =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> Msg
        , controlPanelMsg : ControlPanel.Msg -> Msg
        , noOpMsg : Msg
        , pauseMsg : Msg
        , playMsg : Msg
        , portsMsg : Ports.Msg -> Msg
        , saveConfigMsg :
            SoundCloud.SoundCloudPlaylistUrl
            -> Tag.TagsString
            -> Gif.GifDisplayIntervalSeconds
            -> Msg
        , secretConfigMsg : SecretConfig.Msg -> Msg
        , showApplicationStateMsg : Msg
        , videoPlayerMsg : VideoPlayer.Msg -> Msg
    }


view : ParentMsgs msgs -> Model -> Document Msg
view parentMsgs ({ secretConfig, videoPlayer1, videoPlayer2 } as model) =
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
        List.map Html.Styled.toUnstyled
            [ div [ attribute "data-name" "container" ]
                [ ControlPanel.view parentMsgs model
                , VideoPlayer.view parentMsgs audioPlaying videoPlayer1
                , VideoPlayer.view parentMsgs audioPlaying videoPlayer2
                , SecretConfig.view parentMsgs secretConfig
                ]
            ]
    }
