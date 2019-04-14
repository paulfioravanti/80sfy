module SecretConfig exposing
    ( Msg
    , SecretConfig
    , init
    , initTagsMsg
    , update
    , view
    )

import AudioPlayer
import ControlPanel
import Html.Styled exposing (Html)
import SecretConfig.Model as Model
import SecretConfig.Msg as Msg
import SecretConfig.Update as Update
import SecretConfig.View as View
import VideoPlayer


type alias SecretConfig =
    Model.SecretConfig


type alias Msg =
    Msg.Msg


init : String -> Float -> SecretConfig
init soundCloudPlaylistUrl gifDisplaySeconds =
    Model.init soundCloudPlaylistUrl gifDisplaySeconds


initTagsMsg : List String -> Msg
initTagsMsg =
    Msg.InitTags


update : Msg -> SecretConfig -> SecretConfig
update msg secretConfig =
    Update.update msg secretConfig


view :
    (AudioPlayer.Msg -> msg)
    -> (ControlPanel.Msg -> msg)
    -> (String -> String -> String -> msg)
    -> (Msg -> msg)
    -> msg
    -> (VideoPlayer.Msg -> msg)
    -> SecretConfig
    -> Html msg
view audioPlayerMsg controlPanelMsg saveConfigMsg secretConfigMsg showApplicationStateMsg videoPlayerMsg secretConfig =
    View.view
        audioPlayerMsg
        controlPanelMsg
        saveConfigMsg
        secretConfigMsg
        showApplicationStateMsg
        videoPlayerMsg
        secretConfig
