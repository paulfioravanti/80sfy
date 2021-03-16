module ControlPanel.Animation exposing
    ( AnimationState
    , toHidden
    , toVisible
    , update
    , visible
    )

import Animation exposing (Msg, Property, State, px)


type alias AnimationState =
    State


toHidden : State -> State
toHidden style =
    Animation.interrupt [ Animation.to hiddenProperties ] style


toVisible : State -> State
toVisible style =
    Animation.interrupt [ Animation.to visibleProperties ] style


update : Msg -> State -> State
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
