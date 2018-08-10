module VideoPlayer.View exposing (view)

import Animation
import Browser exposing (Vendor)
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
import VideoPlayer.Model exposing (Status(Playing), VideoPlayer)
import VideoPlayer.Msg exposing (Msg(PlayVideos))
import VideoPlayer.Styles as Styles


view : MsgRouter msg -> Vendor -> Bool -> VideoPlayer -> Html msg
view msgRouter vendor audioPlaying videoPlayer =
    let
        gifUrl =
            case videoPlayer.gifUrl of
                Success url ->
                    url

                _ ->
                    videoPlayer.fallbackGifUrl

        childElements =
            gifVideoPlayer gifUrl videoPlayer
                :: if audioPlaying && not (videoPlayer.status == Playing) then
                    [ playerPausedOverlay ]
                   else
                    []
    in
        div (attributes msgRouter vendor audioPlaying videoPlayer) childElements


attributes :
    MsgRouter msg
    -> Vendor
    -> Bool
    -> VideoPlayer
    -> List (Html.Attribute msg)
attributes msgRouter vendor audioPlaying videoPlayer =
    let
        animations =
            videoPlayer.style
                |> Animation.render
                |> List.map fromUnstyled

        onDoubleClickAttribute =
            if vendor == Browser.mozilla then
                attribute "onDblClick" "window.mozFullScreenToggleHack()"
            else
                onDoubleClick
                    (msgRouter.browserMsg
                        Browser.performFullScreenToggleMsg
                    )

        clickOnPlayAttribute =
            if audioPlaying && not (videoPlayer.status == Playing) then
                onClick (msgRouter.videoPlayerMsg PlayVideos)
            else
                onClick (msgRouter.noOpMsg)

        videoPlayerAttributes =
            onDoubleClickAttribute
                :: clickOnPlayAttribute
                :: [ css [ Styles.gifContainer videoPlayer.zIndex ]
                   , attribute "data-name" "player-gif-container"
                   , onDoubleClick
                        (msgRouter.browserMsg
                            Browser.performFullScreenToggleMsg
                        )
                   ]
    in
        List.append animations videoPlayerAttributes


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
                ++ if videoPlayer.status == Playing then
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
    let
        overlayText =
            "Click here to make this the active window and continue GIFs"
    in
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
                    [ text overlayText ]
                ]
            ]
