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

import ControlPanel.Model as Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import ControlPanel.State as State exposing (State)
import ControlPanel.Subscriptions as Subscriptions
import ControlPanel.Update as Update
import ControlPanel.View as View
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


toggleHideWhenInactiveMsg : (Msg -> msg) -> msg
toggleHideWhenInactiveMsg controlPanelMsg =
    Msg.toggleHideWhenInactive controlPanelMsg


update : Msg -> ControlPanel -> ControlPanel
update msg controlPanel =
    Update.update msg controlPanel


view : View.Msgs msgs msg -> View.Context a -> Html msg
view msgs context =
    View.view msgs context
