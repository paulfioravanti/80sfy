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
import BrowserVendor exposing (BrowserVendor)
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


view : Msgs msgs msg -> Context a -> Html msg
view msgs context =
    View.view msgs context



-- PRIVATE


type alias Msgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , controlPanelMsg : Msg -> msg
        , fullScreenMsg : FullScreen.Msg -> msg
        , pauseMsg : msg
        , playMsg : msg
    }


type alias Context a =
    { a
        | browserVendor : BrowserVendor
        , audioPlayer : AudioPlayer
        , controlPanel : ControlPanel
    }
