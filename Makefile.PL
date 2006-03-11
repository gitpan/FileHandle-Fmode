use ExtUtils::MakeMaker;

my %options = %{
{
  NAME     => 'FileHandle::Fmode',
  VERSION_FROM => 'Fmode.pm',
}
};

WriteMakefile(%options);
