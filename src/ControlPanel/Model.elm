module ControlPanel.Model exposing (ControlPanel, State(..), init)

import Animation
import ControlPanel.Animations as Animations


type State
    = Idle
    | InUse
    | Invisible
    | KeepVisible


type alias ControlPanel =
    { secondsOpen : Float
    , state : State
    , style : Animation.State
    }


init : ControlPanel
init =
    { secondsOpen = 0
    , state = Idle
    , style = Animation.style Animations.visible
    }
