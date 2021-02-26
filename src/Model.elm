module Model exposing (Model, init)

import AudioPlayer exposing (AudioPlayer)
import BrowserVendor exposing (BrowserVendor)
import Config exposing (Config)
import ControlPanel exposing (ControlPanel)
import SecretConfig exposing (SecretConfig)
import VideoPlayer exposing (VideoPlayer)


type alias Model =
    { audioPlayer : AudioPlayer
    , browserVendor : BrowserVendor
    , config : Config
    , controlPanel : ControlPanel
    , secretConfig : SecretConfig
    , videoPlayer1 : VideoPlayer
    , videoPlayer2 : VideoPlayer
    }


init : Config -> BrowserVendor -> Model
init ({ gifDisplaySeconds, soundCloudPlaylistUrl } as config) browserVendor =
    let
        secretConfig =
            SecretConfig.init soundCloudPlaylistUrl gifDisplaySeconds

        videoPlayer1zIndex =
            VideoPlayer.zIndex -4

        videoPlayer2zIndex =
            VideoPlayer.zIndex -5
    in
    { audioPlayer = AudioPlayer.init soundCloudPlaylistUrl
    , browserVendor = browserVendor
    , config = config
    , controlPanel = ControlPanel.init
    , secretConfig = secretConfig
    , videoPlayer1 = VideoPlayer.init (VideoPlayer.id "1") videoPlayer1zIndex
    , videoPlayer2 = VideoPlayer.init (VideoPlayer.id "2") videoPlayer2zIndex
    }
