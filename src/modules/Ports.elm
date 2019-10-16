port module Ports exposing (checkFocusedParent, getFocusedParentId)


port checkFocusedParent : () -> Cmd msg


port getFocusedParentId : (Maybe String -> msg) -> Sub msg
