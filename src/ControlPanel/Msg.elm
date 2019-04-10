module ControlPanel.Msg exposing (Msg(..))

import Animation
import Time exposing (Posix)


type Msg
    = AnimateControlPanel Animation.Msg
    | CountdownToHideControlPanel Int Posix
    | HideControlPanel
    | LeaveControlPanel
    | ShowControlPanel
    | ToggleHideWhenInactive
    | UseControlPanel
