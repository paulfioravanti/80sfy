module ControlPanel
    exposing
        ( ControlPanel
        , init
        , animateStyle
        , determineVisibility
        , hide
        , setInUse
        , show
        , subscription
        , view
        )

import Animation
import ControlPanel.Animations as Animations
import ControlPanel.Model as Model exposing (ControlPanel)
import ControlPanel.View as View
import Html.Styled exposing (Html)
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
    Model.ControlPanel


init : ControlPanel
init =
    Model.init


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
                [ Animation.to Animations.hidden ]
                controlPanel.style
    in
        { controlPanel | style = animateToHidden, visible = False }


setInUse : Bool -> ControlPanel -> ControlPanel
setInUse bool controlPanel =
    { controlPanel | inUse = bool }


show : ControlPanel -> ControlPanel
show controlPanel =
    let
        animateToVisible =
            Animation.interrupt
                [ Animation.to Animations.visible ]
                controlPanel.style
    in
        { controlPanel | style = animateToVisible, visible = True }


subscription : ControlPanel -> Sub Msg
subscription controlPanel =
    if controlPanel.visible && not controlPanel.inUse then
        Time.every Time.second CountdownToHideControlPanel
    else
        Mouse.moves (\_ -> ShowControlPanel)


view : ControlPanel -> Html Msg
view controlPanel =
    View.view controlPanel
