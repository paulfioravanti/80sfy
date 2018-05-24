module ControlPanel
    exposing
        ( ControlPanel
        , animateStyle
        , hide
        , incrementSecondsOpen
        , init
        , resetSecondsOpen
        , setInUse
        , show
        , styles
        )

import Animation exposing (px)
import Visibility exposing (Visibility(Hidden, Visible))


type alias ControlPanel =
    { inUse : Bool
    , secondsOpen : Int
    , style : Animation.State
    , visibility : Visibility
    }


type alias Styles =
    { hidden : List Animation.Property
    , visible : List Animation.Property
    }


animateStyle : Animation.Msg -> ControlPanel -> ControlPanel
animateStyle msg controlPanel =
    { controlPanel | style = Animation.update msg controlPanel.style }


hide : ControlPanel -> ControlPanel
hide controlPanel =
    let
        animateToHidden =
            Animation.interrupt
                [ Animation.to styles.hidden ]
                controlPanel.style
    in
        { controlPanel | style = animateToHidden, visibility = Hidden }


incrementSecondsOpen : ControlPanel -> ControlPanel
incrementSecondsOpen controlPanel =
    { controlPanel | secondsOpen = controlPanel.secondsOpen + 1 }


init : ControlPanel
init =
    { inUse = False
    , secondsOpen = 0
    , style = Animation.style styles.hidden
    , visibility = Hidden
    }


resetSecondsOpen : ControlPanel -> ControlPanel
resetSecondsOpen controlPanel =
    { controlPanel | secondsOpen = 0 }


styles : Styles
styles =
    { hidden = [ Animation.left (px -220.0) ]
    , visible = [ Animation.left (px 0.0) ]
    }


setInUse : Bool -> ControlPanel -> ControlPanel
setInUse bool controlPanel =
    { controlPanel | inUse = bool }


show : ControlPanel -> ControlPanel
show controlPanel =
    let
        animateToVisible =
            Animation.interrupt
                [ Animation.to styles.visible ]
                controlPanel.style
    in
        { controlPanel | style = animateToVisible, visibility = Visible }
