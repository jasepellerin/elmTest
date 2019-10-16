module EditableNote exposing (Config, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onBlur, onClick, onInput)
import Note exposing (Note)


type alias UpdateHandler msg =
    Int -> Note -> msg


type alias Config msg =
    { finishEditing : msg
    , updateNote : UpdateHandler msg
    }



-- VIEW


view : Config msg -> Note -> Html msg
view config model =
    article
        [ id (String.fromInt model.id) ]
        [ input [ placeholder "Add a title!", onInput (titleChangeHandler config.updateNote model), value model.title ] []
        , hr [] []
        , textarea [ placeholder "Add some content!", onInput (contentChangeHandler config.updateNote model), value model.content ] []
        , button [ onClick config.finishEditing ] [ text "Save" ]
        ]


titleChangeHandler : UpdateHandler msg -> Note -> String -> msg
titleChangeHandler editHandler model newTitle =
    editHandler model.id { model | title = newTitle }


contentChangeHandler : UpdateHandler msg -> Note -> String -> msg
contentChangeHandler editHandler model newContent =
    editHandler model.id { model | content = newContent }
