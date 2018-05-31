module View exposing (view)

import Config
import ControlPanel
import Html.Styled as Html exposing (Html, div, text)
import Html.Styled.Attributes exposing (attribute)
import Model exposing (Model)
import Msg exposing (Msg)
import RemoteData exposing (RemoteData(Success))
import VideoPlayer exposing (VideoPlayer)


view : Model -> Html Msg
view { audioPlayer, config, controlPanel, videoPlayer1, videoPlayer2 } =
    let
        visibleVideoPlayer =
            if videoPlayer1.visible then
                videoPlayer1
            else
                videoPlayer2
    in
        case (visibleVideoPlayer.gifUrl) of
            Success gifUrl ->
                let
                    { soundCloudPlaylistUrl, tags, visible } =
                        config
                in
                    div [ attribute "data-name" "container" ]
                        [ ControlPanel.view audioPlayer controlPanel
                        , VideoPlayer.view videoPlayer1
                        , VideoPlayer.view videoPlayer2
                        , Config.secretConfigButton visible
                        , Config.view soundCloudPlaylistUrl tags visible
                        ]

            _ ->
                text ""
