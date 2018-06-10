module ControlPanel
    exposing
        ( ControlPanel
        , Msg
        , init
        , subscriptions
        , update
        , view
        )

import AudioPlayer exposing (AudioPlayer)
import ControlPanel.Model as Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg(HideControlPanel))
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


subscriptions : MsgRouter msg -> Bool -> ControlPanel -> Sub msg
subscriptions msgRouter overrideInactivityPause controlPanel =
    Subscriptions.subscriptions msgRouter overrideInactivityPause controlPanel


update : MsgRouter msg -> Msg -> ControlPanel -> ( ControlPanel, Cmd msg )
update msgRouter msg controlPanel =
    Update.update msgRouter msg controlPanel


view : MsgRouter msg -> AudioPlayer -> ControlPanel -> Html msg
view msgRouter audioPlayer controlPanel =
    View.view msgRouter audioPlayer controlPanel
