use ExtUtils::MakeMaker;
WriteMakefile(
    NAME         => 'Tree::Simple::SAX',
    VERSION_FROM => 'lib/Tree/Simple/SAX.pm', 
    PREREQ_PM    => {
        'Test::More' => 0.47,
    }
);
