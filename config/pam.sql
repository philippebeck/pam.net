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
    `extends`       VARCHAR(20),
    `detail`        VARCHAR(255)    NOT NULL UNIQUE
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `Property` (
    `id`            TINYINT         UNSIGNED    PRIMARY KEY AUTO_INCREMENT,
    `property`      VARCHAR(20)     NOT NULL,
    `visibility`    VARCHAR(10),
    `value_type`    VARCHAR(20)     NOT NULL,
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
    `detail`        VARCHAR(255)    NOT NULL,
    CONSTRAINT      `method_fk_class_id`    FOREIGN KEY (`class_id`)    REFERENCES  `Class`(`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

INSERT INTO `Constant`
(`name`, `category`, `to_replace`, `valor`)
VALUES
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
(`class`, `path`, `parameters`, `abstract`, `extends`, `detail`)
VALUES
('PdoFactory',          'Model',        '',                 0,  '',                     'The PdoFactory class defines access to the database for SQL with PDO using the factory design pattern which creates objects without having to specify the exact class of the object which will be created'),
('PdoDb',               'Model',        'PDO $pdo',         0,  '',                     'The PdoDb class defines the public methods for handling database query procedures ; if you want to customize a request : call the PdoDb method you need by providing the request, and arguments if necessary'),
('ModelFactory',        'Model',        '',                 0,  '',                     'The ModelFactory class defines access to the current model & his own database access by calling PdoFactory & using the factory design pattern which creates objects without having to specify the exact class of the object which will be created'),
('MainModel',           'Model',        'PdoDb $database',  1,  '',                     'The MainModel abstract class defines the common public methods for querying the database, therefore the listing of a table & its CRUD (Create - Read - Update - Delete) ; this class must be inherited by each model of the projects'),
('TwigExtension',       'View',         '',                 0,  'AbstractExtension',    'The MainExtension class defines the common functions accessible with Twig, like url() or redirect()'),
('FrontController',     'Controller',   '',                 0,  '',                     'The FrontController class defines the private methods to handle all requests for the projects'),
('GlobalsController',   'Controller',   '',                 1,  '',                     'The GlobalsController class defines the getters to access PHP SuperGlobals : $ _COOKIE, $ _ENV, $ _FILES, $ _GET, $ _POST, $ _REQUEST, $ _SERVER & $ _SESSION'),
('ServiceController',   'Controller',   '',                 1,  'GlobalsController',    'The ServiceController class defines the getters to access services : Array, Curl, Image, Mail, Security & String'),
('MainController',      'Controller',   '',                 1,  'ServiceController',    'The MainController abstract class defines configuration of Twig template engine with its extensions & protected methods to manage redirection & rendering');

INSERT INTO `Property`
(`property`, `visibility`, `value_type`, `static`, `class_id`)
VALUES
('$pdo',        'private',      'PDO|null',     1,  1),
('$pdo',        'private',      'PDO',          0,  2),
('$models',     'private',      'array',        1,  3),
('$database',   'protected',    'PdoDb',        0,  4),
('$table',      'protected',    'string',       0,  4),
('$alert',      'private',      'array',        0,  5),
('$get',        'private',      'array',        0,  5),
('$session',    'private',      'array',        0,  5),
('$user',       'private',      'array',        0,  5),
('$controller', 'private',      'string',       0,  6),
('$method',     'private',      'string',       0,  6),
('$cookie',     'private',      'array',        0,  7),
('$env',        'private',      'array',        0,  7),
('$files',      'private',      'array',        0,  7),
('$file',       'private',      'array',        0,  7),
('$get',        'private',      'array',        0,  7),
('$post',       'private',      'array',        0,  7),
('$request',    'private',      'array',        0,  7),
('$server',     'private',      'array',        0,  7),
('$session',    'private',      'array',        0,  7),
('$alert',      'private',      'array',        0,  7),
('$user',       'private',      'array',        0,  7),
('$twig',       'protected',    'Environment',  0,  9);

INSERT INTO `Method`
(`method`, `visibility`, `parameters`, `return`, `static`, `class_id`, `detail`)
VALUES
('getPDO',              'public',       '',                                                                     'PDO',                      1,  1,  'getPdo() is a static method who get PDO to access to an SQL database'),
('getData',             'public',       'string $query, array $params = []',                                    'mixed',                    0,  2,  'getData() uses PDO to get one result from a database table with a query by prepare it, then execute it & return the result'),
('getAllData',          'public',       'string $query, array $params = []',                                    'array|mixed',              0,  2,  'getAllData() uses PDO to get all results from a database table with a query by prepare it, then execute it & return all results'),
('setData',             'public',       'string $query, array $params = []',                                    'bool|mixed',               0,  2,  'setData() uses PDO to set one item of a database table with a query by prepare it & return his execution'),
('getModel',            'public',       'string $table',                                                        'array',                    1,  3,  'getModel() is a static method who get the current Model from the table name'),
('listData',            'public',       'string $value = null, string $key = null',                             'array|mixed',              0,  4,  'listData() lists all results from a database table & return a multidimensional array of the results'),
('createData',          'public',       'array $data',                                                          '',                         0,  4,  'createData() creates a new item of a database table from a data array'),
('readData',            'public',       'string $value, string $key = null',                                    'array|mixed',              0,  4,  'readData() reads one result from a database table with an id (or another field) & return an array of the result'),
('updateData',          'public',       'string $value, array $data, string $key = null',                       '',                         0,  4,  'updateData() updates one item of a database table from a data array & with an id (or another field)'),
('deleteData',          'public',       'string $value, string $key = null',                                    '',                         0,  4,  'deleteData() deletes one item of a database table with an id (or another field)'),
('setSession',          'public',       'array $user, bool $session = false',                                   '',                         0,  5,  'setSession() use the array $user to set user alert, or to set user session if $session = true'),
('redirect',            'public',       'string $access, array $params = []',                                   '',                         0,  5,  'redirect() creates a header with the url() methods, then exit'),
('url',                 'public',       'string $access, array $params = []',                                   'string',                   0,  5,  'url() returns an http_build_query() URL made with the url() arguments'),
('checkAdmin',          'public',       '',                                                                     'bool',                     0,  5,  'checkAdmin() returns a boolean of some checking tests about the user session'),
('checkArray',          'public',       'array $array, string $key = null',                                     'bool',                     0,  5,  'checkArray() checks an Array or a Var of an Array'),
('checkUser',           'public',       'bool $alert = false',                                                  'bool',                     0,  5,  'checkUser() checks User Alert or User Session'),
('getAlert',            'public',       'bool $type = false',                                                   '',                         0,  5,  'getAlert() gets Alert Type or Alert Message'),
('getGet',              'public',       'string $var = null',                                                   '',                         0,  5,  'getGet() gets the Get array or a Get value'),
('getSession',          'public',       'string $var = null',                                                   'mixed',                    0,  5,  'getSession() gets the Session Array, the User Array or a User Var'),
('getString',           'public',       'string $string',                                                       'string',                   0,  5,  'getString() returns an User Friendly string after manipulations'),
('parseUrl',            'private',      '',                                                                     '',                         0,  6,  'parseurl() gets the access parameter from the URL & explode() it to define the controller & the method values'),
('setController',       'private',      '',                                                                     '',                         0,  6,  'setController() manipulates strings with the controller value to create the good controller name for the new object'),
('setMethod',           'private',      '',                                                                     '',                         0,  6,  'setMethod() manipulates strings with the method value to create the good method name for the new controller'),
('run',                 'public',       '',                                                                     '',                         0,  6,  'run() creates the new controller, call the method on it, then echo() the controller response filtered'),
('setCookie',           'protected',    'string $name, string $value = "", int $expire = 0',                    'mixed|void',               0,  7,  'setCookie() creates a cookie with setCookie() from the arguments provided'),
('setSession',          'protected',    'array $user, bool $session = false',                                   '',                         0,  7,  'setSession() use the array $user to set user alert, or to set user session if $session = true'),
('checkUser',           'protected',    'bool $alert = false',                                                  'bool',                     0,  7,  'checkUser() checks User Alert or User Session'),
('getAlert',            'protected',    'bool $type = false',                                                   '',                         0,  7,  'getAlert() gets the Alert array or a Alert value'),
('getCookie',           'protected',    'string $var = null',                                                   'mixed',                    0,  7,  'getCookie() gets the Cookie array or a Cookie value'),
('getEnv',              'protected',    'string $var = null',                                                   'mixed',                    0,  7,  'getEnv() gets the Env array or a Env value'),
('getFiles',            'protected',    'string $var = null',                                                   'mixed',                    0,  7,  'getFiles() gets the Files array or a Files value'),
('getGet',              'protected',    'string $var = null',                                                   'mixed',                    0,  7,  'getGet() gets the Get array or a Get value'),
('getPost',             'protected',    'string $var = null',                                                   'mixed',                    0,  7,  'getPost() gets the Post array or a Post value'),
('getRequest',          'protected',    'string $var = null',                                                   'mixed',                    0,  7,  'getRequest() gets the Request array or a Request value'),
('getServer',           'protected',    'string $var = null',                                                   'mixed',                    0,  7,  'getServer() gets the Server array or a Server value'),
('getSession',          'protected',    'string $var = null',                                                   'array',                    0,  7,  'getSession() gets the Session array or a Session value'),
('destroyGlobal',       'protected',    'string $name = null',                                                  '',                         0,  7,  'destroyGlobal() destroy $name Cookie or current Session'),
('getApiData',          'protected',    'string $query',                                                        'mixed',                    0,  8,  'getApiData() returns a json_decode() mixed values of a response from a curl call'),
('getFilename',         'protected',    'string $fileDir, string $fileName = null',                             'string',                   0,  8,  'getFilename() returns the filename with the path, the name & the extension sets with setExtension() from the arguments provided'),
('getUploadedFile',     'protected',    'string $fileDir, string $fileName = null, int $fileSize = 50000000',   'mixed|string',             0,  8,  'getUploadedFile() returns the filename of the uploaded file after moving the the place provided as arguments'),
('getConvertedImage',   'protected',    'string $imgSrc, string $imgType, string $imgDest',                     'bool|string',              0,  8,  'getConvertedImage() converts an image with inputImage() & outputImage() from the arguments provided'),
('getExtension',        'protected',    '',                                                                     'string',                   0,  8,  'getExtension() returns a string of the extension with a dot in first (actually only for image extension)'),
('getImageType',        'protected',    'string $img',                                                          'bool|false|int',           0,  8,  'getImageType() returns the exif_imagetype() of the image provided in argument'),
('getInputImage',       'protected',    'string $img',                                                          'false|resource|string',    0,  8,  'getInputImage() returns an image resource creates with a PHP image creating function from the image provided'),
('getOutputImage',      'protected',    'resource $imgSrc, int $imgType, string $imgDest',                      'bool',                     0,  8,  'getOutputImage() returns a string creates with a PHP image display function from the image resource provided'),
('getThumbnail',        'protected',    'string $img, int $width = 300, string $thumbnail = null',              'bool|string',              0,  8,  'getThumbnail() makes a thumbnail with imagescale() & some ImageManager methods from the arguments provided'),
('sendMail',            'protected',    'array $mail',                                                          'int',                      0,  8,  'sendMail() sends a message with SwiftMailer from the array provided'),
('checkArray',          'protected',    'array $array, string $key = null',                                     'bool',                     0,  9,  'checkArray() checks an Array or a Var of an Array'),
('getArrayElements',    'protected',    'array $array, string $key = "category"',                               'array $elements',          0,  9,  'getArrayElements() returns an array of all elements who have the optional provided $key from the provided array'),
('redirect',            'protected',    'string $access, array $params = []',                                   '',                         0,  9,  'redirect() creates a header with the url() methods, then exit'),
('url',                 'protected',    'string $access, array $params = []',                                   'string',                   0,  9,  'url() returns an http_build_query() URL made with the url() arguments'),
('render',              'protected',    'string $view, array $params = []',                                     'string',                   0,  9,  'render() is a shortcut to call the Twig render() method'),
('checkAdmin',          'protected',    '',                                                                     'bool',                     0,  9,  'checkAdmin() returns a boolean of some checking tests about the user session'),
('checkRecaptcha',      'protected',    'string $response',                                                     'bool',                     0,  9,  'checkRecaptcha() returns a boolean of the Google Recaptcha checking test'),
('getString',           'protected',    'string $string, string $case = ""',                                    'string',                   0,  9,  'getString() returns a kebab-case string, but the $case parameter can be used to choose another type of case'),
('getStringCase',       'private',      'string $string, string $case',                                         '',                         0,  9,  'getStringCase() switch between each case setters that following');
