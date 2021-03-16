module VideoPlayer.Animation exposing
    ( AnimationMsg
    , AnimationState
    , subscription
    , toOpacity
    , update
    , visible
    )

import Animation exposing (Property, State)
import VideoPlayer.Msg as Msg exposing (Msg)


type alias AnimationState =
    State


type alias AnimationMsg =
    Animation.Msg


subscription : (Msg -> msg) -> State -> Sub msg
subscription videoPlayerMsg style =
    Animation.subscription
        (Msg.animateVideoPlayer videoPlayerMsg)
        [ style ]


toOpacity : Float -> State -> State
toOpacity opacity style =
    Animation.interrupt [ Animation.to (opacityProperties opacity) ] style


update : AnimationMsg -> State -> State
update animationMsg style =
    Animation.update animationMsg style


visible : State
visible =
    Animation.style (opacityProperties 1)



-- PRIVATE


opacityProperties : Float -> List Property
opacityProperties opacity =
    [ Animation.opacity opacity ]
