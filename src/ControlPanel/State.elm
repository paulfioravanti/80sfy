module ControlPanel.State exposing
    ( State
    , idle
    , inUse
    , invisible
    , toString
    , toggleHideWhenInactive
    , visibilitySubscription
    , visibilityToggles
    )

import Browser.Events
import ControlPanel.Msg as Msg exposing (Msg)
import Html.Styled exposing (Attribute)
import Html.Styled.Events
import Json.Decode as Decode
import Time


type State
    = Idle Int
    | InUse
    | Invisible
    | KeepVisible


idle : Int -> State
idle seconds =
    Idle seconds


inUse : State
inUse =
    InUse


invisible : State
invisible =
    Invisible


toggleHideWhenInactive : State -> State
toggleHideWhenInactive state =
    case state of
        KeepVisible ->
            Idle 0

        _ ->
            KeepVisible


toString : State -> String
toString state =
    case state of
        Idle seconds ->
            "Idle " ++ String.fromInt seconds

        InUse ->
            "InUse"

        Invisible ->
            "Invisible"

        KeepVisible ->
            "KeepVisible"


visibilitySubscription : (Msg -> msg) -> State -> Sub msg
visibilitySubscription controlPanelMsg state =
    case state of
        Idle secondsVisible ->
            -- milliseconds
            Time.every 1000
                (controlPanelMsg
                    << Msg.CountdownToHideControlPanel secondsVisible
                )

        Invisible ->
            Browser.Events.onMouseMove
                (Decode.succeed (controlPanelMsg Msg.ShowControlPanel))

        _ ->
            Sub.none


visibilityToggles : (Msg -> msg) -> State -> List (Attribute msg)
visibilityToggles controlPanelMsg state =
    case state of
        KeepVisible ->
            []

        _ ->
            [ Html.Styled.Events.onMouseEnter
                (controlPanelMsg Msg.UseControlPanel)
            , Html.Styled.Events.onMouseLeave
                (controlPanelMsg Msg.LeaveControlPanel)
            ]
