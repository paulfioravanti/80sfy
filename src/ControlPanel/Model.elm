module ControlPanel.Model exposing (ControlPanel, init)

import Animation exposing (State)
import ControlPanel.Animations as Animations


type alias ControlPanel =
    { hideWhenInactive : Bool
    , inUse : Bool
    , secondsOpen : Int
    , style : State
    , visible : Bool
    }


init : ControlPanel
init =
    { hideWhenInactive = True
    , inUse = False
    , secondsOpen = 0
    , style = Animation.style Animations.visible
    , visible = True
    }
