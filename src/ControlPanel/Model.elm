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
    , style =
        -- FIXME
        -- Animation.style animations.hidden
        Animation.style Animations.visible
        -- FIXME
        -- , visible = False
    , visible = True
    }
