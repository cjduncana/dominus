module FFI.Sql (Database, QueryResult, SQLEff, SQLJS, close, create, exec, export, open) where

import Control.Monad.Eff (Eff, kind Effect)
import Data.Foreign (Foreign)
import Node.Buffer (Buffer, Octet)
import Prelude (Unit)

foreign import data SQLJS :: Effect

foreign import data Database :: Type

type QueryResult =
    { columns :: Array String
    , values :: Array (Array Foreign)
    }

type SQLEff eff a = Eff (sql :: SQLJS | eff) a

foreign import close :: forall eff. Database -> SQLEff eff Unit

foreign import create :: forall eff. SQLEff eff Database

foreign import exec :: forall eff. Database -> String -> SQLEff eff (Array QueryResult)

foreign import export :: forall eff. Database -> SQLEff eff (Array Octet)

foreign import open :: forall eff. Buffer -> SQLEff eff Database
