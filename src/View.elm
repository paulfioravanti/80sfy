module View exposing (view)

import ControlPanel
import Html.Styled as Html exposing (Html, div, text)
import Html.Styled.Attributes exposing (attribute)
import Model exposing (Model)
import Msg exposing (Msg)
import RemoteData exposing (RemoteData(Success))
import SecretConfig
import VideoPlayer exposing (VideoPlayer)


view : Model -> Html Msg
view { audioPlayer, controlPanel, secretConfig, videoPlayer1, videoPlayer2 } =
    let
        visibleVideoPlayer =
            if videoPlayer1.visible then
                videoPlayer1
            else
                videoPlayer2
    in
        case (visibleVideoPlayer.gifUrl) of
            Success gifUrl ->
                div [ attribute "data-name" "container" ]
                    [ ControlPanel.view audioPlayer controlPanel
                    , VideoPlayer.view videoPlayer1
                    , VideoPlayer.view videoPlayer2
                    , SecretConfig.view secretConfig
                    ]

            _ ->
                text ""
