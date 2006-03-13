package FileHandle::Fmode;
use Fcntl qw(O_RDONLY O_WRONLY O_RDWR F_GETFL);
use strict;

require Exporter;
require DynaLoader;

$FileHandle::Fmode::VERSION = 0.02;

@FileHandle::Fmode::ISA = qw(Exporter DynaLoader);

@FileHandle::Fmode::EXPORT_OK = qw(is_R is_W is_RO is_WO is_RW);

%FileHandle::Fmode::EXPORT_TAGS = (all => [qw
    (is_R is_W is_RO is_WO is_RW)]);

if($^O =~ /mswin32/i) {
  bootstrap FileHandle::Fmode $FileHandle::Fmode::VERSION;

  *is_R  = \&win32_readable;
  *is_W  = \&win32_writable;
  *is_RO = \&win32_readable_only;
  *is_WO = \&win32_writable_only;
  *is_RW = \&win32_readable_writable;
  }

else {
  *is_R  = \&unix_readable;
  *is_W  = \&unix_writable;
  *is_RO = \&unix_readable_only;
  *is_WO = \&unix_writable_only;
  *is_RW = \&unix_readable_writable;
  }

sub unix_readable_only {
    if(!defined(fileno($_[0]))) {
      warn "Not an opened filehandle\n";
      return 0;
    }
    my $fmode = fcntl($_[0], F_GETFL, my $slush = 0);
    if(defined($fmode) && $fmode == O_RDONLY) {return 1}
    return 0;
}

sub unix_writable_only {
    if(!defined(fileno($_[0]))) {
      warn "Not an opened filehandle\n";
      return 0;
    }
    my $fmode = fcntl($_[0], F_GETFL, my $slush = 0);
    if($fmode & O_WRONLY) {return 1}
    return 0;
}

sub unix_writable {
    if(!defined(fileno($_[0]))) {
      warn "Not an opened filehandle\n";
      return 0;
    }
    my $fmode = fcntl($_[0], F_GETFL, my $slush = 0);
    if($fmode & O_WRONLY || $fmode & O_RDWR) {return 1}
    return 0;
}

sub unix_readable {
    if(!defined(fileno($_[0]))) {
      warn "Not an opened filehandle\n";
      return 0;
    }
    my $fmode = fcntl($_[0], F_GETFL, my $slush = 0);
    if($fmode && ($fmode == O_RDONLY || $fmode & O_RDWR)) {return 1}
    return 0;
}

sub unix_readable_writable {
    if(!defined(fileno($_[0]))) {
      warn "Not an opened filehandle\n";
      return 0;
    }
    my $fmode = fcntl($_[0], F_GETFL, my $slush = 0);
    if($fmode & O_RDWR) {return 1}
    return 0;
}

sub win32_readable_only {
    if(!defined(fileno($_[0]))) {
      warn "Not an opened filehandle\n";
      return 0;
    }
    if(win32_fmode($_[0]) & 1) {return 1}
    return 0;
}

sub win32_writable_only {
    if(!defined(fileno($_[0]))) {
      warn "Not an opened filehandle\n";
      return 0;
    }
    if(win32_fmode($_[0]) & 2) {return 1}
    return 0;
}

sub win32_writable {
    if(!defined(fileno($_[0]))) {
      warn "Not an opened filehandle\n";
      return 0;
    }
    my $fmode = win32_fmode($_[0]);
    if($fmode & 2 || $fmode & 128) {return 1}
    return 0;
}

sub win32_readable {
    if(!defined(fileno($_[0]))) {
      warn "Not an opened filehandle\n";
      return 0;
    }
    my $fmode = win32_fmode($_[0]);
    if($fmode & 1 || $fmode & 128) {return 1}
    return 0;
}

sub win32_readable_writable {
    if(!defined(fileno($_[0]))) {
      warn "Not an opened filehandle\n";
      return 0;
    }
    if(win32_fmode($_[0]) & 128) {return 1}
    return 0;
}

1;

__END__

=head1 NAME


FileHandle::Fmode - determine whether a filehandle is opened for reading, writing, or both.

=head1 SYNOPSIS


 use FileHandle::Fmode qw(:all);
 .
 .
 #$fh and FH are open filehandles
 print is_R($fh), "\n";
 print is_W(\*FH), "\n";

=head1 FUNCTIONS


 $bool = is_R($fh);
 $bool = is_R(\*FH);
  Returns true if the argument is readable.
  Else returns false.

 $bool = is_W($fh);
 $bool = is_W(\*FH);
  Returns true if the argument is writable.
  Else returns false

 $bool = is_RO($fh);
 $bool = is_RO(\*FH);
  Returns true if the argument is readable but not writable.
  Else returns false

 $bool = is_WO($fh);
 $bool = is_WO(\*FH);
  Returns true if the argument is writable but not readable.
  Else returns false

 $bool = is_RW($fh);
 $bool = is_RW(\*FH);
  Returns true if the argument is both readable and writable.
  Else returns false

=head1 CREDITS


 Inspired (hmmm ... is that the right word ?) by an idea from BrowserUK
 posted on PerlMonks in response to a question from dragonchild. Win32
 code (including XS code) provided by BrowserUK. Zaxo presented the idea 
 of using fcntl() in an earlier PerlMonks thread.

=head1 LICENSE


 This program is free software; you may redistribute it and/or 
 modify it under the same terms as Perl itself.

=head1 AUTHOR


 Sisyphus <kalinabears at iinet dot net dot au>

=cut
