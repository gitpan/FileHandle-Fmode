#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/* For Win32 only. Code supplied by BrowserUK
 * to work aroumd the MS C runtime library's
 * lack of a function to retrieve the file mode
 * used when a file is opened
*/

#ifdef _WIN32

SV * win32_fmode( FILE *stream ) {
    return newSVuv(stream->_flag);
}

#endif

MODULE = FileHandle::Fmode	PACKAGE = FileHandle::Fmode

PROTOTYPES: DISABLE

SV *
win32_fmode (stream)
	FILE *stream  

