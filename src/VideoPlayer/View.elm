module VideoPlayer.View exposing (view)

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
import Html.Styled.Events exposing (onDoubleClick)
import Json.Encode as Encode
import Msg exposing (Msg(ToggleFullScreen))
import RemoteData exposing (RemoteData(Success))
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Styles as Styles


view : VideoPlayer -> Html Msg
view player =
    let
        gifUrl =
            case player.gifUrl of
                Success gifUrl ->
                    gifUrl

                _ ->
                    ""

        true =
            Encode.string "true"
    in
        div (attributes player)
            [ video
                [ src gifUrl
                , css [ Styles.videoPlayer ]
                , attribute "data-name" ("player-" ++ player.id)
                , property "autoplay" true
                , property "loop" true
                ]
                []
            ]


attributes : VideoPlayer -> List (Html.Attribute Msg)
attributes player =
    let
        animations =
            player.style
                |> Animation.render
                |> List.map fromUnstyled

        attributes =
            [ css [ Styles.gifContainer player.zIndex ]
            , attribute "data-name" "player-gif-container"
            , onDoubleClick ToggleFullScreen
            ]
    in
        List.append animations attributes
