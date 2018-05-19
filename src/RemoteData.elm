module RemoteData exposing (RemoteData(..), WebData)

import Http exposing (Error)


type RemoteData error data
    = NotRequested
    | Requesting
    | Failure error
    | Success data


type alias WebData data =
    RemoteData Error data
