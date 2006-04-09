use ExtUtils::MakeMaker;

my %options = %{
{
  NAME     => 'FileHandle::Fmode',
  VERSION_FROM => 'Fmode.pm',
  DEFINE   => $] < 5.008 ? "-DOLDPERL" : "-DPERL58",
}
};

WriteMakefile(%options);
