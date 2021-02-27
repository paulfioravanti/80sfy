module ControlPanel.Update exposing (Msgs, update)

import Animation
import ControlPanel.Animations as Animations
import ControlPanel.Model exposing (ControlPanel)
import ControlPanel.Msg as Msg exposing (Msg)
import ControlPanel.State as State
import ControlPanel.Task as Task


type alias Msgs msgs msg =
    { msgs | controlPanelMsg : Msg -> msg }


update : Msgs msgs msg -> Msg -> ControlPanel -> ( ControlPanel, Cmd msg )
update { controlPanelMsg } msg controlPanel =
    case msg of
        Msg.AnimateControlPanel animateMsg ->
            ( { controlPanel
                | style = Animation.update animateMsg controlPanel.style
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
                    performHideControlPanel =
                        Task.performHideControlPanel controlPanelMsg
                in
                ( controlPanel, performHideControlPanel )

            else
                ( { controlPanel | state = State.setIdle (secondsVisible + 1) }
                , Cmd.none
                )

        Msg.HideControlPanel ->
            let
                animateToHidden =
                    Animation.interrupt
                        [ Animation.to Animations.hidden ]
                        controlPanel.style
            in
            ( { controlPanel
                | style = animateToHidden
                , state = State.invisible
              }
            , Cmd.none
            )

        Msg.LeaveControlPanel ->
            ( { controlPanel | state = State.setIdle 0 }, Cmd.none )

        Msg.ShowControlPanel ->
            let
                animateToVisible =
                    Animation.interrupt
                        [ Animation.to Animations.visible ]
                        controlPanel.style
            in
            ( { controlPanel
                | style = animateToVisible
                , state = State.setIdle 0
              }
            , Cmd.none
            )

        Msg.ToggleHideWhenInactive ->
            let
                state =
                    State.toggleHideWhenInactive controlPanel.state
            in
            ( { controlPanel | state = state }, Cmd.none )

        Msg.UseControlPanel ->
            ( { controlPanel | state = State.inUse }, Cmd.none )
