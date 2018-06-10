module ControlPanel.Update exposing (update)

import Animation
import ControlPanel.Animations as Animations
import ControlPanel.Model exposing (ControlPanel)
import ControlPanel.Msg
    exposing
        ( Msg
            ( AnimateControlPanel
            , CountdownToHideControlPanel
            , HideControlPanel
            , ShowControlPanel
            , UseControlPanel
            )
        )
import MsgRouter exposing (MsgRouter)
import Task


update : MsgRouter msg -> Msg -> ControlPanel -> ( ControlPanel, Cmd msg )
update { controlPanelMsg } msg controlPanel =
    case msg of
        AnimateControlPanel msg ->
            ( { controlPanel
                | style =
                    controlPanel.style
                        |> Animation.update msg
              }
            , Cmd.none
            )

        CountdownToHideControlPanel time ->
            let
                timeoutSeconds =
                    2
            in
                if controlPanel.secondsOpen > timeoutSeconds then
                    ( { controlPanel | secondsOpen = 0 }
                    , Task.succeed ()
                        |> Task.perform (controlPanelMsg << HideControlPanel)
                    )
                else
                    ( { controlPanel
                        | secondsOpen = controlPanel.secondsOpen + 1
                      }
                    , Cmd.none
                    )

        HideControlPanel () ->
            let
                animateToHidden =
                    controlPanel.style
                        |> Animation.interrupt
                            [ Animation.to Animations.hidden ]
            in
                ( { controlPanel | style = animateToHidden, visible = False }
                , Cmd.none
                )

        ShowControlPanel ->
            let
                animateToVisible =
                    controlPanel.style
                        |> Animation.interrupt
                            [ Animation.to Animations.visible ]
            in
                ( { controlPanel | style = animateToVisible, visible = True }
                , Cmd.none
                )

        UseControlPanel bool ->
            ( { controlPanel | inUse = bool }, Cmd.none )
