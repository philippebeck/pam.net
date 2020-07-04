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
    `implements`    VARCHAR(20),
    `definition`    VARCHAR(255)    NOT NULL

)
    ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `Property`
(
    `id`            SMALLINT                UNSIGNED    PRIMARY KEY AUTO_INCREMENT,
    `property`      VARCHAR(20)             NOT NULL,
    `visibility`    VARCHAR(10),
    `value_type`    VARCHAR(20)             NOT NULL,
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
    `function`      VARCHAR(255),
    CONSTRAINT      `method_fk_class_id`    FOREIGN KEY (`class_id`)    REFERENCES  `Class`(`id`)
)
ENGINE=INNODB DEFAULT CHARSET=utf8;

INSERT INTO `Class`
(`class`,               `path`,                 `constructor`,              `abstract`, `interface`,    `extends`,               `implements`,      `definition`)
VALUES
('DbInterface',         'Model',                '',                         0,          1,              '',                     '',                 'The DbInterface interface defines the signatures of public methods for the class managing database query procedures, currently PdoDb, but this interface allows you to implement other types of database query procedures'),
('ModelInterface',      'Model',                '',                         0,          1,              '',                     '',                 'The ModelInterface interface defines the signatures of public methods for the abstract class which must be inherited from all the models of projects using Pam, currently MainModel, but this interface allows you to implement other inheritance models'),
('PdoDb',               'Model',                'PDO $pdo',                 0,          0,              '',                     'DbInterface',      'The PdoDb class defines the public methods for handling database query procedures ; if you want to customize a request : call the PdoDb method you need by providing the request, and arguments if necessary'),
('MainModel',           'Model',                'DbInterface $database',    1,          0,              '',                     'ModelInterface',   'The MainModel abstract class defines the common public methods for querying the database, therefore the listing of a table & its CRUD (Create - Read - Update - Delete) ; this class must be inherited by each model of the projects'),
('PdoFactory',          'Model\\Factory',       '',                         0,          0,              '',                     '',                 'The PdoFactory class defines access to the database for SQL with PDO using the factory design pattern which creates objects without having to specify the exact class of the object which will be created'),
('ModelFactory',        'Model\\Factory',       '',                         0,          0,              '',                     '',                 'The ModelFactory class defines access to the current model & his own database access by calling PdoFactory & using the factory design pattern which creates objects without having to specify the exact class of the object which will be created'),
('MainExtension',       'View',                 '',                         0,          0,              'AbstractExtension',    '',                 'The MainExtension class defines the common functions accessible with Twig, like url() or redirect()'),
('GlobalsExtension',    'View',                 '',                         0,          0,              'AbstractExtension',    '',                 'The GlobalsExtension class defines the functions to manage the SuperGlobals accessible with Twig, like hasAlert() or getAlertMessage()'),
('ServiceExtension',    'View',                 '',                         0,          0,              'AbstractExtension',    '',                 'The ServicesExtension class defines the functions to manage the Services accessible with Twig, like cleanString() or checkIsAdmin()'),
('FrontController',     'Controller',           '',                         0,          0,              '',                     '',                 'The FrontController class defines the public methods to handle all requests for the projects'),
('GlobalsController',   'Controller',           '',                         1,          0,              '',                     '',                 'The GlobalsController class defines the getters to access PHP SuperGlobals : $ _COOKIE, $ _ENV, $ _FILES, $ _GET, $ _POST, $ _REQUEST, $ _SERVER & $ _SESSION'),
('MainController',      'Controller',           '',                         1,          0,              'GlobalsController',    '',                 'The MainController abstract class defines access to services, configuration of Twig template engine with its extensions & public methods to manage redirection & rendering'),
('ServiceController',   'Controller',           '',                         0,          0,              '',                     '',                 'The ServiceController class defines the getters to access services : Array, Curl, Image, Mail, Security & String'),
('CookieManager',       'Controller\\Globals',  '',                         0,          0,              '',                     '',                 'The CookieManager class filter $_COOKIE SuperGlobal & defines the public methods to manage Cookies'),
('EnvManager',          'Controller\\Globals',  '',                         0,          0,              '',                     '',                 'The EnvManager class filter $_ENV SuperGlobal & defines the public methods to manage Environment'),
('FilesManager',        'Controller\\Globals',  '',                         0,          0,              '',                     '',                 'The FilesManager class filter $_FILES SuperGlobal & defines the public methods to manage Files'),
('GetManager',          'Controller\\Globals',  '',                         0,          0,              '',                     '',                 'The GetManager class filter $_GET SuperGlobal & defines the public methods to manage the Get requests'),
('PostManager',         'Controller\\Globals',  '',                         0,          0,              '',                     '',                 'The PostManager class filter $_POST SuperGlobal & defines the public methods to manage the Post requests'),
('RequestManager',      'Controller\\Globals',  '',                         0,          0,              '',                     '',                 'The RequestManager class filter $_REQUEST SuperGlobal & defines the public methods to manage the Requests'),
('ServerManager',       'Controller\\Globals',  '',                         0,          0,              '',                     '',                 'The ServerManager class filter $_SERVER SuperGlobal & defines the public methods to manage the Server data'),
('SessionManager',      'Controller\\Globals',  '',                         0,          0,              '',                     '',                 'The SessionManager class filter $_SESSION SuperGlobal & defines the public methods to manage the Sessions for Alerts & Users'),
('ArrayManager',        'Controller\\Service',  '',                         0,          0,              '',                     '',                 'The ArrayManager class defines the public methods to manage Array'),
('CurlManager',         'Controller\\Service',  '',                         0,          0,              '',                     '',                 'The CurlManager class defines the public methods to manage Curl calls'),
('ImageManager',        'Controller\\Service',  '',                         0,          0,              '',                     '',                 'The ImageManager class defines the public methods to manage Images manipulations'),
('MailManager',         'Controller\\Service',  '',                         0,          0,              '',                     '',                 'The MailManager class defines the public methods to manage Mails sent'),
('SecurityManager',     'Controller\\Service',  '',                         0,          0,              'GlobalsController',    '',                 'The SecurityManager defines the public methods to manage Security'),
('StringManager',       'Controller\\Service',  '',                         0,          0,              '',                     '',                 'The StringManager defines the public methods to manage Strings');

INSERT INTO `Property`
(`property`,            `visibility`,   `value_type`,           `constant`, `static`,   `class_id`)
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
(`method`,              `parameters`,                                                           `return`,                   `static`,   `class_id`, `function`)
VALUES
('getData',             'string $query, array $params = []',                                    '',                         0,          1,          'getData() get one result from a database table with a query'),
('getAllData',          'string $query, array $params = []',                                    '',                         0,          1,          'getAllData() get all results from a database table with a query'),
('setData',             'string $query, array $params = []',                                    '',                         0,          1,          'setData() set one item of a database table with a query'),
('listData',            'string $value = null, string $key = null',                             '',                         0,          2,          'listData() list all results from a database table'),
('createData',          'array $data',                                                          '',                         0,          2,          'createData() create a new item of a database table from a data array'),
('readData',            'string $value, string $key = null',                                    '',                         0,          2,          'readData() read one result from a database table with an id (or another field)'),
('updateData',          'string $value, array $data, string $key = null',                       '',                         0,          2,          'updateData() update one item of a database table from a data array & with an id (or another field)'),
('deleteData',          'string $value, string $key = null',                                    '',                         0,          2,          'deleteData() delete one item of a database table with an id (or another field)'),
('getData',             'string $query, array $params = []',                                    'mixed',                    0,          3,          'getData() use PDO to get one result from a database table with a query by prepare it, then execute it & return the result'),
('getAllData',          'string $query, array $params = []',                                    'array|mixed',              0,          3,          'getAllData() use PDO to get all results from a database table with a query by prepare it, then execute it & return all results'),
('setData',             'string $query, array $params = []',                                    'bool|mixed',               0,          3,          'setData() use PDO to set one item of a database table with a query by prepare it & return his execution'),
('listData',            'string $value = null, string $key = null',                             'array|mixed',              0,          4,          'listData() list all results from a database table & return a multidimensional array of the results'),
('createData',          'array $data',                                                          '',                         0,          4,          'createData() create a new item of a database table from a data array'),
('readData',            'string $value, string $key = null',                                    'array|mixed',              0,          4,          'readData() read one result from a database table with an id (or another field) & return an array of the result'),
('updateData',          'string $value, array $data, string $key = null',                       '',                         0,          4,          'updateData() update one item of a database table from a data array & with an id (or another field)'),
('deleteData',          'string $value, string $key = null',                                    '',                         0,          4,          'deleteData() delete one item of a database table with an id (or another field)'),
('getPDO',              '',                                                                     'PDO|null',                 1,          5,          'getPdo() is a static method who get PDO to access to an SQL database'),
('getModel',            'string $table',                                                        'mixed',                    1,          6,          'getModel() is a static method who get the current Model from the table name'),
('url',                 'string $page, array $params = []',                                     'string',                   0,          7,          ''),
('redirect',            'string $page, array $params = []',                                     '',                         0,          7,          ''),
('getGetVar',           'string $var',                                                          '',                         0,          8,          ''),
('hasAlert',            '',                                                                     'bool',                     0,          8,          ''),
('getAlertType',        '',                                                                     'mixed',                    0,          8,          ''),
('getAlertMessage',     '',                                                                     '',                         0,          8,          ''),
('isLogged',            '',                                                                     'bool',                     0,          8,          ''),
('getUserVar',          'string $var',                                                          'mixed',                    0,          8,          ''),
('cleanString',         'string $string',                                                       'string',                   0,          9,          ''),
('checkIsAdmin',        '',                                                                     'bool',                     0,          9,          ''),
('parseUrl',            '',                                                                     '',                         0,          10,         ''),
('setController',       '',                                                                     '',                         0,          10,         ''),
('setMethod',           '',                                                                     '',                         0,          10,         ''),
('run',                 '',                                                                     '',                         0,          10,         ''),
('getCookie',           '',                                                                     'CookieManager',            0,          11,         ''),
('getEnv',              '',                                                                     'EnvManager',               0,          11,         ''),
('getFiles',            '',                                                                     'FilesManager',             0,          11,         ''),
('getGet',              '',                                                                     'GetManager',               0,          11,         ''),
('getPost',             '',                                                                     'PostManager',              0,          11,         ''),
('getRequest',          '',                                                                     'RequestManager',           0,          11,         ''),
('getServer',           '',                                                                     'ServerManager',            0,          11,         ''),
('getSession',          '',                                                                     'SessionManager',           0,          11,         ''),
('url',                 'string $page, array $params = []',                                     'string',                   0,          12,         ''),
('redirect',            'string $page, array $params = []',                                     '',                         0,          12,         ''),
('render',              'string $view, array $params = []',                                     'string',                   0,          12,         ''),
('getArray',            '',                                                                     'ArrayManager',             0,          13,         ''),
('getCurl',             '',                                                                     'CurlManager',              0,          13,         ''),
('getImage',            '',                                                                     'ImageManager',             0,          13,         ''),
('getMail',             '',                                                                     'MailManager',              0,          13,         ''),
('getSecurity',         '',                                                                     'SecurityManager',          0,          13,         ''),
('getString',           '',                                                                     'StringManager',            0,          13,         ''),
('getCookieArray',      '',                                                                     'array',                    0,          14,         ''),
('getCookieVar',        'string $var',                                                          'mixed',                    0,          14,         ''),
('createCookie',        'string $name, string $value = "", int $expire = 0',                    'mixed|void',               0,          14,         ''),
('destroyCookie',       'string $name',                                                         '',                         0,          14,         ''),
('getEnvArray',         '',                                                                     'array',                    0,          15,         ''),
('getEnvVar',           'string $var',                                                          'mixed',                    0,          15,         ''),
('getFilesArray',       '',                                                                     'array',                    0,          16,         ''),
('getFileVar',          'string $var',                                                          'mixed',                    0,          16,         ''),
('setFileName',         'string $fileDir, string $fileName = null',                             'string',                   0,          16,         ''),
('setFileExtension',    '',                                                                     'string',                   0,          16,         ''),
('uploadFile',          'string $fileDir, string $fileName = null, int $fileSize = 50000000',   'mixed|string',             0,          16,         ''),
('getGetArray',         '',                                                                     'array',                    0,          17,         ''),
('getGetVar',           'string $var',                                                          'mixed',                    0,          17,         ''),
('getPostArray',        '',                                                                     'array',                    0,          18,         ''),
('getPostVar',          'string $var',                                                          'mixed',                    0,          18,         ''),
('getRequestArray',     '',                                                                     'array',                    0,          19,         ''),
('getRequestVar',       'string $var',                                                          'mixed',                    0,          19,         ''),
('getServerArray',      '',                                                                     'array',                    0,          20,         ''),
('getServerVar',        'string $var',                                                          'mixed',                    0,          20,         ''),
('getSessionArray',     '',                                                                     'array',                    0,          21,         ''),
('createAlert',         'string $message, string $type',                                        '',                         0,          21,         ''),
('hasAlert',            '',                                                                     'bool',                     0,          21,         ''),
('getAlertType',        'string $var',                                                          'mixed',                    0,          21,         ''),
('getAlertMessage',     '',                                                                     '',                         0,          21,         ''),
('createSession',       'array $user',                                                          '',                         0,          21,         ''),
('isLogged',            '',                                                                     'bool',                     0,          21,         ''),
('getUserVar',          'string $var',                                                          'mixed',                    0,          21,         ''),
('destroySession',      '',                                                                     '',                         0,          21,         ''),
('getArrayElements',    'array $array, string $key = "category"',                               'array $elements',          0,          22,         ''),
('getApiData',          'string $query',                                                        'mixed',                    0,          23,         ''),
('getImageType',        'string $img',                                                          'bool|false|int',           0,          24,         ''),
('inputImage',          'string $img',                                                          'false|resource|string',    0,          24,         ''),
('outputImage',         'resource $imgSrc, int $imgType, string $imgDest',                      'bool',                     0,          24,         ''),
('convertImage',        'string $imgSrc, string $imgType, string $imgDest',                     'bool|string',              0,          24,         ''),
('makeThumbnail',       'string $img, int $width = 300, string $thumbnail = null',              'bool|string',              0,          24,         ''),
('sendMessage',         'array $mail',                                                          'int',                      0,          25,         ''),
('checkRecaptcha',      'string $response',                                                     'bool',                     0,          26,         ''),
('checkIsAdmin',        '',                                                                     'bool',                     0,          26,         ''),
('cleanString',         'string $string, bool $isLow = true',                                   'string',                   0,          27,         '');
