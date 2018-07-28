module ControlPanel.Model exposing (ControlPanel, State(..), init)

import Animation
import ControlPanel.Animations as Animations


type State
    = Idle Int
    | InUse
    | Invisible
    | KeepVisible


type alias ControlPanel =
    { state : State
    , style : Animation.State
    }


init : ControlPanel
init =
    { state = Idle 0
    , style = Animation.style Animations.visible
    }
