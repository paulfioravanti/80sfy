module AudioPlayer.Model exposing
    ( AudioPlayer
    , AudioPlayerId
    , TrackIndex
    , init
    , rawId
    , rawTrackIndex
    , trackIndex
    )

import AudioPlayer.Status as Status exposing (Status)
import AudioPlayer.Volume as Volume exposing (AudioPlayerVolume)
import SoundCloud exposing (SoundCloudIframeUrl, SoundCloudPlaylistUrl)


type AudioPlayerId
    = AudioPlayerId String


type TrackIndex
    = TrackIndex Int


type alias AudioPlayer =
    { id : AudioPlayerId
    , playlist : List TrackIndex
    , playlistLength : Int
    , soundCloudIframeUrl : SoundCloudIframeUrl
    , status : Status
    , volume : AudioPlayerVolume
    }


init : SoundCloudPlaylistUrl -> AudioPlayer
init soundCloudPlaylistUrl =
    { id = AudioPlayerId "track-player"
    , playlist = []
    , playlistLength = 0
    , soundCloudIframeUrl = SoundCloud.iframeUrl soundCloudPlaylistUrl
    , status = Status.paused
    , volume = Volume.volume 80
    }


rawId : AudioPlayerId -> String
rawId (AudioPlayerId rawIdString) =
    rawIdString


rawTrackIndex : TrackIndex -> Int
rawTrackIndex (TrackIndex rawTrackIndexInt) =
    rawTrackIndexInt


trackIndex : Int -> TrackIndex
trackIndex rawTrackIndexInt =
    TrackIndex rawTrackIndexInt
