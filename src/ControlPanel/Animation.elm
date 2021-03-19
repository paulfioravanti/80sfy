module ControlPanel.Animation exposing
    ( AnimationState
    , subscription
    , toHidden
    , toVisible
    , update
    , visible
    )

import Animation exposing (Property, State)
import ControlPanel.Msg as Msg exposing (Msg)


type alias AnimationState =
    State


subscription : (Msg -> msg) -> State -> Sub msg
subscription controlPanelMsg style =
    Animation.subscription
        (Msg.animateControlPanel controlPanelMsg)
        [ style ]


toHidden : State -> State
toHidden style =
    Animation.interrupt [ Animation.to hiddenProperties ] style


toVisible : State -> State
toVisible style =
    Animation.interrupt [ Animation.to visibleProperties ] style


update : Animation.Msg -> State -> State
update animationMsg style =
    Animation.update animationMsg style


visible : State
visible =
    Animation.style visibleProperties



-- PRIVATE


hiddenProperties : List Property
hiddenProperties =
    [ Animation.left (Animation.px -220.0) ]


visibleProperties : List Property
visibleProperties =
    [ Animation.left (Animation.px 0.0) ]