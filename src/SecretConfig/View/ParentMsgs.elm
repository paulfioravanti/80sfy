module SecretConfig.View.ParentMsgs exposing (ParentMsgs)

import ControlPanel
import Gif exposing (GifDisplayIntervalSeconds)
import Ports
import SecretConfig.Msg exposing (Msg)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (TagsString)


type alias ParentMsgs msgs msg =
    { msgs
        | controlPanelMsg : ControlPanel.Msg -> msg
        , portsMsg : Ports.Msg -> msg
        , saveConfigMsg :
            SoundCloudPlaylistUrl
            -> TagsString
            -> GifDisplayIntervalSeconds
            -> msg
        , secretConfigMsg : Msg -> msg
        , showApplicationStateMsg : msg
    }
