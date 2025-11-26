<?php

function checkExtensionLoaded() {
    if (!extension_loaded('xdebug')) {
        exit(1);
    }
}

function checkXdebugIsDebuggerActive() {
    if (!function_exists('xdebug_is_debugger_active')) {
        exit(1);
    }
    $result = xdebug_is_debugger_active();
    if (!is_bool($result)) {
        exit(1);
    }
}

checkExtensionLoaded();
checkXdebugIsDebuggerActive();
