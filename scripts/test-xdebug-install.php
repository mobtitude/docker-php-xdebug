<?php

function testPhpinfo() {
    ob_start();
    phpinfo();
    $phpinfo = ob_get_flush();
}

function testVardump() {

}

function testXdebugIsDebuggerActive() {
    // xdebug_is_debugger_active
    // https://xdebug.org/docs/all_functions#xdebug_is_debugger_active
}




// https://stackoverflow.com/questions/14046501/check-if-xdebug-is-working
