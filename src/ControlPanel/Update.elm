module ControlPanel.Update exposing (update)

import ControlPanel.Animation as Animation
import ControlPanel.Model as Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import ControlPanel.State as State


update : Msg -> ControlPanel -> ControlPanel
update msg ({ state, style } as controlPanel) =
    case msg of
        Msg.AnimateControlPanel animateMsg ->
            { controlPanel | style = Animation.update animateMsg style }

        -- unused variable is `time`
        Msg.CountdownToHideControlPanel secondsVisible _ ->
            Model.determineVisibility secondsVisible controlPanel

        Msg.LeaveControlPanel ->
            { controlPanel | state = State.idle 0 }

        Msg.ShowControlPanel ->
            { controlPanel
                | style = Animation.toVisible style
                , state = State.idle 0
            }

        Msg.ToggleHideWhenInactive ->
            { controlPanel | state = State.toggleHideWhenInactive state }

        Msg.UseControlPanel ->
            { controlPanel | state = State.inUse }
