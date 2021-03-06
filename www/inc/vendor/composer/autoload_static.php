<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInitf8a4d0e45efaafe709cd67855c4d3c3d
{
    public static $prefixLengthsPsr4 = array (
        'P' => 
        array (
            'PHPMailer\\PHPMailer\\' => 20,
        ),
        'F' => 
        array (
            'Firebase\\JWT\\' => 13,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'PHPMailer\\PHPMailer\\' => 
        array (
            0 => __DIR__ . '/..' . '/phpmailer/phpmailer/src',
        ),
        'Firebase\\JWT\\' => 
        array (
            0 => __DIR__ . '/..' . '/firebase/php-jwt/src',
        ),
    );

    public static $classMap = array (
        'Composer\\InstalledVersions' => __DIR__ . '/..' . '/composer/InstalledVersions.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInitf8a4d0e45efaafe709cd67855c4d3c3d::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInitf8a4d0e45efaafe709cd67855c4d3c3d::$prefixDirsPsr4;
            $loader->classMap = ComposerStaticInitf8a4d0e45efaafe709cd67855c4d3c3d::$classMap;

        }, null, ClassLoader::class);
    }
}
