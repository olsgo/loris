# Makefile.in generated by automake 1.17 from Makefile.am.
# doc/Makefile.  Generated from Makefile.in by configure.

# Copyright (C) 1994-2024 Free Software Foundation, Inc.

# This Makefile.in is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.



# Loris is Copyright (c) 1999-2016 by Kelly Fitz and Lippold Haken
# <loris@cerlsoundgroup.org>
#  
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without 
# modifications, as long as this notice is preserved.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


am__is_gnu_make = { \
  if test -z '$(MAKELEVEL)'; then \
    false; \
  elif test -n '$(MAKE_HOST)'; then \
    true; \
  elif test -n '$(MAKE_VERSION)' && test -n '$(CURDIR)'; then \
    true; \
  else \
    false; \
  fi; \
}
am__make_running_with_option = \
  case $${target_option-} in \
      ?) ;; \
      *) echo "am__make_running_with_option: internal error: invalid" \
              "target option '$${target_option-}' specified" >&2; \
         exit 1;; \
  esac; \
  has_opt=no; \
  sane_makeflags=$$MAKEFLAGS; \
  if $(am__is_gnu_make); then \
    sane_makeflags=$$MFLAGS; \
  else \
    case $$MAKEFLAGS in \
      *\\[\ \	]*) \
        bs=\\; \
        sane_makeflags=`printf '%s\n' "$$MAKEFLAGS" \
          | sed "s/$$bs$$bs[$$bs $$bs	]*//g"`;; \
    esac; \
  fi; \
  skip_next=no; \
  strip_trailopt () \
  { \
    flg=`printf '%s\n' "$$flg" | sed "s/$$1.*$$//"`; \
  }; \
  for flg in $$sane_makeflags; do \
    test $$skip_next = yes && { skip_next=no; continue; }; \
    case $$flg in \
      *=*|--*) continue;; \
        -*I) strip_trailopt 'I'; skip_next=yes;; \
      -*I?*) strip_trailopt 'I';; \
        -*O) strip_trailopt 'O'; skip_next=yes;; \
      -*O?*) strip_trailopt 'O';; \
        -*l) strip_trailopt 'l'; skip_next=yes;; \
      -*l?*) strip_trailopt 'l';; \
      -[dEDm]) skip_next=yes;; \
      -[JT]) skip_next=yes;; \
    esac; \
    case $$flg in \
      *$$target_option*) has_opt=yes; break;; \
    esac; \
  done; \
  test $$has_opt = yes
am__make_dryrun = (target_option=n; $(am__make_running_with_option))
am__make_keepgoing = (target_option=k; $(am__make_running_with_option))
am__rm_f = rm -f $(am__rm_f_notfound)
am__rm_rf = rm -rf $(am__rm_f_notfound)
pkgdatadir = $(datadir)/loris
pkgincludedir = $(includedir)/loris
pkglibdir = $(libdir)/loris
pkglibexecdir = $(libexecdir)/loris
am__cd = CDPATH="$${ZSH_VERSION+.}$(PATH_SEPARATOR)" && cd
install_sh_DATA = $(install_sh) -c -m 644
install_sh_PROGRAM = $(install_sh) -c
install_sh_SCRIPT = $(install_sh) -c
INSTALL_HEADER = $(INSTALL_DATA)
transform = $(program_transform_name)
NORMAL_INSTALL = :
PRE_INSTALL = :
POST_INSTALL = :
NORMAL_UNINSTALL = :
PRE_UNINSTALL = :
POST_UNINSTALL = :
build_triplet = aarch64-apple-darwin24.1.0
host_triplet = aarch64-apple-darwin24.1.0

# add something to build docs using doxygen, if it is present
#am__append_1 = html 
subdir = doc
ACLOCAL_M4 = $(top_srcdir)/aclocal.m4
am__aclocal_m4_deps = $(top_srcdir)/m4/ax_cxx_compile_stdcxx_11.m4 \
	$(top_srcdir)/m4/libtool.m4 $(top_srcdir)/m4/ltoptions.m4 \
	$(top_srcdir)/m4/ltsugar.m4 $(top_srcdir)/m4/ltversion.m4 \
	$(top_srcdir)/m4/lt~obsolete.m4 $(top_srcdir)/configure.ac
am__configure_deps = $(am__aclocal_m4_deps) $(CONFIGURE_DEPENDENCIES) \
	$(ACLOCAL_M4)
DIST_COMMON = $(srcdir)/Makefile.am $(am__DIST_COMMON)
mkinstalldirs = $(install_sh) -d
CONFIG_HEADER = $(top_builddir)/config.h
CONFIG_CLEAN_FILES = Doxyfile
CONFIG_CLEAN_VPATH_FILES =
AM_V_P = $(am__v_P_$(V))
am__v_P_ = $(am__v_P_$(AM_DEFAULT_VERBOSITY))
am__v_P_0 = false
am__v_P_1 = :
AM_V_GEN = $(am__v_GEN_$(V))
am__v_GEN_ = $(am__v_GEN_$(AM_DEFAULT_VERBOSITY))
am__v_GEN_0 = @echo "  GEN     " $@;
am__v_GEN_1 = 
AM_V_at = $(am__v_at_$(V))
am__v_at_ = $(am__v_at_$(AM_DEFAULT_VERBOSITY))
am__v_at_0 = @
am__v_at_1 = 
SOURCES =
DIST_SOURCES =
am__can_run_installinfo = \
  case $$AM_UPDATE_INFO_DIR in \
    n|no|NO) false;; \
    *) (install-info --version) >/dev/null 2>&1;; \
  esac
DATA = $(noinst_DATA)
am__tagged_files = $(HEADERS) $(SOURCES) $(TAGS_FILES) $(LISP)
am__DIST_COMMON = $(srcdir)/Doxyfile.in $(srcdir)/Makefile.in README
DISTFILES = $(DIST_COMMON) $(DIST_SOURCES) $(TEXINFOS) $(EXTRA_DIST)
ACLOCAL = ${SHELL} '/Users/gjb/Projects/loris/config/missing' aclocal-1.17
AMTAR = $${TAR-tar}
AM_DEFAULT_VERBOSITY = 1
AR = ar
AUTOCONF = ${SHELL} '/Users/gjb/Projects/loris/config/missing' autoconf
AUTOHEADER = ${SHELL} '/Users/gjb/Projects/loris/config/missing' autoheader
AUTOMAKE = ${SHELL} '/Users/gjb/Projects/loris/config/missing' automake-1.17
AWK = awk
CC = /opt/homebrew/opt/llvm/bin/clang
CCDEPMODE = depmode=gcc3
CFLAGS = -g -O2
CPPFLAGS = -I/opt/homebrew/opt/llvm/include
CSCOPE = cscope
CSOUND = 
CTAGS = ctags
CXX = /opt/homebrew/opt/llvm/bin/clang++
CXXCPP = /opt/homebrew/opt/llvm/bin/clang++ -E
CXXDEPMODE = depmode=gcc3
CXXFLAGS = -I/opt/homebrew/opt/llvm/include/c++/v1
CYGPATH_W = echo
DEFS = -DHAVE_CONFIG_H
DEPDIR = .deps
DLLTOOL = false
DOXYGEN = 
DSYMUTIL = dsymutil
DUMPBIN = 
ECHO_C = \c
ECHO_N = 
ECHO_T = 
EGREP = /usr/bin/grep -E
ETAGS = etags
EXEEXT = 
FGREP = /usr/bin/grep -F
FILECMD = file
GREP = /usr/bin/grep
HAVE_CXX11 = 
INSTALL = /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_PROGRAM = ${INSTALL}
INSTALL_SCRIPT = ${INSTALL}
INSTALL_STRIP_PROGRAM = $(install_sh) -c -s
LD = /usr/bin/ld
LDFLAGS = -L/opt/homebrew/opt/llvm/lib
LIBOBJS = 
LIBS = 
LIBTOOL = $(SHELL) $(top_builddir)/libtool
LIBTOOL_DEPS = ./config//ltmain.sh
LINK_FFTW = 
LIPO = lipo
LN_S = ln -s
LORIS_MAJOR_VERSION = 1
LORIS_MINOR_VERSION = 9
LORIS_SUBMINOR_VERSION = 
LORIS_VERSION_STR = Loris 1.9development
LTLIBOBJS = 
LT_SYS_LIBRARY_PATH = 
MAKEINFO = ${SHELL} '/Users/gjb/Projects/loris/config/missing' makeinfo
MANIFEST_TOOL = :
MKDIR_P = mkdir -p
NM = /usr/bin/nm -B
NMEDIT = nmedit
OBJDUMP = objdump
OBJEXT = o
OTOOL = otool
OTOOL64 = :
PACKAGE = loris
PACKAGE_BUGREPORT = loris@cerlsoundgroup.org
PACKAGE_NAME = Loris
PACKAGE_STRING = Loris 1.9
PACKAGE_TARNAME = loris
PACKAGE_URL = 
PACKAGE_VERSION = 1.9
PATH_SEPARATOR = :
PYFLAGS = 
PYINCLUDE = 
PYTHON = 
PYTHON_EXEC_PREFIX = 
PYTHON_PLATFORM = 
PYTHON_PREFIX = 
PYTHON_VERSION = 
RANLIB = ranlib
SED = /usr/bin/sed
SET_MAKE = 
SHELL = /bin/sh
STRIP = strip
SWIG = /opt/homebrew/bin/swig
VERSION = 1.9
abs_builddir = /Users/gjb/Projects/loris/doc
abs_srcdir = /Users/gjb/Projects/loris/doc
abs_top_builddir = /Users/gjb/Projects/loris
abs_top_srcdir = /Users/gjb/Projects/loris
ac_aux_dir = ./config/
ac_ct_AR = ar
ac_ct_CC = /opt/homebrew/opt/llvm/bin/clang
ac_ct_CXX = 
ac_ct_DUMPBIN = 
am__include = include
am__leading_dot = .
am__quote = 
am__rm_f_notfound = 
am__tar = $${TAR-tar} chof - "$$tardir"
am__untar = $${TAR-tar} xf -
am__xargs_n = xargs -n
bindir = ${exec_prefix}/bin
build = aarch64-apple-darwin24.1.0
build_alias = 
build_cpu = aarch64
build_os = darwin24.1.0
build_vendor = apple
builddir = .
datadir = ${datarootdir}
datarootdir = ${prefix}/share
docdir = ${datarootdir}/doc/${PACKAGE_TARNAME}
dvidir = ${docdir}
exec_prefix = ${prefix}
host = aarch64-apple-darwin24.1.0
host_alias = 
host_cpu = aarch64
host_os = darwin24.1.0
host_vendor = apple
htmldir = ${docdir}
includedir = ${prefix}/include
infodir = ${datarootdir}/info
install_sh = ${SHELL} /Users/gjb/Projects/loris/config/install-sh
libdir = ${exec_prefix}/lib
libexecdir = ${exec_prefix}/libexec
localedir = ${datarootdir}/locale
localstatedir = ${prefix}/var
mandir = ${datarootdir}/man
mkdir_p = $(MKDIR_P)
oldincludedir = /usr/include
pdfdir = ${docdir}
pkgpyexecdir = 
pkgpythondir = 
prefix = /usr/local
program_transform_name = s,x,x,
psdir = ${docdir}
pyexecdir = 
pythondir = 
runstatedir = ${localstatedir}/run
sbindir = ${exec_prefix}/sbin
sharedstatedir = ${prefix}/com
srcdir = .
sysconfdir = ${prefix}/etc
target_alias = 
top_build_prefix = ../
top_builddir = ..
top_srcdir = ..
EXTRA_DIST = Doxyfile.in opcodes.html utils.html
noinst_DATA = $(am__append_1)
INPUT = ../src/AiffFile.h		\
			../src/Analyzer.h		\
			../src/Breakpoint.h	\
			../src/BreakpointUtils.h	\
			../src/Channelizer.h	\
			../src/Collator.h	\
			../src/Dilator.h	\
			../src/Distiller.h	\
			../src/Envelope.h	\
			../src/Exception.h	\
			../src/Filter.h	\
			../src/FourierTransform.h	\
			../src/FrequencyReference.h \
			../src/Fundamental.h	\
			../src/Harmonifier.h	\
			../src/ImportLemur.h	\
			../src/KaiserWindow.h	\
			../src/LinearEnvelope.h	\
			../src/Marker.h	\
			../src/Morpher.h	\
			../src/NoiseGenerator.h \
			../src/Notifier.h	\
			../src/Oscillator.h	\
			../src/Partial.h	\
			../src/PartialList.h	\
			../src/PartialPtrs.h	\
			../src/PartialUtils.h	\
			../src/ReassignedSpectrum.h	\
			../src/Resampler.h \
			../src/SdifFile.h	\
			../src/Sieve.h	\
			../src/SpcFile.h	\
			../src/SpectralSurface.h	\
			../src/Synthesizer.h

#CPP_HTML_DIR = html
#HTML = ${CPP_HTML_DIR}/index.html
#PDF = Loris${LORIS_MAJOR_VERSION}.${LORIS_MINOR_VERSION}.pdf
MAINTAINERCLEANFILES = Makefile.in 
DISTCLEANFILES = latex/* html/* Doxyfile
all: all-am

.SUFFIXES:
$(srcdir)/Makefile.in:  $(srcdir)/Makefile.am  $(am__configure_deps)
	@for dep in $?; do \
	  case '$(am__configure_deps)' in \
	    *$$dep*) \
	      ( cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh ) \
	        && { if test -f $@; then exit 0; else break; fi; }; \
	      exit 1;; \
	  esac; \
	done; \
	echo ' cd $(top_srcdir) && $(AUTOMAKE) --gnu doc/Makefile'; \
	$(am__cd) $(top_srcdir) && \
	  $(AUTOMAKE) --gnu doc/Makefile
Makefile: $(srcdir)/Makefile.in $(top_builddir)/config.status
	@case '$?' in \
	  *config.status*) \
	    cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh;; \
	  *) \
	    echo ' cd $(top_builddir) && $(SHELL) ./config.status $(subdir)/$@ $(am__maybe_remake_depfiles)'; \
	    cd $(top_builddir) && $(SHELL) ./config.status $(subdir)/$@ $(am__maybe_remake_depfiles);; \
	esac;

$(top_builddir)/config.status: $(top_srcdir)/configure $(CONFIG_STATUS_DEPENDENCIES)
	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh

$(top_srcdir)/configure:  $(am__configure_deps)
	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
$(ACLOCAL_M4):  $(am__aclocal_m4_deps)
	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
$(am__aclocal_m4_deps):
Doxyfile: $(top_builddir)/config.status $(srcdir)/Doxyfile.in
	cd $(top_builddir) && $(SHELL) ./config.status $(subdir)/$@

mostlyclean-libtool:
	-rm -f *.lo

clean-libtool:
	-rm -rf .libs _libs
tags TAGS:

ctags CTAGS:

cscope cscopelist:

distdir: $(BUILT_SOURCES)
	$(MAKE) $(AM_MAKEFLAGS) distdir-am

distdir-am: $(DISTFILES)
	@srcdirstrip=`echo "$(srcdir)" | sed 's/[].[^$$\\*]/\\\\&/g'`; \
	topsrcdirstrip=`echo "$(top_srcdir)" | sed 's/[].[^$$\\*]/\\\\&/g'`; \
	list='$(DISTFILES)'; \
	  dist_files=`for file in $$list; do echo $$file; done | \
	  sed -e "s|^$$srcdirstrip/||;t" \
	      -e "s|^$$topsrcdirstrip/|$(top_builddir)/|;t"`; \
	case $$dist_files in \
	  */*) $(MKDIR_P) `echo "$$dist_files" | \
			   sed '/\//!d;s|^|$(distdir)/|;s,/[^/]*$$,,' | \
			   sort -u` ;; \
	esac; \
	for file in $$dist_files; do \
	  if test -f $$file || test -d $$file; then d=.; else d=$(srcdir); fi; \
	  if test -d $$d/$$file; then \
	    dir=`echo "/$$file" | sed -e 's,/[^/]*$$,,'`; \
	    if test -d "$(distdir)/$$file"; then \
	      find "$(distdir)/$$file" -type d ! -perm -700 -exec chmod u+rwx {} \;; \
	    fi; \
	    if test -d $(srcdir)/$$file && test $$d != $(srcdir); then \
	      cp -fpR $(srcdir)/$$file "$(distdir)$$dir" || exit 1; \
	      find "$(distdir)/$$file" -type d ! -perm -700 -exec chmod u+rwx {} \;; \
	    fi; \
	    cp -fpR $$d/$$file "$(distdir)$$dir" || exit 1; \
	  else \
	    test -f "$(distdir)/$$file" \
	    || cp -p $$d/$$file "$(distdir)/$$file" \
	    || exit 1; \
	  fi; \
	done
check-am: all-am
check: check-am
all-am: Makefile $(DATA)
installdirs:
install: install-am
install-exec: install-exec-am
install-data: install-data-am
uninstall: uninstall-am

install-am: all-am
	@$(MAKE) $(AM_MAKEFLAGS) install-exec-am install-data-am

installcheck: installcheck-am
install-strip:
	if test -z '$(STRIP)'; then \
	  $(MAKE) $(AM_MAKEFLAGS) INSTALL_PROGRAM="$(INSTALL_STRIP_PROGRAM)" \
	    install_sh_PROGRAM="$(INSTALL_STRIP_PROGRAM)" INSTALL_STRIP_FLAG=-s \
	      install; \
	else \
	  $(MAKE) $(AM_MAKEFLAGS) INSTALL_PROGRAM="$(INSTALL_STRIP_PROGRAM)" \
	    install_sh_PROGRAM="$(INSTALL_STRIP_PROGRAM)" INSTALL_STRIP_FLAG=-s \
	    "INSTALL_PROGRAM_ENV=STRIPPROG='$(STRIP)'" install; \
	fi
mostlyclean-generic:

clean-generic:

distclean-generic:
	-$(am__rm_f) $(CONFIG_CLEAN_FILES)
	-test . = "$(srcdir)" || $(am__rm_f) $(CONFIG_CLEAN_VPATH_FILES)
	-$(am__rm_f) $(DISTCLEANFILES)

maintainer-clean-generic:
	@echo "This command is intended for maintainers to use"
	@echo "it deletes files that may require special tools to rebuild."
	-$(am__rm_f) $(MAINTAINERCLEANFILES)
clean: clean-am

clean-am: clean-generic clean-libtool mostlyclean-am

distclean: distclean-am
	-rm -f Makefile
distclean-am: clean-am distclean-generic

dvi: dvi-am

dvi-am:

html: html-am

html-am:

info: info-am

info-am:

install-data-am:

install-dvi: install-dvi-am

install-dvi-am:

install-exec-am:

install-html: install-html-am

install-html-am:

install-info: install-info-am

install-info-am:

install-man:

install-pdf: install-pdf-am

install-pdf-am:

install-ps: install-ps-am

install-ps-am:

installcheck-am:

maintainer-clean: maintainer-clean-am
	-rm -f Makefile
maintainer-clean-am: distclean-am maintainer-clean-generic

mostlyclean: mostlyclean-am

mostlyclean-am: mostlyclean-generic mostlyclean-libtool

pdf: pdf-am

pdf-am:

ps: ps-am

ps-am:

uninstall-am:

.MAKE: install-am install-strip

.PHONY: all all-am check check-am clean clean-generic clean-libtool \
	cscopelist-am ctags-am distclean distclean-generic \
	distclean-libtool distdir dvi dvi-am html html-am info info-am \
	install install-am install-data install-data-am install-dvi \
	install-dvi-am install-exec install-exec-am install-html \
	install-html-am install-info install-info-am install-man \
	install-pdf install-pdf-am install-ps install-ps-am \
	install-strip installcheck installcheck-am installdirs \
	maintainer-clean maintainer-clean-generic mostlyclean \
	mostlyclean-generic mostlyclean-libtool pdf pdf-am ps ps-am \
	tags-am uninstall uninstall-am

.PRECIOUS: Makefile


#${HTML}: Doxyfile ${INPUT}
#	${DOXYGEN} 

#html: ${HTML}

#${PDF}: ${HTML}
#	cd latex; make 
#	cp latex/refman.pdf $@

#pdf: ${PDF}

# Tell versions [3.59,3.63) of GNU make to not export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:

# Tell GNU make to disable its built-in pattern rules.
%:: %,v
%:: RCS/%,v
%:: RCS/%
%:: s.%
%:: SCCS/s.%
