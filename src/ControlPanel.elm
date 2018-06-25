module ControlPanel
    exposing
        ( ControlPanel
        , Msg
        , init
        , subscriptions
        , toggleHideWhenInactiveMsg
        , update
        , view
        )

import AudioPlayer exposing (AudioPlayer)
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


subscriptions : MsgRouter msg -> ControlPanel -> Sub msg
subscriptions msgRouter controlPanel =
    Subscriptions.subscriptions msgRouter controlPanel


toggleHideWhenInactiveMsg : Msg
toggleHideWhenInactiveMsg =
    Msg.ToggleHideWhenInactive


update : MsgRouter msg -> Msg -> ControlPanel -> ( ControlPanel, Cmd msg )
update msgRouter msg controlPanel =
    Update.update msgRouter msg controlPanel


view : MsgRouter msg -> AudioPlayer -> ControlPanel -> Html msg
view msgRouter audioPlayer controlPanel =
    View.view msgRouter audioPlayer controlPanel
