module ControlPanel
    exposing
        ( ControlPanel
        , animateStyle
        , determineVisibility
        , hide
        , init
        , setInUse
        , show
        , subscription
        )

import Animation exposing (px)
import Mouse
import Msg
    exposing
        ( Msg
            ( CountdownToHideControlPanel
            , HideControlPanel
            , ShowControlPanel
            )
        )
import Task
import Time


type alias ControlPanel =
    { inUse : Bool
    , secondsOpen : Int
    , style : Animation.State
    , visible : Bool
    }


type alias Styles =
    { hidden : List Animation.Property
    , visible : List Animation.Property
    }


animateStyle : Animation.Msg -> ControlPanel -> ControlPanel
animateStyle msg controlPanel =
    { controlPanel | style = Animation.update msg controlPanel.style }


determineVisibility : ControlPanel -> ( ControlPanel, Cmd Msg )
determineVisibility controlPanel =
    let
        timeoutSeconds =
            2
    in
        if controlPanel.secondsOpen > timeoutSeconds then
            ( { controlPanel | secondsOpen = 0 }
            , Task.perform HideControlPanel (Task.succeed ())
            )
        else
            ( { controlPanel | secondsOpen = controlPanel.secondsOpen + 1 }
            , Cmd.none
            )


hide : ControlPanel -> ControlPanel
hide controlPanel =
    let
        animateToHidden =
            Animation.interrupt
                [ Animation.to styles.hidden ]
                controlPanel.style
    in
        { controlPanel | style = animateToHidden, visible = False }


init : ControlPanel
init =
    { inUse = False
    , secondsOpen = 0
    , style = Animation.style styles.hidden
    , visible = False
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
        { controlPanel | style = animateToVisible, visible = True }


subscription : ControlPanel -> Sub Msg
subscription controlPanel =
    if controlPanel.visible && not controlPanel.inUse then
        Time.every Time.second CountdownToHideControlPanel
    else
        Mouse.moves (\_ -> ShowControlPanel)


styles : Styles
styles =
    { hidden = [ Animation.left (px -220.0) ]
    , visible = [ Animation.left (px 0.0) ]
    }
