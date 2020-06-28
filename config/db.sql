DROP DATABASE IF EXISTS `pam`;
CREATE DATABASE `pam` CHARACTER SET utf8;

USE `pam`;

CREATE TABLE `User`
(
    `id`    SMALLINT      UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
    `name`  VARCHAR(50)   NOT NULL,
    `image` VARCHAR(50)   UNIQUE,
    `email` VARCHAR(100)  NOT NULL  UNIQUE,
    `pass`  VARCHAR(100)  NOT NULL
)
    ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `Class`
(
    `id`            TINYINT         UNSIGNED    PRIMARY KEY AUTO_INCREMENT,
    `class`         VARCHAR(20)     NOT NULL    UNIQUE,
    `path`          VARCHAR(20)     NOT NULL,
    `constructor`   VARCHAR(30),
    `abstract`      TINYINT(1)      UNSIGNED    NOT NULL,
    `interface`     TINYINT(1)      UNSIGNED    NOT NULL,
    `extends`       VARCHAR(20),
    `implements`    VARCHAR(20)

)
    ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `Property`
(
    `id`            SMALLINT                UNSIGNED    PRIMARY KEY AUTO_INCREMENT,
    `property`      VARCHAR(20)             NOT NULL,
    `visibility`    VARCHAR(10),
    `valor`         VARCHAR(40)             NOT NULL,
    `constant`      TINYINT(1)              UNSIGNED    NOT NULL,
    `static`        TINYINT(1)              UNSIGNED    NOT NULL,
    `class_id`      TINYINT                 UNSIGNED    NOT NULL,
    CONSTRAINT      `property_fk_class_id`  FOREIGN KEY (`class_id`)    REFERENCES  `Class`(`id`)
)
    ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `Method`
(
    `id`            SMALLINT                UNSIGNED    PRIMARY KEY AUTO_INCREMENT,
    `method`        VARCHAR(20)             NOT NULL,
    `parameters`    VARCHAR(70),
    `return`        VARCHAR(30),
    `static`        TINYINT(1)              UNSIGNED    NOT NULL,
    `class_id`      TINYINT                 UNSIGNED    NOT NULL,
    CONSTRAINT      `method_fk_class_id`    FOREIGN KEY (`class_id`)    REFERENCES  `Class`(`id`)
)
ENGINE=INNODB DEFAULT CHARSET=utf8;

INSERT INTO `Class`
(`class`,               `path`,                 `constructor`,              `abstract`, `interface`,    `extends`,               `implements`)
VALUES
('DbInterface',         'Model',                '',                         0,          1,              '',                     ''),
('ModelInterface',      'Model',                '',                         0,          1,              '',                     ''),
('PdoDb',               'Model',                'PDO $pdo',                 0,          0,              '',                     'DbInterface'),
('MainModel',           'Model',                'DbInterface $database',    1,          0,              '',                     'ModelInterface'),
('PdoFactory',          'Model\\Factory',       '',                         0,          0,              '',                     ''),
('ModelFactory',        'Model\\Factory',       '',                         0,          0,              '',                     ''),
('MainExtension',       'View',                 '',                         0,          0,              'AbstractExtension',    ''),
('GlobalsExtension',    'View',                 '',                         0,          0,              'AbstractExtension',    ''),
('ServiceExtension',    'View',                 '',                         0,          0,              'AbstractExtension',    ''),
('FrontController',     'Controller',           '',                         0,          0,              '',                     ''),
('GlobalsController',   'Controller',           '',                         1,          0,              '',                     ''),
('MainController',      'Controller',           '',                         1,          0,              'GlobalsController',    ''),
('ServiceController',   'Controller',           '',                         0,          0,              '',                     ''),
('CookieManager',       'Controller\\Globals',  '',                         0,          0,              '',                     ''),
('EnvManager',          'Controller\\Globals',  '',                         0,          0,              '',                     ''),
('FilesManager',        'Controller\\Globals',  '',                         0,          0,              '',                     ''),
('GetManager',          'Controller\\Globals',  '',                         0,          0,              '',                     ''),
('PostManager',         'Controller\\Globals',  '',                         0,          0,              '',                     ''),
('RequestManager',      'Controller\\Globals',  '',                         0,          0,              '',                     ''),
('ServerManager',       'Controller\\Globals',  '',                         0,          0,              '',                     ''),
('SessionManager',      'Controller\\Globals',  '',                         0,          0,              '',                     ''),
('ArrayManager',        'Controller\\Service',  '',                         0,          0,              '',                     ''),
('CurlManager',         'Controller\\Service',  '',                         0,          0,              '',                     ''),
('ImageManager',        'Controller\\Service',  '',                         0,          0,              '',                     ''),
('MailManager',         'Controller\\Service',  '',                         0,          0,              '',                     ''),
('SecurityManager',     'Controller\\Service',  '',                         0,          0,              'GlobalsController',    ''),
('StringManager',       'Controller\\Service',  '',                         0,          0,              '',                     '');

INSERT INTO `Property`
(`property`,            `visibility`,   `valor`,                                `constant`, `static`,   `class_id`)
VALUES
('$pdo',                'private',      'PDO',                                  0,          0,          3),
('$database',           'protected',    'DbInterface',                          0,          0,          4),
('$table',              'protected',    'get_class($this)',                     0,          0,          4),
('$pdo',                'private',      'PDO',                                  0,          1,          5),
('$models',             'private',      '$class',                               0,          1,          6),
('$get',                'private',      'filter_input_array(INPUT_GET)',        0,          0,          8),
('$session',            'private',      'filter_var_array($_SESSION)',          0,          0,          8),
('$user',               'private',      '$this->session["user"]',               0,          0,          8),
('$alert',              'private',      '$this->session["alert"]',              0,          0,          8),
('DEFAULT_PATH',        '',             'App\\Controller\\\\',                  1,          0,          10),
('DEFAULT_CONTROLLER',  '',             'HomeController',                       1,          0,          10),
('DEFAULT_METHOD',      '',             'App\\Controller\\\\',                  1,          0,          10),
('$controller',         'private',      'self::DEFAULT_CONTROLLER',             0,          0,          10),
('$method',             'private',      'self::DEFAULT_METHOD',                 0,          0,          10),
('$cookie',             'private',      'CookieManager',                        0,          0,          11),
('$env',                'private',      'EnvManager',                           0,          0,          11),
('$files',              'private',      'FilesManager',                         0,          0,          11),
('$get',                'private',      'GetManager',                           0,          0,          11),
('$post',               'private',      'PostManager',                          0,          0,          11),
('$request',            'private',      'RequestManager',                       0,          0,          11),
('$server',             'private',      'ServerManager',                        0,          0,          11),
('$session',            'private',      'SessionManager',                       0,          0,          11),
('$service',            'protected',    'ServiceController',                    0,          0,          12),
('$twig',               'protected',    'Twig\\Environment',                    0,          0,          12),
('$array',              'private',      'ArrayManager',                         0,          0,          13),
('$curl',               'private',      'CurlManager',                          0,          0,          13),
('$image',              'private',      'ImageManager',                         0,          0,          13),
('$mail',               'private',      'MailManager',                          0,          0,          13),
('$security',           'private',      'SecurityManager',                      0,          0,          13),
('$string',             'private',      'StringManager',                        0,          0,          13),
('$cookie',             'private',      'filter_input_array(INPUT_COOKIE)',     0,          0,          14),
('$env',                'private',      'filter_input_array(INPUT_ENV)',        0,          0,          15),
('$files',              'private',      'filter_var_array($_FILES)',            0,          0,          16),
('$file',               'private',      '$this->files["file"]',                 0,          0,          16),
('$get',                'private',      'filter_input_array(INPUT_GET)',        0,          0,          17),
('$post',               'private',      'filter_input_array(INPUT_POST)',       0,          0,          18),
('$request',            'private',      'filter_var_array($_REQUEST)',          0,          0,          19),
('$server',             'private',      'filter_input_array(INPUT_SERVER)',     0,          0,          20),
('$session',            'private',      'filter_var_array($_SESSION)',          0,          0,          21),
('$alert',              'private',      '$this->session["alert"]',              0,          0,          21),
('$user',               'private',      '$this->session["user"]',               0,          0,          21);

INSERT INTO `Method`
(`method`,              `parameters`,                                                           `return`,                   `static`,   `class_id`)
VALUES
('getData',             'string $query, array $params = []',                                    '',                         0,          1),
('getAllData',          'string $query, array $params = []',                                    '',                         0,          1),
('setData',             'string $query, array $params = []',                                    '',                         0,          1),
('listData',            'string $value = null, string $key = null',                             '',                         0,          2),
('createData',          'array $data',                                                          '',                         0,          2),
('readData',            'string $value, string $key = null',                                    '',                         0,          2),
('updateData',          'string $value, array $data, string $key = null',                       '',                         0,          2),
('deleteData',          'string $value, string $key = null',                                    '',                         0,          2),
('getData',             'string $query, array $params = []',                                    'mixed',                    0,          3),
('getAllData',          'string $query, array $params = []',                                    'array|mixed',              0,          3),
('setData',             'string $query, array $params = []',                                    'bool|mixed',               0,          3),
('listData',            'string $value = null, string $key = null',                             'array|mixed',              0,          4),
('createData',          'array $data',                                                          '',                         0,          4),
('readData',            'string $value, string $key = null',                                    'array|mixed',              0,          4),
('updateData',          'string $value, array $data, string $key = null',                       '',                         0,          4),
('deleteData',          'string $value, string $key = null',                                    '',                         0,          4),
('getPDO',              '',                                                                     'PDO|null',                 1,          5),
('getModel',            'string $table',                                                        'mixed',                    1,          6),
('url',                 'string $page, array $params = []',                                     'string',                   0,          7),
('redirect',            'string $page, array $params = []',                                     '',                         0,          7),
('getGetVar',           'string $var',                                                          '',                         0,          8),
('hasAlert',            '',                                                                     'bool',                     0,          8),
('getAlertType',        '',                                                                     'mixed',                    0,          8),
('getAlertMessage',     '',                                                                     '',                         0,          8),
('isLogged',            '',                                                                     'bool',                     0,          8),
('getUserVar',          'string $var',                                                          'mixed',                    0,          8),
('cleanString',         'string $string',                                                       'string',                   0,          9),
('checkIsAdmin',        '',                                                                     'bool',                     0,          9),
('parseUrl',            '',                                                                     '',                         0,          10),
('setController',       '',                                                                     '',                         0,          10),
('setMethod',           '',                                                                     '',                         0,          10),
('run',                 '',                                                                     '',                         0,          10),
('getCookie',           '',                                                                     'CookieManager',            0,          11),
('getEnv',              '',                                                                     'EnvManager',               0,          11),
('getFiles',            '',                                                                     'FilesManager',             0,          11),
('getGet',              '',                                                                     'GetManager',               0,          11),
('getPost',             '',                                                                     'PostManager',              0,          11),
('getRequest',          '',                                                                     'RequestManager',           0,          11),
('getServer',           '',                                                                     'ServerManager',            0,          11),
('getSession',          '',                                                                     'SessionManager',           0,          11),
('url',                 'string $page, array $params = []',                                     'string',                   0,          12),
('redirect',            'string $page, array $params = []',                                     '',                         0,          12),
('render',              'string $view, array $params = []',                                     'string',                   0,          12),
('getArray',            '',                                                                     'ArrayManager',             0,          13),
('getCurl',             '',                                                                     'CurlManager',              0,          13),
('getImage',            '',                                                                     'ImageManager',             0,          13),
('getMail',             '',                                                                     'MailManager',              0,          13),
('getSecurity',         '',                                                                     'SecurityManager',          0,          13),
('getString',           '',                                                                     'StringManager',            0,          13),
('getCookieArray',      '',                                                                     'array',                    0,          14),
('getCookieVar',        'string $var',                                                          'mixed',                    0,          14),
('createCookie',        'string $name, string $value = "", int $expire = 0',                    'mixed|void',               0,          14),
('destroyCookie',       'string $name',                                                         '',                         0,          14),
('getEnvArray',         '',                                                                     'array',                    0,          15),
('getEnvVar',           'string $var',                                                          'mixed',                    0,          15),
('getFilesArray',       '',                                                                     'array',                    0,          16),
('getFileVar',          'string $var',                                                          'mixed',                    0,          16),
('setFileName',         'string $fileDir, string $fileName = null',                             'string',                   0,          16),
('setFileExtension',    '',                                                                     'string',                   0,          16),
('uploadFile',          'string $fileDir, string $fileName = null, int $fileSize = 50000000',   'mixed|string',             0,          16),
('getGetArray',         '',                                                                     'array',                    0,          17),
('getGetVar',           'string $var',                                                          'mixed',                    0,          17),
('getPostArray',        '',                                                                     'array',                    0,          18),
('getPostVar',          'string $var',                                                          'mixed',                    0,          18),
('getRequestArray',     '',                                                                     'array',                    0,          19),
('getRequestVar',       'string $var',                                                          'mixed',                    0,          19),
('getServerArray',      '',                                                                     'array',                    0,          20),
('getServerVar',        'string $var',                                                          'mixed',                    0,          20),
('getSessionArray',     '',                                                                     'array',                    0,          21),
('createAlert',         'string $message, string $type',                                        '',                         0,          21),
('hasAlert',            '',                                                                     'bool',                     0,          21),
('getAlertType',        'string $var',                                                          'mixed',                    0,          21),
('getAlertMessage',     '',                                                                     '',                         0,          21),
('createSession',       'array $user',                                                          '',                         0,          21),
('isLogged',            '',                                                                     'bool',                     0,          21),
('getUserVar',          'string $var',                                                          'mixed',                    0,          21),
('destroySession',      '',                                                                     '',                         0,          21),
('getArrayElements',    'array $array, string $key = "category"',                               'array $elements',          0,          22),
('getApiData',          'string $query',                                                        'mixed',                    0,          23),
('getImageType',        'string $img',                                                          'bool|false|int',           0,          24),
('inputImage',          'string $img',                                                          'false|resource|string',    0,          24),
('outputImage',         'resource $imgSrc, int $imgType, string $imgDest',                      'bool',                     0,          24),
('convertImage',        'string $imgSrc, string $imgType, string $imgDest',                     'bool|string',              0,          24),
('makeThumbnail',       'string $img, int $width = 300, string $thumbnail = null',              'bool|string',              0,          24),
('sendMessage',         'array $mail',                                                          'int',                      0,          25),
('checkRecaptcha',      'string $response',                                                     'bool',                     0,          26),
('checkIsAdmin',        '',                                                                     'bool',                     0,          26),
('cleanString',         'string $string, bool $isLow = true',                                   'string',                   0,          27);
