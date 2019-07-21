module ControlPanel.Msg exposing
    ( Msg(..)
    , leaveControlPanel
    , toggleHideWhenInactive
    , useControlPanel
    )

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


leaveControlPanel : (Msg -> msg) -> msg
leaveControlPanel controlPanelMsg =
    controlPanelMsg LeaveControlPanel


toggleHideWhenInactive : (Msg -> msg) -> msg
toggleHideWhenInactive controlPanelMsg =
    controlPanelMsg ToggleHideWhenInactive


useControlPanel : (Msg -> msg) -> msg
useControlPanel controlPanelMsg =
    controlPanelMsg UseControlPanel
