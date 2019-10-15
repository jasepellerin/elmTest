module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import EditableNote exposing (view)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Note exposing (Note, view)
import Task
import Time


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { currentId : Int
    , editingId : Int
    , name : String
    , notes : List Note.Note
    , zone : Time.Zone
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : () -> ( Model, Cmd Msg )
init =
    always
        ( { currentId = 0
          , editingId = -1
          , name = "Test"
          , notes =
                []
          , zone = Time.utc
          }
        , Task.perform AdjustTimeZone Time.here
        )



-- UPDATE


type Msg
    = AdjustTimeZone Time.Zone
    | AddNoteClick
    | AddNote Time.Posix
    | ChangeEditingId Int
    | ResetEditingId
    | RemoveNote Int
    | UpdateNote Int Note


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AdjustTimeZone newZone ->
            ( { model | zone = newZone }, Cmd.none )

        AddNoteClick ->
            ( model, Task.perform AddNote Time.now )

        AddNote time ->
            let
                newNote =
                    { title = "New Note!"
                    , content = "We dynamic"
                    , id = model.currentId
                    , timeCreated = time
                    }
            in
            ( { model | notes = newNote :: model.notes, currentId = model.currentId + 1 }, Cmd.none )

        ChangeEditingId newId ->
            ( { model | editingId = newId }, Cmd.none )

        RemoveNote id ->
            ( { model | notes = List.filter (\x -> x.id /= id) model.notes }, Cmd.none )

        ResetEditingId ->
            ( { model | editingId = -1 }, Cmd.none )

        UpdateNote id newNote ->
            let
                newNotes =
                    List.map (noteReplacer newNote) model.notes
            in
            ( { model | notes = newNotes }, Cmd.none )


noteReplacer : Note -> Note -> Note
noteReplacer newNote existingNote =
    if existingNote.id == newNote.id then
        newNote

    else
        existingNote



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { body =
        [ header []
            [ h1 []
                [ text "notorious" ]
            , button
                [ onClick AddNoteClick ]
                [ text "Add note" ]
            ]
        , main_ [] (List.map (displayNote model.zone model.editingId) model.notes)
        ]
    , title = "notorious"
    }


displayNote : Time.Zone -> Int -> Note -> Html Msg
displayNote zone editableId note =
    if note.id == editableId then
        EditableNote.view ResetEditingId UpdateNote note

    else
        Note.view RemoveNote ChangeEditingId zone note
