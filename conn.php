<?php

$connect = new mysqli("localhost", "root", "", "claszious");

if ($connect) {
} else {
    echo "Connection Failed";
    exit();
}
