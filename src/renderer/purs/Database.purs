module Database (create, execute) where

import Control.Monad.Aff (Aff)
import Control.Monad.Eff.Class (liftEff)
import Data.Foldable as Foldable
import FFI.Sql (Database, QueryResult, SQLJS)
import FFI.Sql as Sql
import InitialDatabase as InitialDatabase
import Node.Buffer (BUFFER)
import Node.Buffer as Buffer
import Node.FS (FS)
import Node.FS.Aff as FS
import Node.Path (FilePath)
import Prelude (Unit, bind, discard, pure, ($))


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
execute databaseFilePath sql = do
  database <- open databaseFilePath
  results <- liftEff $ Sql.exec database sql
  close database databaseFilePath
  pure results


open :: forall eff. FilePath -> Aff (buffer :: BUFFER, fs :: FS, sql :: SQLJS | eff) Database
open databaseFilePath = do
  buffer <- FS.readFile databaseFilePath
  liftEff $ Sql.open buffer
