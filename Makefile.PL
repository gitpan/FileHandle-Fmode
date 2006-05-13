use ExtUtils::MakeMaker;

my %options = %{
{
  NAME     => 'FileHandle::Fmode',
  VERSION_FROM => 'Fmode.pm',
  DEFINE   => $] < 5.008 ? $] < 5.006001 ? '-DOLDPERL' : '-DPERL561_OR_LATER' : '-DPERL580_OR_LATER -DPERL561_OR_LATER',
}
};

WriteMakefile(%options);
