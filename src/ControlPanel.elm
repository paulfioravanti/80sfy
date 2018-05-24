module ControlPanel
    exposing
        ( ControlPanel
        , Status(..)
        , hide
        , incrementSecondsOpen
        , init
        , resetSecondsOpen
        , setInUse
        , show
        , styles
        , updateStyle
        )

import Animation exposing (px)


type Status
    = Hidden
    | Visible


type alias ControlPanel =
    { inUse : Bool
    , secondsOpen : Int
    , style : Animation.State
    , status : Status
    }


type alias Styles =
    { hidden : List Animation.Property
    , visible : List Animation.Property
    }


init : ControlPanel
init =
    { inUse = False
    , secondsOpen = 0
    , style = Animation.style styles.hidden
    , status = Hidden
    }


styles : Styles
styles =
    { hidden = [ Animation.left (px -220.0) ]
    , visible = [ Animation.left (px 0.0) ]
    }


hide : ControlPanel -> ControlPanel
hide controlPanel =
    let
        animateToHidden =
            Animation.interrupt
                [ Animation.to styles.hidden ]
                controlPanel.style
    in
        { controlPanel | status = Hidden, style = animateToHidden }


incrementSecondsOpen : ControlPanel -> ControlPanel
incrementSecondsOpen controlPanel =
    { controlPanel | secondsOpen = controlPanel.secondsOpen + 1 }


resetSecondsOpen : ControlPanel -> ControlPanel
resetSecondsOpen controlPanel =
    { controlPanel | secondsOpen = 0 }


show : ControlPanel -> ControlPanel
show controlPanel =
    let
        animateToVisible =
            Animation.interrupt
                [ Animation.to styles.visible ]
                controlPanel.style
    in
        { controlPanel | status = Visible, style = animateToVisible }


setInUse : Bool -> ControlPanel -> ControlPanel
setInUse bool controlPanel =
    { controlPanel | inUse = bool }


updateStyle : Animation.Msg -> ControlPanel -> ControlPanel
updateStyle msg controlPanel =
    { controlPanel | style = Animation.update msg controlPanel.style }
