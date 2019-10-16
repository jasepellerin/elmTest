module Note exposing (Config, Note, init, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Time exposing (Posix, Zone)
import TimeHelpers exposing (..)



-- NOTE


type alias Config msg =
    { editNote : Int -> msg
    , removeNote : Int -> msg
    }


type alias Note =
    { title : String
    , id : Int
    , content : String
    , timeCreated : Posix
    }


init : Int -> Posix -> Note
init id time_ =
    { title = ""
    , content = ""
    , id = id
    , timeCreated = time_
    }



-- VIEW


view : Config msg -> Zone -> Note -> Html msg
view config timeZone model =
    let
        postDate =
            getHumanReadableDate model.timeCreated timeZone

        postTime =
            getHumanReadableTime model.timeCreated timeZone
    in
    article
        [ id (String.fromInt model.id) ]
        [ div [ class "title" ]
            [ h2 [] [ text model.title ]
            , small []
                [ text ("Created " ++ postDate ++ " at ")
                , time [ datetime postTime ] [ text postTime ]
                ]
            , hr [] []
            ]
        , p [] [ text model.content ]
        , button [ onClick (config.editNote model.id) ] [ text "Edit" ]
        , button [ onClick (config.removeNote model.id) ] [ text "Remove" ]
        ]
