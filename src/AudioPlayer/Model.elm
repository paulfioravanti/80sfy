module AudioPlayer.Model exposing (AudioPlayer, AudioPlayerId, init, rawId)

import AudioPlayer.Status as Status exposing (Status)
import SoundCloud exposing (SoundCloudIframeUrl, SoundCloudPlaylistUrl)


type AudioPlayerId
    = AudioPlayerId String


type alias AudioPlayer =
    { id : AudioPlayerId
    , playlist : List Int
    , playlistLength : Int
    , soundCloudIframeUrl : SoundCloudIframeUrl
    , status : Status
    , volume : Int
    }


init : SoundCloudPlaylistUrl -> AudioPlayer
init soundCloudPlaylistUrl =
    { id = AudioPlayerId "track-player"
    , playlist = []
    , playlistLength = 0
    , soundCloudIframeUrl = SoundCloud.iframeUrl soundCloudPlaylistUrl
    , status = Status.paused
    , volume = 80
    }


rawId : AudioPlayerId -> String
rawId (AudioPlayerId rawIdValue) =
    rawIdValue
