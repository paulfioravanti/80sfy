module ControlPanel exposing
    ( ControlPanel
    , Msg
    , init
    , stateToString
    , subscriptions
    , toggleHideWhenInactiveMsg
    , update
    , view
    )

import AudioPlayer exposing (AudioPlayer)
import BrowserVendor exposing (Vendor)
import ControlPanel.Model as Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import ControlPanel.State as State exposing (State)
import ControlPanel.Subscriptions as Subscriptions
import ControlPanel.Update as Update
import ControlPanel.View as View
import FullScreen
import Html.Styled exposing (Html)


type alias ControlPanel =
    Model.ControlPanel


type alias Msg =
    Msg.Msg


init : ControlPanel
init =
    Model.init


stateToString : State -> String
stateToString state =
    State.toString state


subscriptions : (Msg -> msg) -> ControlPanel -> Sub msg
subscriptions controlPanelMsg controlPanel =
    Subscriptions.subscriptions controlPanelMsg controlPanel


toggleHideWhenInactiveMsg : Msg
toggleHideWhenInactiveMsg =
    Msg.ToggleHideWhenInactive


update : Msg -> ControlPanel -> ( ControlPanel, Cmd Msg )
update msg controlPanel =
    Update.update msg controlPanel


view :
    (AudioPlayer.Msg -> msg)
    -> (Msg -> msg)
    -> (FullScreen.Msg -> msg)
    -> msg
    -> msg
    -> Vendor
    -> AudioPlayer
    -> ControlPanel
    -> Html msg
view audioPlayerMsg controlPanelMsg fullScreenMsg pauseMsg playMsg vendor audioPlayer controlPanel =
    View.view
        audioPlayerMsg
        controlPanelMsg
        fullScreenMsg
        pauseMsg
        playMsg
        vendor
        audioPlayer
        controlPanel
