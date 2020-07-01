<?php

define("DB_DSN", "mysql:host=localhost;dbname=project");

define("DB_USER", "user");

define("DB_PASS", "db-password");

define("DB_OPTIONS", array(PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));

define("MAIL_HOST", "mail.host.com");

define("MAIL_PORT", 000);

define("MAIL_FROM", "mail@host.com");

define("MAIL_PASSWORD", "mail-password");

define("MAIL_TO", "mail@host.com");

define("MAIL_USERNAME", "User Name");

define("RECAPTCHA_TOKEN", "token");
