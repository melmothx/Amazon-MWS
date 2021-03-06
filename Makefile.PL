use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Amazon::MWS',
    AUTHOR           => q{Paul Driver <paul@plainblack.com>},
    VERSION_FROM     => 'lib/Amazon/MWS/Client.pm',
    ABSTRACT_FROM    => 'lib/Amazon/MWS.pm',
    LICENSE          => 'perl',
    PL_FILES         => {},
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More'                => 0,
        'Test::MockObject'          => 0,
        'Test::MockObject::Extends' => 0,
        'HTTP::Response'            => 0,
    },
    PREREQ_PM => {
        'URI'            => 0, 
        'URI::Escape'    => 0,
        'HTTP::Request'  => 0,
        'LWP::UserAgent' => 0,
        'LWP::Protocol::https' => 0,
        'XML::Simple'    => 0,

        'DateTime'                  => 0,
        'DateTime::Format::ISO8601' => 0,

        'Readonly'         => 0,
        'Class::InsideOut' => 0,
        'Exception::Class' => 0,
        'Exporter'         => 0,

        'MIME::Base64'      => 0,
        'Digest::MD5'       => 0,
        'Digest::HMAC_SHA1' => 0,


        'Moo' => 0,
        'DBI' => 0,
        'DateTime' => 0,
        'SQL::Abstract' => 0,
        'Try::Tiny' => 0,
        'XML::Compile::Schema' => 0,
        'DateTime::Format::ISO8601' => 0,
        'XML::LibXML::Simple' => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Amazon-MWS-*' },
    META_MERGE => {
                   resources => {
                                 repository => 'https://github.com/melmothx/Amazon-MWS'
                                },
                  },
);
