module ControlPanel exposing
    ( ControlPanel
    , Msg
    , init
    , subscriptions
    , toggleHideWhenInactiveMsg
    , update
    , view
    )

import AudioPlayer exposing (AudioPlayer)
import BrowserVendor exposing (Vendor)
import ControlPanel.Model as Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import ControlPanel.Subscriptions as Subscriptions
import ControlPanel.Update as Update
import ControlPanel.View as View
import Html.Styled exposing (Html)
import MsgRouter exposing (MsgRouter)


type alias ControlPanel =
    Model.ControlPanel


type alias Msg =
    Msg.Msg


init : ControlPanel
init =
    Model.init


subscriptions : (Msg -> msg) -> ControlPanel -> Sub msg
subscriptions controlPanelMsg controlPanel =
    Subscriptions.subscriptions controlPanelMsg controlPanel


toggleHideWhenInactiveMsg : Msg
toggleHideWhenInactiveMsg =
    Msg.ToggleHideWhenInactive


update : Msg -> ControlPanel -> ( ControlPanel, Cmd Msg )
update msg controlPanel =
    Update.update msg controlPanel


view : MsgRouter msg -> Vendor -> AudioPlayer -> ControlPanel -> Html msg
view msgRouter vendor audioPlayer controlPanel =
    View.view msgRouter vendor audioPlayer controlPanel
