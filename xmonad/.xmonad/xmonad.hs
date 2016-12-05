-- Imports.
-- Most of this based on the following:
-- http://www.haskell.org/haskellwiki/Xmonad/Config_archive/John_Goerzen%27s_Configuration

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.Script
import XMonad.Util.Run(spawnPipe)
import XMonad.Layout.Spacing
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.MultiToggle
import System.IO
import qualified Data.Map as Map

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/jdenholm/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook  = manageDocks <+> manageHook defaultConfig
        , layoutHook  = avoidStruts  $
                       -- XMonad.Layout.Reflect methods
                       mkToggle (single REFLECTX) $
                       mkToggle (single REFLECTY) $
                       layoutHook defaultConfig
        , logHook     = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle  = xmobarColor "green" "" . shorten 200
            }
        , startupHook = execScriptHook "startup"
        , modMask     = mod4Mask     -- Remap mod to super
        , terminal    = "urxvt"      -- Use urxvt instead of xterm
        , keys        = myKeys <+> keys defaultConfig
        }

myKeys conf@(XConfig {XMonad.modMask = modm}) = Map.fromList $
    [ (( modm, xK_x), sendMessage $ Toggle REFLECTX)
    ]
