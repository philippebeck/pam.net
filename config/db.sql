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
    `parameters`    VARCHAR(30),
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
(`class`,               `path`,                 `parameters`,               `abstract`, `interface`,    `extends`,               `implements`)
VALUES
('FrontController',     'Controller/',          '',                         0,          0,              '',                     ''),
('GlobalsController',   'Controller/',          '',                         1,          0,              '',                     ''),
('MainController',      'Controller/',          '',                         1,          0,              'GlobalsController',    ''),
('ServiceController',   'Controller/',          '',                         0,          0,              '',                     ''),
('CookieManager',       'Controller/Globals/',  '',                         0,          0,              '',                     ''),
('EnvManager',          'Controller/Globals/',  '',                         0,          0,              '',                     ''),
('FilesManager',        'Controller/Globals/',  '',                         0,          0,              '',                     ''),
('GetManager',          'Controller/Globals/',  '',                         0,          0,              '',                     ''),
('PostManager',         'Controller/Globals/',  '',                         0,          0,              '',                     ''),
('RequestManager',      'Controller/Globals/',  '',                         0,          0,              '',                     ''),
('ServerManager',       'Controller/Globals/',  '',                         0,          0,              '',                     ''),
('SessionManager',      'Controller/Globals/',  '',                         0,          0,              '',                     ''),
('ArrayManager',        'Controller/Service/',  '',                         0,          0,              '',                     ''),
('CurlManager',         'Controller/Service/',  '',                         0,          0,              '',                     ''),
('ImageManager',        'Controller/Service/',  '',                         0,          0,              '',                     ''),
('MailManager',         'Controller/Service/',  '',                         0,          0,              '',                     ''),
('SecurityManager',     'Controller/Service/',  '',                         0,          0,              'GlobalsController',    ''),
('StringManager',       'Controller/Service/',  '',                         0,          0,              '',                     ''),
('DbInterface',         'Model/',               '',                         0,          1,              '',                     ''),
('ModelInterface',      'Model/',               '',                         0,          1,              '',                     ''),
('PdoDb',               'Model/',               'PDO $pdo',                 0,          0,              '',                     'DbInterface'),
('MainModel',           'Model/',               'DbInterface $database',    1,          0,              '',                     'ModelInterface'),
('PdoFactory',          'Model/Factory',        '',                         0,          0,              '',                     ''),
('ModelFactory',        'Model/Factory/',       '',                         0,          0,              '',                     ''),
('MainExtension',       'View/',                '',                         0,          0,              'AbstractExtension',    ''),
('GlobalsExtension',    'View/',                '',                         0,          0,              'AbstractExtension',    ''),
('ServiceExtension',    'View/',                '',                         0,          0,              'AbstractExtension',    '');

INSERT INTO `Property`
(`property`,            `visibility`,   `valor`,                                `constant`, `static`,   `class_id`)
VALUES
('DEFAULT_PATH',        '',             'App\\Controller\\\\',                  1,          0,          1),
('DEFAULT_CONTROLLER',  '',             'HomeController',                       1,          0,          1),
('DEFAULT_METHOD',      '',             'App\\Controller\\\\',                  1,          0,          1),
('$controller',         'private',      'self::DEFAULT_CONTROLLER',             0,          0,          1),
('$method',             'private',      'self::DEFAULT_METHOD',                 0,          0,          1),
('$cookie',             'private',      'CookieManager',                        0,          0,          2),
('$env',                'private',      'EnvManager',                           0,          0,          2),
('$files',              'private',      'FilesManager',                         0,          0,          2),
('$get',                'private',      'GetManager',                           0,          0,          2),
('$post',               'private',      'PostManager',                          0,          0,          2),
('$request',            'private',      'RequestManager',                       0,          0,          2),
('$server',             'private',      'ServerManager',                        0,          0,          2),
('$session',            'private',      'SessionManager',                       0,          0,          2),
('$service',            'protected',    'ServiceController',                    0,          0,          3),
('$twig',               'protected',    'Twig\\Environment',                    0,          0,          3),
('$array',              'private',      'ArrayManager',                         0,          0,          4),
('$curl',               'private',      'CurlManager',                          0,          0,          4),
('$image',              'private',      'ImageManager',                         0,          0,          4),
('$mail',               'private',      'MailManager',                          0,          0,          4),
('$security',           'private',      'SecurityManager',                      0,          0,          4),
('$string',             'private',      'StringManager',                        0,          0,          4),
('$cookie',             'private',      'filter_input_array(INPUT_COOKIE)',     0,          0,          5),
('$env',                'private',      'filter_input_array(INPUT_ENV)',        0,          0,          6),
('$files',              'private',      'filter_var_array($_FILES)',            0,          0,          7),
('$file',               'private',      '$this->files["file"]',                 0,          0,          7),
('$get',                'private',      'filter_input_array(INPUT_GET)',        0,          0,          8),
('$post',               'private',      'filter_input_array(INPUT_POST)',       0,          0,          9),
('$request',            'private',      'filter_var_array($_REQUEST)',          0,          0,          10),
('$server',             'private',      'filter_input_array(INPUT_SERVER)',     0,          0,          11),
('$session',            'private',      'filter_var_array($_SESSION)',          0,          0,          12),
('$alert',              'private',      '$this->session["alert"]',              0,          0,          12),
('$user',               'private',      '$this->session["user"]',               0,          0,          12),
('$pdo',                'private',      'PDO',                                  0,          0,          21),
('$database',           'protected',    'DbInterface',                          0,          0,          22),
('$table',              'protected',    'get_class($this)',                     0,          0,          22),
('$pdo',                'private',      'PDO',                                  0,          1,          23),
('$models',             'private',      '$class',                               0,          1,          24),
('$get',                'private',      'filter_input_array(INPUT_GET)',        0,          0,          26),
('$session',            'private',      'filter_var_array($_SESSION)',          0,          0,          26),
('$user',               'private',      '$this->session["user"]',               0,          0,          26),
('$alert',              'private',      '$this->session["alert"]',              0,          0,          26);

INSERT INTO `Method`
(`method`,              `parameters`,                                                           `return`,                   `static`,   `class_id`)
VALUES
('parseUrl',            '',                                                                     '',                         0,          1),
('setController',       '',                                                                     '',                         0,          1),
('setMethod',           '',                                                                     '',                         0,          1),
('run',                 '',                                                                     '',                         0,          1),
('getCookie',           '',                                                                     'CookieManager',            0,          2),
('getEnv',              '',                                                                     'EnvManager',               0,          2),
('getFiles',            '',                                                                     'FilesManager',             0,          2),
('getGet',              '',                                                                     'GetManager',               0,          2),
('getPost',             '',                                                                     'PostManager',              0,          2),
('getRequest',          '',                                                                     'RequestManager',           0,          2),
('getServer',           '',                                                                     'ServerManager',            0,          2),
('getSession',          '',                                                                     'SessionManager',           0,          2),
('url',                 'string $page, array $params = []',                                     'string',                   0,          3),
('redirect',            'string $page, array $params = []',                                     '',                         0,          3),
('render',              'string $view, array $params = []',                                     'string',                   0,          3),
('getArray',            '',                                                                     'ArrayManager',             0,          4),
('getCurl',             '',                                                                     'CurlManager',              0,          4),
('getImage',            '',                                                                     'ImageManager',             0,          4),
('getMail',             '',                                                                     'MailManager',              0,          4),
('getSecurity',         '',                                                                     'SecurityManager',          0,          4),
('getString',           '',                                                                     'StringManager',            0,          4),
('getCookieArray',      '',                                                                     'array',                    0,          5),
('getCookieVar',        'string $var',                                                          'mixed',                    0,          5),
('createCookie',        'string $name, string $value = "", int $expire = 0',                    'mixed|void',               0,          5),
('destroyCookie',       'string $name',                                                         '',                         0,          5),
('getEnvArray',         '',                                                                     'array',                    0,          6),
('getEnvVar',           'string $var',                                                          'mixed',                    0,          6),
('getFilesArray',       '',                                                                     'array',                    0,          7),
('getFileVar',          'string $var',                                                          'mixed',                    0,          7),
('setFileName',         'string $fileDir, string $fileName = null',                             'string',                   0,          7),
('setFileExtension',    '',                                                                     'string',                   0,          7),
('uploadFile',          'string $fileDir, string $fileName = null, int $fileSize = 50000000',   'mixed|string',             0,          7),
('getGetArray',         '',                                                                     'array',                    0,          8),
('getGetVar',           'string $var',                                                          'mixed',                    0,          8),
('getPostArray',        '',                                                                     'array',                    0,          9),
('getPostVar',          'string $var',                                                          'mixed',                    0,          9),
('getRequestArray',     '',                                                                     'array',                    0,          10),
('getRequestVar',       'string $var',                                                          'mixed',                    0,          10),
('getServerArray',      '',                                                                     'array',                    0,          11),
('getServerVar',        'string $var',                                                          'mixed',                    0,          11),
('getSessionArray',     '',                                                                     'array',                    0,          12),
('createAlert',         'string $message, string $type',                                        '',                         0,          12),
('hasAlert',            '',                                                                     'bool',                     0,          12),
('getAlertType',        'string $var',                                                          'mixed',                    0,          12),
('getAlertMessage',     '',                                                                     '',                         0,          12),
('createSession',       'array $user',                                                          '',                         0,          12),
('isLogged',            '',                                                                     'bool',                     0,          12),
('getUserVar',          'string $var',                                                          'mixed',                    0,          12),
('destroySession',      '',                                                                     '',                         0,          12),
('getArrayElements',    'array $array, string $key = "category"',                               'array $elements',          0,          13),
('getApiData',          'string $query',                                                        'mixed',                    0,          14),
('getImageType',        'string $img',                                                          'bool|false|int',           0,          15),
('inputImage',          'string $img',                                                          'false|resource|string',    0,          15),
('outputImage',         'resource $imgSrc, int $imgType, string $imgDest',                      'bool',                     0,          15),
('convertImage',        'string $imgSrc, string $imgType, string $imgDest',                     'bool|string',              0,          15),
('makeThumbnail',       'string $img, int $width = 300, string $thumbnail = null',              'bool|string',              0,          15),
('sendMessage',         'array $mail',                                                          'int',                      0,          16),
('checkRecaptcha',      'string $response',                                                     'bool',                     0,          17),
('checkIsAdmin',        '',                                                                     'bool',                     0,          17),
('cleanString',         'string $string, bool $isLow = true',                                   'string',                   0,          18),
('getData',             'string $query, array $params = []',                                    '',                         0,          19),
('getAllData',          'string $query, array $params = []',                                    '',                         0,          19),
('setData',             'string $query, array $params = []',                                    '',                         0,          19),
('listData',            'string $value = null, string $key = null',                             '',                         0,          20),
('createData',          'array $data',                                                          '',                         0,          20),
('readData',            'string $value, string $key = null',                                    '',                         0,          20),
('updateData',          'string $value, array $data, string $key = null',                       '',                         0,          20),
('deleteData',          'string $value, string $key = null',                                    '',                         0,          20),
('getData',             'string $query, array $params = []',                                    'mixed',                    0,          21),
('getAllData',          'string $query, array $params = []',                                    'array|mixed',              0,          21),
('setData',             'string $query, array $params = []',                                    'bool|mixed',               0,          21),
('listData',            'string $value = null, string $key = null',                             'array|mixed',              0,          22),
('createData',          'array $data',                                                          '',                         0,          22),
('readData',            'string $value, string $key = null',                                    'array|mixed',              0,          22),
('updateData',          'string $value, array $data, string $key = null',                       '',                         0,          22),
('deleteData',          'string $value, string $key = null',                                    '',                         0,          22),
('getPDO',              '',                                                                     'PDO|null',                 1,          23),
('getModel',            'string $table',                                                        'mixed',                    1,          24),
('url',                 'string $page, array $params = []',                                     'string',                   0,          25),
('redirect',            'string $page, array $params = []',                                     '',                         0,          25),
('getGetVar',           'string $var',                                                          '',                         0,          26),
('hasAlert',            '',                                                                     'bool',                     0,          26),
('getAlertType',        '',                                                                     'mixed',                    0,          26),
('getAlertMessage',     '',                                                                     '',                         0,          26),
('isLogged',            '',                                                                     'bool',                     0,          26),
('getUserVar',          'string $var',                                                          'mixed',                    0,          26),
('cleanString',         'string $string',                                                       'string',                   0,          27),
('getUserVar',          '',                                                                     'bool',                     0,          27);
