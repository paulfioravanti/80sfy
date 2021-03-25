module ControlPanel.Msg exposing
    ( Msg(..)
    , animateControlPanel
    , countdownToHideControlPanel
    )

import Animation
import Time exposing (Posix)


type Msg
    = AnimateControlPanel Animation.Msg
    | CountdownToHideControlPanel Int Posix
    | LeaveControlPanel
    | ShowControlPanel
    | ToggleHideWhenInactive
    | UseControlPanel


animateControlPanel : (Msg -> msg) -> Animation.Msg -> msg
animateControlPanel controlPanelMsg animationMsg =
    controlPanelMsg (AnimateControlPanel animationMsg)


countdownToHideControlPanel : (Msg -> msg) -> Int -> Posix -> msg
countdownToHideControlPanel controlPanelMsg secondsVisible time =
    controlPanelMsg (CountdownToHideControlPanel secondsVisible time)
