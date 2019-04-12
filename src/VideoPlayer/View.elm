module VideoPlayer.View exposing (view)

import Animation
import BrowserVendor exposing (Vendor)
import FullScreen
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
import RemoteData
import VideoPlayer.Model as Model exposing (VideoPlayer)
import VideoPlayer.Msg as Msg exposing (Msg)
import VideoPlayer.Styles as Styles


view :
    (FullScreen.Msg -> msg)
    -> msg
    -> (Msg -> msg)
    -> Vendor
    -> Bool
    -> VideoPlayer
    -> Html msg
view fullScreenMsg noOpMsg videoPlayerMsg vendor audioPlaying videoPlayer =
    let
        gifUrl =
            case videoPlayer.gifUrl of
                RemoteData.Success url ->
                    url

                _ ->
                    videoPlayer.fallbackGifUrl

        childElements =
            gifVideoPlayer gifUrl videoPlayer
                :: (if
                        audioPlaying
                            && not (videoPlayer.status == Model.Playing)
                    then
                        [ playerPausedOverlay ]

                    else
                        []
                   )
    in
    div
        (attributes
            fullScreenMsg
            noOpMsg
            videoPlayerMsg
            vendor
            audioPlaying
            videoPlayer
        )
        childElements


attributes :
    (FullScreen.Msg -> msg)
    -> msg
    -> (Msg -> msg)
    -> Vendor
    -> Bool
    -> VideoPlayer
    -> List (Html.Attribute msg)
attributes fullScreenMsg noOpMsg videoPlayerMsg vendor audioPlaying videoPlayer =
    let
        animations =
            videoPlayer.style
                |> Animation.render
                |> List.map fromUnstyled

        onDoubleClickAttribute =
            if vendor == BrowserVendor.Mozilla then
                attribute "onDblClick" "window.mozFullScreenToggleHack()"

            else
                onDoubleClick
                    (fullScreenMsg FullScreen.performFullScreenToggleMsg)

        clickOnPlayAttribute =
            if audioPlaying && not (videoPlayer.status == Model.Playing) then
                onClick (videoPlayerMsg Msg.PlayVideos)

            else
                onClick noOpMsg

        videoPlayerAttributes =
            [ onDoubleClickAttribute
            , clickOnPlayAttribute
            , css [ Styles.gifContainer videoPlayer.zIndex ]
            , attribute "data-name" "player-gif-container"
            , onDoubleClick
                (fullScreenMsg FullScreen.performFullScreenToggleMsg)
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
                ++ (if videoPlayer.status == Model.Playing then
                        [ property "autoplay" true
                        , property "loop" true
                        ]

                    else
                        []
                   )

        playerAttributes =
            [ src gifUrl
            , css [ Styles.videoPlayer ]
            , attribute "data-name" ("player-" ++ videoPlayer.id)
            ]
    in
    video (playerAttributes ++ playingAttributes) []


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
