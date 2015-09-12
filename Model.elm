module Model where

import Html

type Page = AtHome | AtLogin | AtRegister | AtAbout

type alias Account =
    { id       : Int
    , name     : String
    , login    : String
    , password : String
    }

type alias Model =
    { accounts      : List Account
    , account       : Maybe Account
    , page          : Page
    , login         : String
    , password      : String
    , message       : String
    , register_form : Account
    }

model : Model
model =
    { accounts      = []
    , account       = Nothing
    , page          = AtHome
    , login         = ""
    , password      = ""
    , message       = ""
    , register_form = { id = 0, name = "", login = "", password = ""}
    }