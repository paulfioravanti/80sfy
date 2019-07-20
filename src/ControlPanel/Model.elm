module ControlPanel.Model exposing (ControlPanel, init)

import Animation
import ControlPanel.Animations as Animations
import ControlPanel.State as State exposing (State)


type alias ControlPanel =
    { state : State
    , style : Animation.State
    }


init : ControlPanel
init =
    { state = State.idle 0
    , style = Animation.style Animations.visible
    }
