module ControlPanel.Msg exposing (Msg(..))

import Animation
import Time exposing (Time)


type Msg
    = AnimateControlPanel Animation.Msg
    | CountdownToHideControlPanel Int Time
    | HideControlPanel ()
    | LeaveControlPanel
    | ShowControlPanel
    | ToggleHideWhenInactive
    | UseControlPanel
