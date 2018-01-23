module Database (create, execute, fromManyResults) where

import Config as Config
import Control.Monad.Aff (Aff)
import Control.Monad.Aff as Aff
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Except as Except
import Data.Either as Either
import Data.Foldable as Foldable
import Data.Foreign (F, Foreign)
import Data.Functor as Functor
import Data.Traversable as Traversable
import FFI.Sql (Database, QueryResult, SQLJS)
import FFI.Sql as Sql
import InitialDatabase as InitialDatabase
import Node.Buffer (BUFFER)
import Node.Buffer as Buffer
import Node.FS (FS)
import Node.FS.Aff as FS
import Node.Path (FilePath)
import Prelude (Unit, bind, discard, flip, pure, show, (#), ($), (>>>))


close :: forall eff. Database -> FilePath -> Aff (buffer :: BUFFER, fs :: FS, sql :: SQLJS | eff) Unit
close database databaseFilePath = do
  octetArray <- liftEff $ Sql.export database
  buffer <- liftEff $ Buffer.fromArray octetArray
  FS.writeFile databaseFilePath buffer
  liftEff $ Sql.close database


create :: forall eff. FilePath -> Aff (buffer :: BUFFER, fs :: FS, sql :: SQLJS | eff) Unit
create databaseFilePath = do
  database <- liftEff $ Sql.create
  liftEff $ Foldable.traverse_ (Sql.exec database) InitialDatabase.sql
  close database databaseFilePath


execute :: forall eff. FilePath -> String -> Aff (buffer :: BUFFER, fs :: FS, sql :: SQLJS | eff) (Array QueryResult)
execute databaseFilePath sql =
  Aff.bracket (open databaseFilePath)
    (flip close databaseFilePath)
    (flip Sql.exec sql >>> liftEff)


fromFToAff :: forall a eff. F a -> Aff eff a
fromFToAff =
  Except.runExcept >>> Either.either (show >>> Aff.error >>> Aff.throwError) pure


fromManyResults :: forall eff a. (Array String -> Array Foreign -> F a) -> String -> FilePath -> Aff (buffer :: BUFFER, fs :: FS, sql :: SQLJS | eff) (Array a)
fromManyResults transformer query userDataPath = do
  results <- execute (Config.databaseFilePath userDataPath) query
  Sql.getFirstResult results # manyResults transformer # fromFToAff


manyResults :: forall a. (Array String -> Array Foreign -> F a) -> QueryResult -> F (Array a)
manyResults transformer result =
  Functor.map (transformer result.columns) result.values
    # Traversable.sequence


open :: forall eff. FilePath -> Aff (buffer :: BUFFER, fs :: FS, sql :: SQLJS | eff) Database
open databaseFilePath = do
  buffer <- FS.readFile databaseFilePath
  liftEff $ Sql.open buffer
