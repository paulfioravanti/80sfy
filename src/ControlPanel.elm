module ControlPanel
    exposing
        ( ControlPanel
        , init
        , animateStyle
        , determineVisibility
        , hide
        , setInUse
        , show
        , subscriptions
        , update
        , view
        )

import Animation
import AudioPlayer exposing (AudioPlayer)
import ControlPanel.Animations as Animations
import ControlPanel.Model as Model exposing (ControlPanel)
import ControlPanel.Msg
import ControlPanel.Subscriptions as Subscriptions
import ControlPanel.Update as Update
import ControlPanel.View as View
import Html.Styled exposing (Html)
import Msg exposing (Msg(HideControlPanel))
import MsgConfig exposing (MsgConfig)
import Task


type alias ControlPanel =
    Model.ControlPanel


init : ControlPanel
init =
    Model.init


animateStyle : Animation.Msg -> ControlPanel -> ControlPanel
animateStyle msg controlPanel =
    { controlPanel
        | style =
            controlPanel.style
                |> Animation.update msg
    }


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
            controlPanel.style
                |> Animation.interrupt [ Animation.to Animations.hidden ]
    in
        { controlPanel | style = animateToHidden, visible = False }


setInUse : Bool -> ControlPanel -> ControlPanel
setInUse bool controlPanel =
    { controlPanel | inUse = bool }


show : ControlPanel -> ControlPanel
show controlPanel =
    let
        animateToVisible =
            controlPanel.style
                |> Animation.interrupt [ Animation.to Animations.visible ]
    in
        { controlPanel | style = animateToVisible, visible = True }


subscriptions : MsgConfig msg -> Bool -> ControlPanel -> Sub msg
subscriptions msgConfig overrideInactivityPause controlPanel =
    Subscriptions.subscriptions msgConfig overrideInactivityPause controlPanel


update :
    MsgConfig msg
    -> ControlPanel.Msg.Msg
    -> ControlPanel
    -> ( ControlPanel, Cmd msg )
update msgConfig msg controlPanel =
    Update.update msgConfig msg controlPanel


view : AudioPlayer -> ControlPanel -> Html Msg
view audioPlayer controlPanel =
    View.view audioPlayer controlPanel
