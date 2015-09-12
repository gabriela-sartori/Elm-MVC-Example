module Utils where

import String exposing (toInt, trim, toLower)
import Html exposing (Attribute)
import Html.Events exposing (on, targetValue)
import Signal exposing (Address)

onInput : Address a -> (String -> a) -> Attribute
onInput address f = on "input" targetValue (\v -> Signal.message address (f v))

parseInt : String -> Int
parseInt string =
  case String.toInt string of
    Ok  value -> value
    Err error -> 0

fixStr : String -> String
fixStr  = trim << toLower

