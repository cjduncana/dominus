module Main (main) where

import Control.Monad.Eff (Eff)
import Control.Monad.ST (ST, STRef)
import Control.Monad.ST as ST
import Data.Argonaut.Decode (decodeJson)
import Data.Foldable (for_, traverse_)
import Data.Maybe (Maybe(..), isNothing)
import Electron (ELECTRON)
import Electron.App as App
import Electron.BrowserWindow (BrowserWindow, BrowserWindowOptions)
import Electron.BrowserWindow as BrowserWindow
import Electron.IpcMain as IpcMain
import Electron.Types as Electron
import Node.Platform (Platform(Darwin))
import Node.Process as Node
import Prelude (Unit, bind, discard, notEq, pure, void, when, (#), ($), (>>>))
import Types (Action(CloseWindow, MinimizeWindow))


main :: forall eff. String -> Boolean -> Eff (electron :: ELECTRON | eff) Unit
main url isDevelopment =
  ST.runST do
    mainWindowRef <- ST.newSTRef Nothing
    App.onReady $ createWindow mainWindowRef url isDevelopment
    doSystemAction mainWindowRef
    onAllWindowsClosed
    onActivate mainWindowRef url isDevelopment


doSystemAction :: forall eff h. STRef h (Maybe BrowserWindow) -> Eff (electron :: ELECTRON, st :: ST h | eff) Unit
doSystemAction mainWindowRef =
  Electron.mkListener (\_ -> decodeJson >>> traverse_ (action mainWindowRef))
    # IpcMain.on "system-action"


action :: forall eff h. STRef h (Maybe BrowserWindow) -> Action -> Eff (electron :: ELECTRON, st :: ST h | eff) Unit
action mainWindowRef action_ = do
  mainWindow <- ST.readSTRef mainWindowRef
  for_ mainWindow
    case action_ of
      CloseWindow -> BrowserWindow.close
      MinimizeWindow -> BrowserWindow.minimize


createWindow :: forall eff h. STRef h (Maybe BrowserWindow) -> String -> Boolean -> Eff (electron :: ELECTRON, st :: ST h | eff) Unit
createWindow mainWindowRef url isDevelopment = do
  mainWindow <- assignNewWindow mainWindowRef
  BrowserWindow.loadURL mainWindow url
  BrowserWindow.onceReadyToShow mainWindow $ BrowserWindow.show mainWindow
  showDevTools isDevelopment mainWindow
  BrowserWindow.onClosed mainWindow $ void $ ST.writeSTRef mainWindowRef Nothing


assignNewWindow :: forall eff h. STRef h (Maybe BrowserWindow) -> Eff (electron :: ELECTRON, st :: ST h | eff) BrowserWindow
assignNewWindow mainWindowRef = do
  mainWindow <- BrowserWindow.newBrowserWindow browserWindowOptions
  _ <- ST.writeSTRef mainWindowRef $ Just mainWindow
  pure mainWindow


browserWindowOptions :: BrowserWindowOptions
browserWindowOptions =
  BrowserWindow.defaultBrowserWindowOptions
    # BrowserWindow.changeWidth 1024
    # BrowserWindow.changeHeight 768
    # BrowserWindow.hidden
    # BrowserWindow.frameless


showDevTools :: forall eff. Boolean -> BrowserWindow -> Eff (electron :: ELECTRON | eff) Unit
showDevTools isDevelopment mainWindow =
  when isDevelopment $ do
    webContents <- BrowserWindow.webContents mainWindow
    BrowserWindow.openDevTools webContents []


onActivate :: forall eff h. STRef h (Maybe BrowserWindow) -> String -> Boolean -> Eff (electron :: ELECTRON, st :: ST h | eff) Unit
onActivate mainWindowRef url isDevelopment =
  App.onActivate do
    mainWindow <- ST.readSTRef mainWindowRef
    when (isNothing mainWindow) (createWindow mainWindowRef url isDevelopment)


onAllWindowsClosed :: forall eff. Eff (electron :: ELECTRON | eff) Unit
onAllWindowsClosed =
  App.onAllWindowsClosed $ when (notEq Node.platform $ Just Darwin) App.quit
