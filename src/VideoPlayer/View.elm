module VideoPlayer.View exposing (Msgs, view)

import Animation
import BrowserVendor exposing (BrowserVendor)
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
import VideoPlayer.Status as Status
import VideoPlayer.Styles as Styles


type alias Msgs msgs msg =
    { msgs
        | browserVendorMsg : BrowserVendor.Msg -> msg
        , noOpMsg : msg
        , videoPlayerMsg : Msg -> msg
    }


view : Bool -> Msgs msgs msg -> BrowserVendor -> VideoPlayer -> Html msg
view audioPlaying msgs browserVendor videoPlayer =
    let
        gifUrl =
            case videoPlayer.gifUrl of
                RemoteData.Success url ->
                    url

                _ ->
                    videoPlayer.fallbackGifUrl

        videoPlayerPaused =
            audioPlaying && not (videoPlayer.status == Status.playing)

        childElements =
            gifVideoPlayer gifUrl videoPlayer
                :: (if videoPlayerPaused then
                        [ playerPausedOverlay ]

                    else
                        []
                   )
    in
    div
        (attributes audioPlaying msgs browserVendor videoPlayer)
        childElements



-- PRIVATE


attributes :
    Bool
    -> Msgs msgs msg
    -> BrowserVendor
    -> VideoPlayer
    -> List (Html.Attribute msg)
attributes audioPlaying msgs browserVendor videoPlayer =
    let
        { browserVendorMsg, noOpMsg, videoPlayerMsg } =
            msgs

        animations =
            videoPlayer.style
                |> Animation.render
                |> List.map fromUnstyled

        onDoubleClickAttribute =
            if browserVendor == BrowserVendor.mozilla then
                attribute "onDblClick" "window.mozFullScreenToggleHack()"

            else
                onDoubleClick
                    (BrowserVendor.performFullScreenToggleMsg browserVendorMsg)

        clickOnPlayAttribute =
            if audioPlaying && not (videoPlayer.status == Status.playing) then
                onClick (videoPlayerMsg Msg.PlayVideos)

            else
                onClick noOpMsg

        rawVideoPlayerZIndex =
            Model.rawZIndex videoPlayer.zIndex

        videoPlayerAttributes =
            [ attribute "data-name" "player-gif-container"
            , onDoubleClickAttribute
            , clickOnPlayAttribute
            , css [ Styles.gifContainer rawVideoPlayerZIndex ]
            , onDoubleClick
                (BrowserVendor.performFullScreenToggleMsg browserVendorMsg)
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
                ++ (if videoPlayer.status == Status.playing then
                        [ property "autoplay" true
                        , property "loop" true
                        ]

                    else
                        []
                   )

        videoPlayerRawId =
            Model.rawId videoPlayer.id

        playerAttributes =
            [ attribute "data-name" ("player-" ++ videoPlayerRawId)
            , src gifUrl
            , css [ Styles.videoPlayer ]
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
        [ attribute "data-name" "player-paused"
        , css [ Styles.videoPlayerPaused ]
        ]
        [ div
            [ attribute "data-name" "player-paused-content"
            , css [ Styles.videoPlayerPausedContent ]
            ]
            [ span [] [ text "[GIFs Paused]" ]
            , br [] []
            , br [] []
            , span []
                [ text overlayText ]
            ]
        ]
