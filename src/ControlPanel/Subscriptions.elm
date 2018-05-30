module ControlPanel.Subscriptions exposing (subscriptions)

import ControlPanel.Model exposing (ControlPanel)
import Mouse
import Msg exposing (Msg(CountdownToHideControlPanel, ShowControlPanel))
import Time exposing (every, second)


subscriptions : ControlPanel -> Sub Msg
subscriptions controlPanel =
    if controlPanel.visible && not controlPanel.inUse then
        every second CountdownToHideControlPanel
    else
        Mouse.moves (\_ -> ShowControlPanel)
