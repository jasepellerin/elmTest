module EditableNote exposing (Config, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onBlur, onInput)
import Note exposing (Note)


type alias UpdateHandler msg =
    Int -> Note -> msg


type alias Config msg =
    { resetEditing : msg
    , updateFocus : msg
    , updateNote : UpdateHandler msg
    }



-- VIEW


view : Config msg -> Note -> Html msg
view config model =
    article
        [ id (String.fromInt model.id) ]
        [ input [ value model.title, onInput (titleChangeHandler config.updateNote model), onBlur config.updateFocus ] []
        , hr [] []
        , textarea [ value model.content, onInput (contentChangeHandler config.updateNote model), onBlur config.updateFocus ] []
        ]


titleChangeHandler : UpdateHandler msg -> Note -> String -> msg
titleChangeHandler editHandler model newTitle =
    editHandler model.id { model | title = newTitle }


contentChangeHandler : UpdateHandler msg -> Note -> String -> msg
contentChangeHandler editHandler model newContent =
    editHandler model.id { model | content = newContent }
