module ControlPanel.Update exposing (update)

import Animation
import ControlPanel.Animations as Animations
import ControlPanel.Model as Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import MsgRouter exposing (MsgRouter)
import Task


update : MsgRouter msg -> Msg -> ControlPanel -> ( ControlPanel, Cmd msg )
update { controlPanelMsg } msg controlPanel =
    case msg of
        Msg.AnimateControlPanel animateMsg ->
            ( { controlPanel
                | style =
                    controlPanel.style
                        |> Animation.update animateMsg
              }
            , Cmd.none
            )

        -- unused variable is `time`
        Msg.CountdownToHideControlPanel secondsVisible _ ->
            let
                timeoutSeconds =
                    2
            in
            if secondsVisible > timeoutSeconds then
                let
                    hideControlPanel =
                        controlPanelMsg Msg.HideControlPanel
                            |> Task.succeed
                            |> Task.perform identity
                in
                ( controlPanel, hideControlPanel )

            else
                ( { controlPanel | state = Model.Idle (secondsVisible + 1) }
                , Cmd.none
                )

        Msg.HideControlPanel ->
            let
                animateToHidden =
                    controlPanel.style
                        |> Animation.interrupt
                            [ Animation.to Animations.hidden ]
            in
            ( { controlPanel
                | style = animateToHidden
                , state = Model.Invisible
              }
            , Cmd.none
            )

        Msg.LeaveControlPanel ->
            ( { controlPanel | state = Model.Idle 0 }, Cmd.none )

        Msg.ShowControlPanel ->
            let
                animateToVisible =
                    controlPanel.style
                        |> Animation.interrupt
                            [ Animation.to Animations.visible ]
            in
            ( { controlPanel | style = animateToVisible, state = Model.Idle 0 }
            , Cmd.none
            )

        Msg.ToggleHideWhenInactive ->
            let
                state =
                    if controlPanel.state == Model.KeepVisible then
                        Model.Idle 0

                    else
                        Model.KeepVisible
            in
            ( { controlPanel | state = state }, Cmd.none )

        Msg.UseControlPanel ->
            ( { controlPanel | state = Model.InUse }, Cmd.none )
