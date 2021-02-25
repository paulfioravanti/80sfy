module SoundCloud exposing
    ( SoundCloudPlaylistUrl
    , defaultPlaylistUrlString
    , playlistUrl
    , rawPlaylistUrl
    )


type SoundCloudPlaylistUrl
    = SoundCloudPlaylistUrl String


defaultPlaylistUrlString : String
defaultPlaylistUrlString =
    "https://api.soundcloud.com/playlists/193785575"


rawPlaylistUrl : SoundCloudPlaylistUrl -> String
rawPlaylistUrl (SoundCloudPlaylistUrl rawSoundCloudPlaylistUrlString) =
    rawSoundCloudPlaylistUrlString


playlistUrl : String -> SoundCloudPlaylistUrl
playlistUrl rawSoundCloudPlaylistUrlString =
    SoundCloudPlaylistUrl rawSoundCloudPlaylistUrlString
