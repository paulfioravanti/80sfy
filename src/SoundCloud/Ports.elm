port module SoundCloud.Ports exposing (initSoundCloudWidget)

import SoundCloud.Flags exposing (Flags)


port initSoundCloudWidget : Flags -> Cmd msg
