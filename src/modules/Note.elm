module Note exposing (Note, init, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Time exposing (Posix, Zone)
import TimeHelpers exposing (..)



-- NOTE


type alias Note =
    { title : String
    , id : Int
    , content : String
    , timeCreated : Posix
    }


init : Int -> Posix -> Note
init id time_ =
    { title = "New Note!"
    , content = "This is a new note!"
    , id = id
    , timeCreated = time_
    }


type alias EditHandler msg =
    Int -> msg


type alias RemoveHandler msg =
    Int -> msg



-- VIEW


view : RemoveHandler msg -> EditHandler msg -> Zone -> Note -> Html msg
view removeHandler editHandler timeZone model =
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
                [ text ("Created " ++ postDate ++ " ")
                , time [ datetime postTime ] [ text postTime ]
                ]
            , hr [] []
            ]
        , p [] [ text model.content ]
        , button [ onClick (editHandler model.id) ] [ text "Edit" ]
        , button [ onClick (removeHandler model.id) ] [ text "Remove" ]
        ]
