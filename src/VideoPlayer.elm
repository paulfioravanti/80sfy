module VideoPlayer
    exposing
        ( VideoPlayer
        , VideoPlayerId(..)
        , animateStyle
        , init
        , setFailureGifUrl
        , setRequestingGifUrl
        , setSuccessGifUrl
        , updateVisibility
        , view
        )

import Animation
import Html.Styled as Html exposing (Html, div, text, video)
import Html.Styled.Attributes
    exposing
        ( attribute
        , css
        , fromUnstyled
        , property
        , src
        )
import Http exposing (Error)
import Json.Encode as Encode
import RemoteData
    exposing
        ( RemoteData
            ( Failure
            , NotRequested
            , Requesting
            , Success
            )
        , WebData
        )
import Styles


type VideoPlayerId
    = Player1
    | Player2


type alias VideoPlayer =
    { gifUrl : WebData String
    , id : VideoPlayerId
    , style : Animation.State
    , visible : Bool
    , zIndex : Int
    }


animateStyle : Animation.Msg -> VideoPlayer -> VideoPlayer
animateStyle msg player =
    { player | style = Animation.update msg player.style }


init : VideoPlayerId -> Bool -> Int -> VideoPlayer
init id visible zIndex =
    { gifUrl = NotRequested
    , id = id
    , style = Animation.style [ Animation.opacity 1 ]
    , visible = visible
    , zIndex = zIndex
    }


setFailureGifUrl : Error -> VideoPlayer -> VideoPlayer
setFailureGifUrl error player =
    { player | gifUrl = Failure error }


setRequestingGifUrl : VideoPlayer -> VideoPlayer
setRequestingGifUrl player =
    { player | gifUrl = Requesting }


setSuccessGifUrl : String -> VideoPlayer -> VideoPlayer
setSuccessGifUrl gifUrl player =
    { player | gifUrl = Success gifUrl }


updateVisibility : Bool -> VideoPlayer -> VideoPlayer
updateVisibility visible player =
    let
        newOpacity =
            if player.visible then
                0
            else
                1

        animateToNewOpacity =
            Animation.interrupt
                [ Animation.to
                    [ Animation.opacity newOpacity ]
                ]
                player.style
    in
        { player | style = animateToNewOpacity, visible = visible }


view : VideoPlayer -> Html msg
view player =
    let
        gifUrl =
            case player.gifUrl of
                Success gifUrl ->
                    gifUrl

                _ ->
                    ""

        videoName =
            player.id
                |> toString
                |> String.toLower

        true =
            Encode.string "true"

        animations =
            player.style
                |> Animation.render
                |> List.map fromUnstyled

        attributes =
            [ css [ Styles.playerGifContainer player.zIndex ]
            , attribute "data-name" "player-gif-container"
            ]
    in
        div (List.append animations attributes)
            [ video
                [ src gifUrl
                , css [ Styles.videoPlayer ]
                , attribute "data-name" videoName
                , property "autoplay" true
                , property "loop" true
                ]
                []
            ]
