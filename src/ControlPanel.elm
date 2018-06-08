module ControlPanel
    exposing
        ( ControlPanel
        , init
        , subscriptions
        , update
        , view
        )

import Animation
import AudioPlayer exposing (AudioPlayer)
import ControlPanel.Animations as Animations
import ControlPanel.Model as Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg(HideControlPanel))
import ControlPanel.Subscriptions as Subscriptions
import ControlPanel.Update as Update
import ControlPanel.View as View
import Html.Styled exposing (Html)
import MsgConfig exposing (MsgConfig)


type alias ControlPanel =
    Model.ControlPanel


type alias Msg =
    Msg.Msg


init : ControlPanel
init =
    Model.init


subscriptions : MsgConfig msg -> Bool -> ControlPanel -> Sub msg
subscriptions msgConfig overrideInactivityPause controlPanel =
    Subscriptions.subscriptions msgConfig overrideInactivityPause controlPanel


update : MsgConfig msg -> Msg -> ControlPanel -> ( ControlPanel, Cmd msg )
update msgConfig msg controlPanel =
    Update.update msgConfig msg controlPanel


view : MsgConfig msg -> AudioPlayer -> ControlPanel -> Html msg
view msgConfig audioPlayer controlPanel =
    View.view msgConfig audioPlayer controlPanel
