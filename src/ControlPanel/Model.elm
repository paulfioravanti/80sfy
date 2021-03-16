module ControlPanel.Model exposing (ControlPanel, determineVisibility, init)

import ControlPanel.Animation as Animation exposing (AnimationState)
import ControlPanel.State as State exposing (State)


type alias ControlPanel =
    { state : State
    , style : AnimationState
    }


init : ControlPanel
init =
    { state = State.idle 0
    , style = Animation.visible
    }


determineVisibility : Int -> ControlPanel -> ControlPanel
determineVisibility secondsVisible ({ style } as controlPanel) =
    let
        timeoutSeconds =
            2

        shouldStillBeVisible =
            secondsVisible < timeoutSeconds
    in
    if shouldStillBeVisible then
        { controlPanel | state = State.idle (secondsVisible + 1) }

    else
        { state = State.invisible, style = Animation.toHidden style }
