module ControlPanel.Model exposing (ControlPanel, init)

import Animation exposing (State)
import ControlPanel.Animations as Animations


type alias ControlPanel =
    { inUse : Bool
    , secondsOpen : Int
    , style : State
    , visible : Bool
    }


init : ControlPanel
init =
    { inUse = False
    , secondsOpen = 0
    , style = Animation.style Animations.visible
    , visible = True
    }
