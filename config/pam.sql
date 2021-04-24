DROP DATABASE IF EXISTS `pam`;
CREATE DATABASE `pam` CHARACTER SET utf8;

USE `pam`;

CREATE TABLE `Constant` (
    `id`            TINYINT         UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
    `name`          VARCHAR(20)     NOT NULL  UNIQUE ,
    `category`      VARCHAR(10)     NOT NULL,
    `to_replace`    TINYINT(1)      NOT NULL,
    `valor`         VARCHAR(120)    NOT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `Class` (
    `id`            TINYINT         UNSIGNED    PRIMARY KEY AUTO_INCREMENT,
    `class`         VARCHAR(20)     NOT NULL    UNIQUE,
    `path`          VARCHAR(20)     NOT NULL,
    `parameters`    VARCHAR(30),
    `abstract`      TINYINT(1)      UNSIGNED    NOT NULL,
    `interface`     TINYINT(1)      UNSIGNED    NOT NULL,
    `extends`       VARCHAR(20),
    `implements`    VARCHAR(20),
    `definition`    VARCHAR(255)    NOT NULL UNIQUE
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `Property` (
    `id`            TINYINT         UNSIGNED    PRIMARY KEY AUTO_INCREMENT,
    `property`      VARCHAR(20)     NOT NULL,
    `visibility`    VARCHAR(10),
    `value_type`    VARCHAR(20)     NOT NULL,
    `constant`      TINYINT(1)      UNSIGNED    NOT NULL,
    `static`        TINYINT(1)      UNSIGNED    NOT NULL,
    `class_id`      TINYINT         UNSIGNED    NOT NULL,
    CONSTRAINT `property_fk_class_id` FOREIGN KEY (`class_id`) REFERENCES `Class`(`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `Method` (
    `id`            TINYINT         UNSIGNED    PRIMARY KEY AUTO_INCREMENT,
    `method`        VARCHAR(20)     NOT NULL,
    `visibility`    VARCHAR(10)     NOT NULL,
    `parameters`    VARCHAR(70),
    `return`        VARCHAR(30),
    `static`        TINYINT(1)      UNSIGNED    NOT NULL,
    `class_id`      TINYINT         UNSIGNED    NOT NULL,
    `function`      VARCHAR(255)    NOT NULL,
    CONSTRAINT      `method_fk_class_id`    FOREIGN KEY (`class_id`)    REFERENCES  `Class`(`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

INSERT INTO `Constant`
(`name`, `category`, `to_replace`, `valor`) VALUES
('ACCESS_KEY',          'access',       0,  'access'),
('ACCESS_DELIMITER',    'access',       0,  '!'),
('CTRL_PATH',           'controller',   0,  'App\\Controller\\\\'),
('CTRL_DEFAULT',        'controller',   0,  'Home'),
('CTRL_NAME',           'controller',   0,  'Controller'),
('CTRL_METHOD_DEFAULT', 'controller',   0,  'default'),
('CTRL_METHOD_NAME',    'controller',   0,  'Method'),
('DB_HOST',             'database',     1,  'localhost'),
('DB_NAME',             'database',     1,  'database_name'),
('DB_USER',             'database',     1,  'database_username'),
('DB_PASS',             'database',     1,  'database_user_password'),
('DB_OPTIONS',          'database',     0,  'array( PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION )'),
('MAIL_HOST',           'mail',         1,  'mail.host.com'),
('MAIL_PORT',           'mail',         1,  '000'),
('MAIL_FROM',           'mail',         1,  'mail@host.com'),
('MAIL_PASSWORD',       'mail',         1,  'mail-user-password'),
('MAIL_TO',             'mail',         1,  'mail@host.com'),
('MAIL_USERNAME',       'mail',         1,  'mail-username'),
('MODEL_PATH',          'model',        0,  'App\\Model\\\\'),
('MODEL_NAME',          'model',        0,  'Model'),
('RECAPTCHA_TOKEN',     'recaptcha',    1,  'website-token'),
('VIEW_PATH',           'view',         0,  '../src/View'),
('VIEW_CACHE',          'view',         1,  'false');

INSERT INTO `Class`
(`class`, `path`, `parameters`, `abstract`, `interface`, `extends`, `implements`, `definition`) VALUES
('DbInterface',         'Model',                '',                         0,  1,  '',                     '',                 'The DbInterface interface defines the signatures of public methods for the class managing database query procedures, currently PdoDb, but this interface allows you to implement other types of database query procedures'),
('ModelInterface',      'Model',                '',                         0,  1,  '',                     '',                 'The ModelInterface interface defines the signatures of public methods for the abstract class which must be inherited from all the models of projects using Pam, currently MainModel, but this interface allows you to implement other inheritance models'),
('PdoDb',               'Model',                'PDO $pdo',                 0,  0,  '',                     'DbInterface',      'The PdoDb class defines the public methods for handling database query procedures ; if you want to customize a request : call the PdoDb method you need by providing the request, and arguments if necessary'),
('MainModel',           'Model',                'DbInterface $database',    1,  0,  '',                     'ModelInterface',   'The MainModel abstract class defines the common public methods for querying the database, therefore the listing of a table & its CRUD (Create - Read - Update - Delete) ; this class must be inherited by each model of the projects'),
('PdoFactory',          'Model\\Factory',       '',                         0,  0,  '',                     '',                 'The PdoFactory class defines access to the database for SQL with PDO using the factory design pattern which creates objects without having to specify the exact class of the object which will be created'),
('ModelFactory',        'Model\\Factory',       '',                         0,  0,  '',                     '',                 'The ModelFactory class defines access to the current model & his own database access by calling PdoFactory & using the factory design pattern which creates objects without having to specify the exact class of the object which will be created'),
('MainExtension',       'View',                 '',                         0,  0,  'AbstractExtension',    '',                 'The MainExtension class defines the common functions accessible with Twig, like url() or redirect()'),
('GlobalsExtension',    'View',                 '',                         0,  0,  'AbstractExtension',    '',                 'The GlobalsExtension class defines the functions to manage the SuperGlobals accessible with Twig, like hasAlert() or getAlertMessage()'),
('ServiceExtension',    'View',                 '',                         0,  0,  'AbstractExtension',    '',                 'The ServicesExtension class defines the functions to manage the Services accessible with Twig, like cleanString() or checkIsAdmin()'),
('FrontController',     'Controller',           '',                         0,  0,  '',                     '',                 'The FrontController class defines the private methods to handle all requests for the projects'),
('GlobalsController',   'Controller',           '',                         1,  0,  '',                     '',                 'The GlobalsController class defines the getters to access PHP SuperGlobals : $ _COOKIE, $ _ENV, $ _FILES, $ _GET, $ _POST, $ _REQUEST, $ _SERVER & $ _SESSION'),
('MainController',      'Controller',           '',                         1,  0,  'ServiceController',    '',                 'The MainController abstract class defines configuration of Twig template engine with its extensions & protected methods to manage redirection & rendering'),
('ServiceController',   'Controller',           '',                         1,  0,  'GlobalsController',    '',                 'The ServiceController class defines the getters to access services : Array, Curl, Image, Mail, Security & String'),
('CookieManager',       'Controller\\Globals',  '',                         0,  0,  '',                     '',                 'The CookieManager class filter $_COOKIE SuperGlobal & defines the public methods to manage Cookies'),
('EnvManager',          'Controller\\Globals',  '',                         0,  0,  '',                     '',                 'The EnvManager class filter $_ENV SuperGlobal & defines the public methods to manage Environment'),
('FilesManager',        'Controller\\Globals',  '',                         0,  0,  '',                     '',                 'The FilesManager class filter $_FILES SuperGlobal & defines the public methods to manage Files'),
('GetManager',          'Controller\\Globals',  '',                         0,  0,  '',                     '',                 'The GetManager class filter $_GET SuperGlobal & defines the public methods to manage the Get requests'),
('PostManager',         'Controller\\Globals',  '',                         0,  0,  '',                     '',                 'The PostManager class filter $_POST SuperGlobal & defines the public methods to manage the Post requests'),
('RequestManager',      'Controller\\Globals',  '',                         0,  0,  '',                     '',                 'The RequestManager class filter $_REQUEST SuperGlobal & defines the public methods to manage the Requests'),
('ServerManager',       'Controller\\Globals',  '',                         0,  0,  '',                     '',                 'The ServerManager class filter $_SERVER SuperGlobal & defines the public methods to manage the Server data'),
('SessionManager',      'Controller\\Globals',  '',                         0,  0,  '',                     '',                 'The SessionManager class filter $_SESSION SuperGlobal & defines the public methods to manage the Sessions for Alerts & Users'),
('ArrayManager',        'Controller\\Service',  '',                         0,  0,  '',                     '',                 'The ArrayManager class defines a public method to manage Array'),
('CurlManager',         'Controller\\Service',  '',                         0,  0,  '',                     '',                 'The CurlManager class defines a public method to manage Curl calls'),
('ImageManager',        'Controller\\Service',  '',                         0,  0,  '',                     '',                 'The ImageManager class defines the public methods to manage Images manipulations'),
('MailManager',         'Controller\\Service',  '',                         0,  0,  '',                     '',                 'The MailManager class defines a public method to manage Mails sent'),
('SecurityManager',     'Controller\\Service',  '',                         0,  0,  'GlobalsController',    '',                 'The SecurityManager defines the public methods to manage Security'),
('StringManager',       'Controller\\Service',  '',                         0,  0,  '',                     '',                 'The StringManager defines a public method to manage Strings & private methods to set them');

INSERT INTO `Property`
(`property`, `visibility`, `value_type`, `constant`, `static`, `class_id`) VALUES
('$pdo',        'private',      'PDO',                  0,  0,  3),
('$database',   'protected',    'DbInterface',          0,  0,  4),
('$table',      'protected',    'string',               0,  0,  4),
('$pdo',        'private',      'PDO',                  0,  1,  5),
('$models',     'private',      'array',                0,  1,  6),
('$get',        'private',      'array',                0,  0,  8),
('$session',    'private',      'array',                0,  0,  8),
('$user',       'private',      'array',                0,  0,  8),
('$alert',      'private',      'array',                0,  0,  8),
('$controller', 'private',      'string',               0,  0,  10),
('$method',     'private',      'string',               0,  0,  10),
('$cookie',     'private',      'CookieManager',        0,  0,  11),
('$env',        'private',      'EnvManager',           0,  0,  11),
('$files',      'private',      'FilesManager',         0,  0,  11),
('$get',        'private',      'GetManager',           0,  0,  11),
('$post',       'private',      'PostManager',          0,  0,  11),
('$request',    'private',      'RequestManager',       0,  0,  11),
('$server',     'private',      'ServerManager',        0,  0,  11),
('$session',    'private',      'SessionManager',       0,  0,  11),
('$twig',       'protected',    'Twig\\Environment',    0,  0,  12),
('$array',      'private',      'ArrayManager',         0,  0,  13),
('$curl',       'private',      'CurlManager',          0,  0,  13),
('$image',      'private',      'ImageManager',         0,  0,  13),
('$mail',       'private',      'MailManager',          0,  0,  13),
('$security',   'private',      'SecurityManager',      0,  0,  13),
('$string',     'private',      'StringManager',        0,  0,  13),
('$cookie',     'private',      'array',                0,  0,  14),
('$env',        'private',      'array',                0,  0,  15),
('$files',      'private',      'array',                0,  0,  16),
('$file',       'private',      'array',                0,  0,  16),
('$get',        'private',      'array',                0,  0,  17),
('$post',       'private',      'array',                0,  0,  18),
('$request',    'private',      'array',                0,  0,  19),
('$server',     'private',      'array',                0,  0,  20),
('$session',    'private',      'array',                0,  0,  21),
('$alert',      'private',      'array',                0,  0,  21),
('$user',       'private',      'array',                0,  0,  21);

INSERT INTO `Method`
(`method`, `visibility`, `parameters`, `return`, `static`, `class_id`, `function`) VALUES
('getData',                 'public',       'string $query, array $params = []',                                    '',                         0,  1,  'getData() gets one result from a database table with a query'),
('getAllData',              'public',       'string $query, array $params = []',                                    '',                         0,  1,  'getAllData() gets all results from a database table with a query'),
('setData',                 'public',       'string $query, array $params = []',                                    '',                         0,  1,  'setData() sets one item of a database table with a query'),
('listData',                'public',       'string $value = null, string $key = null',                             '',                         0,  2,  'listData() lists all results from a database table'),
('createData',              'public',       'array $data',                                                          '',                         0,  2,  'createData() creates a new item of a database table from a data array'),
('readData',                'public',       'string $value, string $key = null',                                    '',                         0,  2,  'readData() reads one result from a database table with an id (or another field)'),
('updateData',              'public',       'string $value, array $data, string $key = null',                       '',                         0,  2,  'updateData() updates one item of a database table from a data array & with an id (or another field)'),
('deleteData',              'public',       'string $value, string $key = null',                                    '',                         0,  2,  'deleteData() deletes one item of a database table with an id (or another field)'),
('getData',                 'public',       'string $query, array $params = []',                                    'mixed',                    0,  3,  'getData() uses PDO to get one result from a database table with a query by prepare it, then execute it & return the result'),
('getAllData',              'public',       'string $query, array $params = []',                                    'array|mixed',              0,  3,  'getAllData() uses PDO to get all results from a database table with a query by prepare it, then execute it & return all results'),
('setData',                 'public',       'string $query, array $params = []',                                    'bool|mixed',               0,  3,  'setData() uses PDO to set one item of a database table with a query by prepare it & return his execution'),
('listData',                'public',       'string $value = null, string $key = null',                             'array|mixed',              0,  4,  'listData() lists all results from a database table & return a multidimensional array of the results'),
('createData',              'public',       'array $data',                                                          '',                         0,  4,  'createData() creates a new item of a database table from a data array'),
('readData',                'public',       'string $value, string $key = null',                                    'array|mixed',              0,  4,  'readData() reads one result from a database table with an id (or another field) & return an array of the result'),
('updateData',              'public',       'string $value, array $data, string $key = null',                       '',                         0,  4,  'updateData() updates one item of a database table from a data array & with an id (or another field)'),
('deleteData',              'public',       'string $value, string $key = null',                                    '',                         0,  4,  'deleteData() deletes one item of a database table with an id (or another field)'),
('getPDO',                  'public',       '',                                                                     'PDO|null',                 1,  5,  'getPdo() is a static method who get PDO to access to an SQL database'),
('getModel',                'public',       'string $table',                                                        'mixed',                    1,  6,  'getModel() is a static method who get the current Model from the table name'),
('url',                     'public',       'string $access, array $params = []',                                   'string',                   0,  7,  'url() returns an http_build_query() URL made with the url() arguments'),
('redirect',                'public',       'string $access, array $params = []',                                   '',                         0,  7,  'redirect() creates a header with the url() methods, then exit'),
('getGetVar',               'public',       'string $var',                                                          '',                         0,  8,  'getGetVar() returns a value of the $_GET array filtered from the argument provided'),
('hasAlert',                'public',       '',                                                                     'bool',                     0,  8,  'hasAlert() returns the boolean result of a strict equality test on the empty() method with the alert array in argument'),
('getAlertType',            'public',       '',                                                                     'mixed',                    0,  8,  'getAlertType() returns the alert type if alert is set'),
('getAlertMessage',         'public',       '',                                                                     '',                         0,  8,  'getAlertMessage() echo() the alert message, then unset() it, if alert is set'),
('isLogged',                'public',       '',                                                                     'bool',                     0,  8,  'isLogged() returns a boolean to check if the user has a session started'),
('getUserVar',              'public',       'string $var',                                                          'mixed',                    0,  8,  'getUserVar() returns a value of the $_SESSION["user"] array filtered from the argument provided'),
('checkIsAdmin',            'public',       '',                                                                     'bool',                     0,  9,  'checkIsAdmin() returns a boolean of some checking tests about the user session'),
('cleanString',             'public',       'string $string',                                                       'string',                   0,  9,  'cleanString() returns an User Friendly string after manipulations'),
('parseUrl',                'private',      '',                                                                     '',                         0,  10, 'parseurl() gets the access parameter from the URL & explode() it to define the controller & the method values'),
('setController',           'private',      '',                                                                     '',                         0,  10, 'setController() manipulates strings with the controller value to create the good controller name for the new object'),
('setMethod',               'private',      '',                                                                     '',                         0,  10, 'setMethod() manipulates strings with the method value to create the good method name for the new controller'),
('run',                     'public',       '',                                                                     '',                         0,  10, 'run() creates the new controller, call the method on it, then echo() the controller response filtered'),
('getCookie',               'protected',    '',                                                                     'CookieManager',            0,  11, 'getCookie() returns the CookieManager, to manage the $_COOKIE SuperGlobal'),
('getEnv',                  'protected',    '',                                                                     'EnvManager',               0,  11, 'getEnv() returns the EnvManager, to manage the $_ENV SuperGlobal'),
('getFiles',                'protected',    '',                                                                     'FilesManager',             0,  11, 'getFiles() returns the FilesManager, to manage the $_FILES SuperGlobal'),
('getGet',                  'protected',    '',                                                                     'GetManager',               0,  11, 'getGet() returns the GetManager, to manage the $_GET SuperGlobal'),
('getPost',                 'protected',    '',                                                                     'PostManager',              0,  11, 'getPost() returns the PostManager, to manage the $_POST SuperGlobal'),
('getRequest',              'protected',    '',                                                                     'RequestManager',           0,  11, 'getRequest() returns the RequestManager, to manage the $_REQUEST SuperGlobal'),
('getServer',               'protected',    '',                                                                     'ServerManager',            0,  11, 'getServer() returns the ServerManager, to manage the $_SERVER SuperGlobal'),
('getSession',              'protected',    '',                                                                     'SessionManager',           0,  11, 'getSession() returns the SessionManager, to manage the $_SESSION SuperGlobal'),
('url',                     'protected',    'string $access, array $params = []',                                   'string',                   0,  12, 'url() returns an http_build_query() URL made with the url() arguments'),
('redirect',                'protected',    'string $access, array $params = []',                                   '',                         0,  12, 'redirect() creates a header with the url() methods, then exit'),
('render',                  'protected',    'string $view, array $params = []',                                     'string',                   0,  12, 'render() is a shortcut to call the Twig render() method'),
('getArray',                'protected',    '',                                                                     'ArrayManager',             0,  13, 'getArray() returns the ArrayManager, to manage the Array Services'),
('getCurl',                 'protected',    '',                                                                     'CurlManager',              0,  13, 'getCurl() returns the CurlManager, to manage the Curl Services'),
('getImage',                'protected',    '',                                                                     'ImageManager',             0,  13, 'getImage() returns the ImageManager, to manage the Image Services'),
('getMail',                 'protected',    '',                                                                     'MailManager',              0,  13, 'getMail() returns the MailManager, to manage the Mail Services'),
('getSecurity',             'protected',    '',                                                                     'SecurityManager',          0,  13, 'getSecurity() returns the SecurityManager, to manage the Security Services'),
('getString',               'protected',    '',                                                                     'StringManager',            0,  13, 'getString() returns the StringManager, to manage the String Services'),
('getCookieArray',          'public',       '',                                                                     'array',                    0,  14, 'getCookieArray() returns the $_COOKIE array filtered'),
('getCookieVar',            'public',       'string $var',                                                          'mixed',                    0,  14, 'getCookieVar() returns a value of the $_COOKIE array filtered from the argument provided'),
('createCookie',            'public',       'string $name, string $value = "", int $expire = 0',                    'mixed|void',               0,  14, 'createCookie() creates a cookie with setCookie() from the arguments provided'),
('destroyCookie',           'public',       'string $name',                                                         '',                         0,  14, 'destroyCookie() destroys a cookie with createCookie() from the cookie name provided'),
('getEnvArray',             'public',       '',                                                                     'array',                    0,  15, 'getEnvArray() returns the $_ENV array filtered'),
('getEnvVar',               'public',       'string $var',                                                          'mixed',                    0,  15, 'getEnvVar() returns a value of the $_ENV array filtered from the argument provided'),
('getFilesArray',           'public',       '',                                                                     'array',                    0,  16, 'getFilesArray() returns the $_FILES array filtered'),
('getFileVar',              'public',       'string $var',                                                          'mixed',                    0,  16, 'getFileVar() returns a value of the $_FILES["file"] array filtered from the argument provided'),
('setFileName',             'public',       'string $fileDir, string $fileName = null',                             'string',                   0,  16, 'setFileName() returns the filename with the path, the name & the extension sets with setExtension() from the arguments provided'),
('setFileExtension',        'public',       '',                                                                     'string',                   0,  16, 'setFileExtension() returns a string of the extension with a dot in first (actually only for image extension)'),
('uploadFile',              'public',       'string $fileDir, string $fileName = null, int $fileSize = 50000000',   'mixed|string',             0,  16, 'uploadFile() returns the filename of the uploaded file after moving the the place provided as arguments'),
('getGetArray',             'public',       '',                                                                     'array',                    0,  17, 'getGetArray() returns the $_GET array filtered'),
('getGetVar',               'public',       'string $var',                                                          'mixed',                    0,  17, 'getGetVar() returns a value of the $_GET array filtered from the argument provided'),
('getPostArray',            'public',       '',                                                                     'array',                    0,  18, 'getPostArray() returns the $_POST array filtered'),
('getPostVar',              'public',       'string $var',                                                          'mixed',                    0,  18, 'getPostVar() returns a value of the $_POST array filtered from the argument provided'),
('getRequestArray',         'public',       '',                                                                     'array',                    0,  19, 'getRequestArray() returns the $_REQUEST array filtered'),
('getRequestVar',           'public',       'string $var',                                                          'mixed',                    0,  19, 'getRequestVar() returns a value of the $_REQUEST array filtered from the argument provided'),
('getServerArray',          'public',       '',                                                                     'array',                    0,  20, 'getServerArray() returns the $_SERVER array filtered'),
('getServerVar',            'public',       'string $var',                                                          'mixed',                    0,  20, 'getServerVar() returns a value of the $_SERVER array filtered from the argument provided'),
('getSessionArray',         'public',       '',                                                                     'array',                    0,  21, 'getSessionArray() returns the $_SESSION array filtered'),
('createAlert',             'public',       'string $message, string $type',                                        '',                         0,  21, 'createAlert() creates an alert by setting it in the $_SESSION["alert"] array'),
('hasAlert',                'public',       '',                                                                     'bool',                     0,  21, 'hasAlert() returns the boolean result of a strict equality test on the empty() method with the alert array in argument'),
('getAlertType',            'public',       'string $var',                                                          'mixed',                    0,  21, 'getAlertType() returns the alert type if alert is set'),
('getAlertMessage',         'public',       '',                                                                     '',                         0,  21, 'getAlertMessage() echo() the alert message, then unset() it, if alert is set'),
('createSession',           'public',       'array $user',                                                          '',                         0,  21, 'createSession() creates a session by setting it in the $_SESSION["user"] array'),
('isLogged',                'public',       '',                                                                     'bool',                     0,  21, 'isLogged() returns a boolean to check if the user has a session started'),
('getUserVar',              'public',       'string $var',                                                          'mixed',                    0,  21, 'getUserVar() returns a value of the $_SESSION["user"] array filtered from the argument provided'),
('destroySession',          'public',       '',                                                                     '',                         0,  21, 'destroySession() destroys the user session with session_destroy()'),
('getArrayElements',        'public',       'array $array, string $key = "category"',                               'array $elements',          0,  22, 'getArrayElements() returns an array of all elements who have the optional provided $key from the provided array'),
('getApiData',              'public',       'string $query',                                                        'mixed',                    0,  23, 'getApiData() returns a json_decode() mixed values of a response from a curl call'),
('getImageType',            'public',       'string $img',                                                          'bool|false|int',           0,  24, 'getImageType() returns the exif_imagetype() of the image provided in argument'),
('inputImage',              'public',       'string $img',                                                          'false|resource|string',    0,  24, 'inputImage() returns an image resource creates with a PHP image creating function from the image provided'),
('outputImage',             'public',       'resource $imgSrc, int $imgType, string $imgDest',                      'bool',                     0,  24, 'outputImage() returns a string creates with a PHP image display function from the image resource provided'),
('convertImage',            'public',       'string $imgSrc, string $imgType, string $imgDest',                     'bool|string',              0,  24, 'convertImage() converts an image with inputImage() & outputImage() from the arguments provided'),
('makeThumbnail',           'public',       'string $img, int $width = 300, string $thumbnail = null',              'bool|string',              0,  24, 'makeThumbnail() makes a thumbnail with imagescale() & some ImageManager methods from the arguments provided'),
('sendMessage',             'public',       'array $mail',                                                          'int',                      0,  25, 'sendMessage() sends a message with SwiftMailer from the array provided'),
('checkRecaptcha',          'public',       'string $response',                                                     'bool',                     0,  26, 'checkRecaptcha() returns a boolean of the Google Recaptcha checking test'),
('checkIsAdmin',            'public',       '',                                                                     'bool',                     0,  26, 'checkIsAdmin() returns a boolean of some checking tests about the user session'),
('cleanString',             'public',       'string $string, bool $case = ""',                                      'string',                   0,  27, 'cleanString() returns a kebab-case string, but the $case parameter can be used to choose another type of case'),
('setStandardLetters',      'private',      '',                                                                     '',                         0,  27, 'setStandardLetters() replace special letters to normal letters, mainly the vowels'),
('setStandardCharacters',   'private',      '',                                                                     '',                         0,  27, 'setStandardCharacters() replace all special characters to space & reduct multiple spaces to one'),
('setCase',                 'private',      'string $case',                                                         '',                         0,  27, 'setCase() switch between each case setters that following'),
('setAlphaCase',            'private',      '',                                                                     '',                         0,  27, 'setAlphaCase() remove all non-alphanumeric characters'),
('setCamelCase',            'private',      '',                                                                     '',                         0,  27, 'setCamelCase() transform string to camelCase'),
('setConstCase',            'private',      '',                                                                     '',                         0,  27, 'setConstCase() transform string to CONST_CASE'),
('setCramCase',             'private',      '',                                                                     '',                         0,  27, 'setCramCase() transform string to cramcase'),
('setDotCase',              'private',      '',                                                                     '',                         0,  27, 'setDotCase() transform string to dot.case'),
('setEnumCase',             'private',      '',                                                                     '',                         0,  27, 'setEnumCase() transform string to enum:case'),
('setKebabCase',            'private',      '',                                                                     '',                         0,  27, 'setKebabCase() transform string to kebab-case'),
('setNameCase',             'private',      '',                                                                     '',                         0,  27, 'setNameCase() transform string to Title Case & remove numbers'),
('setPascalCase',           'private',      '',                                                                     '',                         0,  27, 'setPascalCase() transform string to PascalCase'),
('setPathCase',             'private',      '',                                                                     '',                         0,  27, 'setPathCase() transform string to path/case'),
('setSnakeCase',            'private',      '',                                                                     '',                         0,  27, 'setSnakeCase() transform string to snake_case'),
('setTitleCase',            'private',      '',                                                                     '',                         0,  27, 'setTitleCase() transform string to Title Case');