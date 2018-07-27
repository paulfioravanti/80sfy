module ControlPanel.Model exposing (ControlPanel, State(..), init)

import Animation
import ControlPanel.Animations as Animations


type State
    = Idle
    | InUse
    | Invisible


type alias ControlPanel =
    { inUse : Bool
    , secondsOpen : Float
    , state : State
    , style : Animation.State
    , visible : Bool
    }


init : ControlPanel
init =
    { inUse = False
    , secondsOpen = 0
    , state = Idle
    , style = Animation.style Animations.visible
    , visible = True
    }
