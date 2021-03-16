module ControlPanel.Animation exposing
    ( AnimationState
    , subscription
    , toHidden
    , toVisible
    , update
    , visible
    )

import Animation exposing (Property, State, px)
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
update animateMsg style =
    Animation.update animateMsg style


visible : State
visible =
    Animation.style visibleProperties



-- PRIVATE


hiddenProperties : List Property
hiddenProperties =
    [ Animation.left (px -220.0) ]


visibleProperties : List Property
visibleProperties =
    [ Animation.left (px 0.0) ]
