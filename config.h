/* config.h.  Generated from config.h.in by configure.  */
/* config.h.in.  Generated from configure.ac by autoheader.  */

/* Define if building universal (internal helper macro) */
/* #undef AC_APPLE_UNIVERSAL_BUILD */

/* Define to enable internal Loris debugging code (not recommended). */
/* #undef Debug_Loris */

/* Define to 1 if you have the <csdl.h> header file. */
/* #undef HAVE_CSDL_H */

/* define if the compiler supports basic C++11 syntax */
/* #undef HAVE_CXX11 */

/* Define to 1 if you have the <dlfcn.h> header file. */
#define HAVE_DLFCN_H 1

/* Define to 1 if you have the <fftw3.h> header file. */
/* #undef HAVE_FFTW3_H */

/* Define to 1 if you have the <fftw.h> header file. */
/* #undef HAVE_FFTW_H */

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define 1 if the isfinite macro is defined in cmath, 0 otherwise. */
#define HAVE_ISFINITE 1

/* Define 1 if M_PI defined in cmath, 0 otherwise. */
#define HAVE_M_PI 1

/* Define to 1 if you have the <Python.h> header file. */
/* #undef HAVE_PYTHON_H */

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define to 1 if you have the <stdio.h> header file. */
#define HAVE_STDIO_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Define to the sub-directory where libtool stores uninstalled libraries. */
#define LT_OBJDIR ".libs/"

/* Define for compilers that do not support template member functions. */
/* #undef NO_TEMPLATE_MEMBERS */

/* Name of package */
#define PACKAGE "loris"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "loris@cerlsoundgroup.org"

/* Define to the full name of this package. */
#define PACKAGE_NAME "Loris"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "Loris 1.9"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "loris"

/* Define to the home page for this package. */
#define PACKAGE_URL ""

/* Define to the version of this package. */
#define PACKAGE_VERSION "1.9"

/* The size of 'bool', as computed by sizeof. */
#define SIZEOF_BOOL 1

/* The size of 'char', as computed by sizeof. */
#define SIZEOF_CHAR 1

/* The size of 'double', as computed by sizeof. */
#define SIZEOF_DOUBLE 8

/* The size of 'float', as computed by sizeof. */
#define SIZEOF_FLOAT 4

/* The size of 'int', as computed by sizeof. */
#define SIZEOF_INT 4

/* The size of 'int *', as computed by sizeof. */
#define SIZEOF_INT_P 8

/* The size of 'long', as computed by sizeof. */
#define SIZEOF_LONG 8

/* The size of 'short', as computed by sizeof. */
#define SIZEOF_SHORT 2

/* The size of 'size_t', as computed by sizeof. */
#define SIZEOF_SIZE_T 8

/* Define to 1 if all of the C89 standard headers exist (not just the ones
   required in a freestanding environment). This macro is provided for
   backward compatibility; new code need not use it. */
#define STDC_HEADERS 1

/* Version number of package */
#define VERSION "1.9"

/* Define WORDS_BIGENDIAN to 1 if your processor stores words with the most
   significant byte first (like Motorola and SPARC, unlike Intel). */
#if defined AC_APPLE_UNIVERSAL_BUILD
# if defined __BIG_ENDIAN__
#  define WORDS_BIGENDIAN 1
# endif
#else
# ifndef WORDS_BIGENDIAN
/* #  undef WORDS_BIGENDIAN */
# endif
#endif

/* Define to 1 if type 'char' is unsigned and your compiler does not
   predefine this macro.  */
#ifndef __CHAR_UNSIGNED__
/* # undef __CHAR_UNSIGNED__ */
#endif
