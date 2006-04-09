#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#ifdef _WIN32

/*
 * Win32 code supplied by BrowserUK
 * to work aroumd the MS C runtime library's
 * lack of a function to retrieve the file mode
 * used when a file is opened
*/

SV * win32_fmode( FILE *stream ) {
    return newSVuv(stream->_flag);
}

#else

SV * win32_fmode( FILE *stream ) {
     croak("win32_fmode() function works only with Win32");
}

#endif

#ifdef PERL58

/*
 * XS code to deal with filehandles
 * attached to memory objects supplied
 * by attn.steven.kuo. (Applies only
 * to perl 5.8 and later.)
*/

#include <perliol.h>

SV * perliol_readable(SV * handle) {
     IV flags;
     IO *io;
     PerlIO *f;
     io = sv_2io(handle);
     f  = IoIFP(io);
     if(PerlIOValid(f)){
       const IV flags = PerlIOBase(f)->flags;
       if(flags & PERLIO_F_CANREAD) return newSVuv(1);
       return newSVuv(0);
     }
     croak("Couldn't validate the filehandle passed to perliol_readable()");
}

SV * perliol_writable(SV * handle) {
     IV flags;
     IO *io;
     PerlIO *f;
     io = sv_2io(handle);
     f  = IoIFP(io);
     if(PerlIOValid(f)){
       flags = PerlIOBase(f)->flags;
       if(flags & PERLIO_F_CANWRITE) return newSVuv(1);
       return newSVuv(0);
     }
     croak("Couldn't validate the filehandle passed to perliol_writable()");
}

#else

SV * perliol_readable(SV * handle) {
     croak("perliol_readable() function works only with perl 5.8 or later");
}
SV * perliol_writable( SV * handle ) {
     croak("perliol_writable() function works only with perl 5.8 or later");
}

#endif

MODULE = FileHandle::Fmode	PACKAGE = FileHandle::Fmode

PROTOTYPES: DISABLE

SV *
win32_fmode (stream)
	FILE *stream 

SV *
perliol_readable (handle)
	SV *handle

SV *
perliol_writable (handle)
	SV *handle 

