port module Ports exposing (checkFocusedParent, getFocusedParentId)


port checkFocusedParent : () -> Cmd msg


port getFocusedParentId : (Int -> msg) -> Sub msg
