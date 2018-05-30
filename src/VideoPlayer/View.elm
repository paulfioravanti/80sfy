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
import Json.Encode as Encode
import RemoteData exposing (RemoteData(Success))
import Styles
import VideoPlayer.Model exposing (VideoPlayer)


view : VideoPlayer -> Html msg
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


attributes : VideoPlayer -> List (Html.Attribute msg)
attributes player =
    let
        animations =
            player.style
                |> Animation.render
                |> List.map fromUnstyled

        attributes =
            [ css [ Styles.playerGifContainer player.zIndex ]
            , attribute "data-name" "player-gif-container"
            ]
    in
        List.append animations attributes
