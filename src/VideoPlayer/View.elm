module VideoPlayer.View exposing (view)

import Animation
import Html.Styled as Html exposing (Html, br, div, span, text, video)
import Html.Styled.Attributes
    exposing
        ( attribute
        , css
        , fromUnstyled
        , property
        , src
        )
import Html.Styled.Events exposing (onClick, onDoubleClick)
import Json.Encode as Encode
import MsgRouter exposing (MsgRouter)
import RemoteData exposing (RemoteData(Success))
import SecretConfig
import VideoPlayer.Model exposing (VideoPlayer)
import VideoPlayer.Msg exposing (Msg(ToggleFullScreen))
import VideoPlayer.Styles as Styles


view : MsgRouter msg -> VideoPlayer -> Bool -> Html msg
view msgRouter videoPlayer audioPlaying =
    let
        gifUrl =
            case videoPlayer.gifUrl of
                Success gifUrl ->
                    gifUrl

                _ ->
                    videoPlayer.fallbackGifUrl

        childElements =
            gifVideoPlayer gifUrl videoPlayer
                :: if audioPlaying && not videoPlayer.playing then
                    [ playerPausedOverlay ]
                   else
                    []
    in
        div (attributes msgRouter videoPlayer) childElements


attributes : MsgRouter msg -> VideoPlayer -> List (Html.Attribute msg)
attributes msgRouter videoPlayer =
    let
        animations =
            videoPlayer.style
                |> Animation.render
                |> List.map fromUnstyled

        attributes =
            [ css [ Styles.gifContainer videoPlayer.zIndex ]
            , attribute "data-name" "player-gif-container"
            , onClick
                (msgRouter.secretConfigMsg
                    (SecretConfig.toggleGifRotationMsg True)
                )
            , onDoubleClick (msgRouter.videoPlayerMsg ToggleFullScreen)
            ]
    in
        List.append animations attributes


gifVideoPlayer : String -> VideoPlayer -> Html msg
gifVideoPlayer gifUrl videoPlayer =
    let
        true =
            Encode.string "1"

        false =
            Encode.string "0"

        playingAttributes =
            [ property "muted" true
            , property "autopause" false
            ]
                ++ if videoPlayer.playing then
                    [ property "autoplay" true
                    , property "loop" true
                    ]
                   else
                    []

        attributes =
            [ src gifUrl
            , css [ Styles.videoPlayer ]
            , attribute "data-name" ("player-" ++ videoPlayer.id)
            ]
    in
        video (attributes ++ playingAttributes) []


playerPausedOverlay : Html msg
playerPausedOverlay =
    div
        [ css [ Styles.videoPlayerPaused ]
        , attribute "data-name" "player-paused"
        ]
        [ div
            [ css [ Styles.videoPlayerPausedContent ]
            , attribute "data-name" "player-paused-content"
            ]
            [ span [] [ text "[GIFs Paused]" ]
            , br [] []
            , br [] []
            , span []
                [ text """Click here to make this the
                          active window and continue GIFs"""
                ]
            ]
        ]
