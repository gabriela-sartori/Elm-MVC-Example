import StartApp
import Utils

import Model
import View
import Update

main =
    StartApp.start
        {   model  = Model.model,
            view   = View.view,
            update = Update.update
        }
