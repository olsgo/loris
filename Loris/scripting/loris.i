/*
 * This is the Loris C++ Class Library, implementing analysis, 
 * manipulation, and synthesis of digitized sounds using the Reassigned 
 * Bandwidth-Enhanced Additive Sound Model.
 *
 * Loris is Copyright (c) 1999-2004 by Kelly Fitz and Lippold Haken
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY, without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *
 *	loris.i
 *
 *  SWIG interface file for building scripting language modules
 *  implementing Loris functionality. This interface has been 
 *  completely rewritten (23 Jan 2003) to support new versions
 *  of SWIG (current is 1.3.17) and take advantage of new features
 *  and bug fixes. This interface wraps many functions in the 
 *  Loris procedural interface, but also provides some Loris C++
 *  class wrappers, to provide enhanced functionality in the 
 *  context of laguages that perform garbage collection.
 *
 *	Also, several interface (.i) files were collapsed into one
 *	(not sure I did myself any favors).
 *
 * Kelly Fitz, 8 Nov 2000
 * rewrite: Kelly Fitz, 23 Jan 2003
 * loris@cerlsoundgroup.org
 *
 * http://www.cerlsoundgroup.org/Loris/
 *
 */

%include exception.i 
%include "std_vector.i"
%include "std_list.i"

// ----------------------------------------------------------------
//		docstring for the Loris module (Python)
//
%define DOCSTRING
"
Loris is an Open Source sound modeling and processing software package
based on the Reassigned Bandwidth-Enhanced Additive Sound Model. Loris
supports modified resynthesis and manipulations of the model data,
such as time- and frequency-scale modification and sound morphing.


Loris is developed by Kelly Fitz and Lippold Haken at the CERL Sound
Group, and is distributed under the GNU General Public License (GPL).
For more information, please visit

   http://www.cerlsoundgroup.org/Loris/
"
%enddef

%module(docstring=DOCSTRING) loris

// enable automatic docstring generation in Python module
%feature("autodoc","0");

// ----------------------------------------------------------------
//		include Loris headers needed to generate wrappers
//
%{
	#include <loris.h>
	
	#include <AiffFile.h>
	#include <Analyzer.h>
	#include <BreakpointEnvelope.h>
	#include <Exception.h>
	#include <LinearEnvelope.h>
	#include <Marker.h>
	#include <Partial.h>
	#include <SdifFile.h>
	#include <SpcFile.h>
	#include <Synthesizer.h>

	//	import the entire Loris namespace
	using namespace Loris;
	
	#include <stdexcept>
	#include <vector>
%}

// ----------------------------------------------------------------
//		Use the SWIG library to wrap std::vectors.
//
namespace std {
   %template(DoubleVector) vector< double >;
   %template(MarkerVector) vector< Marker >;
};

// ----------------------------------------------------------------
//		notification and exception handlers
//
//	Exception handling code for procedural interface calls.
//	Copied from the SWIG manual. Tastes great, less filling.

%{ 
	static char error_message[256];
	static int error_status = 0;
	
	void throw_exception( const char *msg ) 
	{
		strncpy(error_message,msg,256);
		error_status = 1;
	}
	
	void clear_exception( void ) 
	{
		error_status = 0;
	}
	
	char *check_exception( void ) 
	{
		if ( error_status ) 
		{
			return error_message;
		}
		else 
		{
			return NULL;
		}
	}
%}

// Procedural interface functions all use the exception
// and notification mechanism defined above.
//
%exception 
{
    char * err;
    clear_exception();
    $action
    if ( 0 != (err = check_exception()) )
    {
        SWIG_exception( SWIG_ValueError, err );
    }
}

//	Configure notification and debugging using a
//	in a SWIG initialization block. This code is
//	executed when the module is loaded by the 
//	host interpreter.
//
%{
	//	notification function for Loris debugging
	//	and notifications, installed in initialization
	//	block below:
	static void printf_notifier( const char * s )
	{
		printf("*\t%s\n", s);
	}	
%}

%init 
%{
	setNotifier( printf_notifier );
	setExceptionHandler( throw_exception );
%}

// ----------------------------------------------------------------
//		wrap procedural interface
//
//	Not all functions in the procedural interface are trivially
//	wrapped, some are wrapped to return newly-allocated objects,
//	which we wouldn't do in the procedural interface, but we
//	can do, because SWIG and the scripting langauges take care of 
//	the memory management ambiguities.
//

%feature("docstring", 
"Label Partials in a PartialList with the integer nearest to the
amplitude-weighted average ratio of their frequency envelope to a
reference frequency envelope. The frequency spectrum is
partitioned into non-overlapping channels whose time-varying
center frequencies track the reference frequency envelope. The
reference label indicates which channel's center frequency is
exactly equal to the reference envelope frequency, and other
channels' center frequencies are multiples of the reference
envelope frequency divided by the reference label. Each Partial in
the PartialList is labeled with the number of the channel that
best fits its frequency envelope. The quality of the fit is
evaluated at the breakpoints in the Partial envelope and weighted
by the amplitude at each breakpoint, so that high- amplitude
breakpoints contribute more to the channel decision. Partials are
labeled, but otherwise unmodified. In particular, their
frequencies are not modified in any way.");
void channelize( PartialList * partials, 
                 LinearEnvelope * refFreqEnvelope, int refLabel );

%feature("docstring",
"Collate unlabeled (zero-labeled) Partials into the smallest-possible 
number of Partials that does not combine any overlapping Partials.
Collated Partials assigned labels higher than any label in the original 
list, and appear at the end of the sequence, after all previously-labeled
Partials.") collate_duh;
%rename( collate ) collate_duh;

%inline 
%{
    // there seems to be a collision with a symbol name
    // in localefwd.h (GNU) that is somehow getting
    // imported
    void collate_duh( PartialList * partials )
    {
        // make sure to find the collate that
        // is not in std.
        ::collate( partials );
    }
%}

%feature("docstring",
"Return a newly-constructed LinearEnvelope by sampling the
frequency envelope of the longest Partial in a PartialList. Only
Partials whose frequency at the Partial's loudest (highest
amplitude) breakpoint is within the given frequency range are
considered.

If the number of sample points is not specified, then the longest
Partial's frequency envelope is sampled every 30 ms (No fewer than
10 samples are used, so the sampling maybe more dense for very
short Partials.)

For very simple sounds, this frequency reference may be a good
first approximation to a reference envelope for channelization
(see channelize).");

%newobject createFreqReference;
LinearEnvelope * 
createFreqReference( PartialList * partials, 
					 double minFreq, double maxFreq, long numSamps );
%inline 
%{
	LinearEnvelope * 
	createFreqReference( PartialList * partials, 
						 double minFreq, double maxFreq )
	{
		createFreqReference( partials, minFreq, maxFreq, 0 );
	}
%}


%feature("docstring", 
"Dilate Partials in a PartialList according to the given initial
and target time points. Partial envelopes are stretched and
compressed so that temporal features at the initial time points
are aligned with the final time points. Time points are sorted, so
Partial envelopes are are only stretched and compressed, but
breakpoints are not reordered. Duplicate time points are allowed.
There must be the same number of initial and target time points.");


//	dilate needs a contract to guarantee that the
//	same number of initial and target points are
//	provided.
%contract dilate( PartialList * partials, 
                  const std::vector< double > & ivec, 
                  const std::vector< double > & tvec ) 
{
require:
	ivec->size() == tvec->size();
}

%inline
%{
	void dilate( PartialList * partials, 
		   	     const std::vector< double > & ivec, 
				 const std::vector< double > & tvec )
	{
		const double * initial = &( ivec.front() );
		const double * target = &( tvec.front() );
		int npts = ivec.size();
		dilate( partials, initial, target, npts );
	}
%}

%feature("docstring",
"Distill labeled (channelized) Partials in a PartialList into a 
PartialList containing at most one Partial per label. Unlabeled 
(zero-labeled) Partials are left unmodified at the end of the 
distilled Partials.") distill;
void distill( PartialList * partials );


%feature("docstring",
"Export audio samples stored in a vector to an AIFF file having the
specified number of channels and sample rate at the given file
path (or name). The floating point samples in the vector are
clamped to the range (-1.,1.) and converted to integers having
bitsPerSamp bits. The default values for the sample rate and
sample size, if unspecified, are 44100 Hz (CD quality) and 16 bits
per sample, respectively.");

%inline 
%{
	void exportAiff( const char * path, const std::vector< double > & samples,
					 double samplerate = 44100.0, int bitsPerSamp = 16 )
	{
		exportAiff( path, &(samples.front()), samples.size(), 
					samplerate, bitsPerSamp );
	}
%}

%feature("docstring",
"Export Partials in a PartialList to a SDIF file at the specified
file path (or name). SDIF data is written in the Loris RBEP
format. For more information about SDIF, see the SDIF website at:
	www.ircam.fr/equipes/analyse-synthese/sdif/  ");

void exportSdif( const char * path, PartialList * partials );



%feature("docstring",
"Export Partials in a PartialList to a Spc file at the specified
file path (or name). The fractional MIDI pitch must be specified.
The optional enhanced parameter defaults to true (for
bandwidth-enhanced spc files), but an be specified false for
pure-sines spc files. The optional endApproachTime parameter is in
seconds; its default value is zero (and has no effect). A nonzero
endApproachTime indicates that the PartialList does not include a
release, but rather ends in a static spectrum corresponding to the
final breakpoint values of the partials. The endApproachTime
specifies how long before the end of the sound the amplitude,
frequency, and bandwidth values are to be modified to make a
gradual transition to the static spectrum.");

void exportSpc( const char * path, PartialList * partials, double midiPitch, 
				int enhanced, double endApproachTime );
%inline %{
void exportSpc( const char * path, PartialList * partials, double midiPitch,
			    int enhanced )
{
	exportSpc( path, partials, midiPitch, enhanced, 0. );
}
%}
%inline %{
void exportSpc( const char * path, PartialList * partials, double midiPitch )
{
	exportSpc( path, partials, midiPitch, true, 0. );
}
%}


%feature("docstring",
"Import Partials from an SDIF file at the given file path (or
name), and return them in a PartialList. Loris can import
SDIF data stored in 1TRC format or in the Loris RBEP format.
For more information about SDIF, see the SDIF website at:
	www.ircam.fr/equipes/analyse-synthese/sdif/");
	
%newobject importSdif;
%inline %{
	PartialList * importSdif( const char * path )
	{
		PartialList * dst = createPartialList();
		importSdif( path, dst );

		// check for exception:
		if (check_exception())
		{
			destroyPartialList( dst );
			dst = NULL;
		}
		return dst;
	}
%}


%feature("docstring",
"Import Partials from an Spc file at the given file path (or
name), and return them in a PartialList.");

%newobject importSpc;
%inline %{
	PartialList * importSpc( const char * path )
	{
		PartialList * dst = createPartialList();
		importSpc( path, dst );

		// check for exception:
		if (check_exception())
		{
			destroyPartialList( dst );
			dst = NULL;
		}
		return dst;
	}
%}

%feature("docstring",
"Morph labeled Partials in two PartialLists according to the
given frequency, amplitude, and bandwidth (noisiness) morphing
envelopes, and return the morphed Partials in a PartialList.
Loris morphs Partials by interpolating frequency, amplitude,
and bandwidth envelopes of corresponding Partials in the
source PartialLists. For more information about the Loris
morphing algorithm, see the Loris website:
	www.cerlsoundgroup.org/Loris/");

%newobject morph;
%inline %{
	PartialList * morph( const PartialList * src0, const PartialList * src1, 
                        const LinearEnvelope * ffreq, 
                        const LinearEnvelope * famp, 
                        const LinearEnvelope * fbw )
	{
		PartialList * dst = createPartialList();
		morph( src0, src1, ffreq, famp, fbw, dst );
		
		// check for exception:
		if ( check_exception() )
		{
			destroyPartialList( dst );
			dst = NULL;
		}
		return dst;
	}
	
	PartialList * morph( const PartialList * src0, const PartialList * src1, 
                        double freqweight, 
                        double ampweight, 
                        double bwweight )
	{
		LinearEnvelope ffreq( freqweight ), famp( ampweight ), fbw( bwweight );
		
		PartialList * dst = createPartialList();
		morph( src0, src1, &ffreq, &famp, &fbw, dst );
		
		// check for exception:
		if ( check_exception() )
		{
			destroyPartialList( dst );
			dst = NULL;
		}
		return dst;
	}
%}

%feature("docstring",
"Synthesize Partials in a PartialList at the given sample rate, and
return the (floating point) samples in a vector. The vector is
sized to hold as many samples as are needed for the complete
synthesis of all the Partials in the PartialList. If the sample
rate is unspecified, the deault value of 44100 Hz (CD quality) is
used.");

%newobject synthesize;
%inline %{
	std::vector<double> synthesize( const PartialList * partials, double srate = 44100.0 )
	{
		std::vector<double> dst;
		Synthesizer synth( srate, dst );
		synth.synthesize( partials->begin(), partials->end() );
		return dst;
	}
%}

%feature("docstring",
"Trim Partials by removing Breakpoints outside a specified time span.
Insert a Breakpoint at the boundary when cropping occurs.
");
void crop( PartialList * partials, double t1, double t2 );

%feature("docstring",
"Copy Partials in the source PartialList having the specified label
into a new PartialList. The source PartialList is unmodified.
");

%newobject copyLabeled;
%inline %{
	PartialList * copyLabeled( PartialList * partials, long label )
	{
		PartialList * dst = createPartialList();
		copyLabeled( partials, label, dst );
		
		// check for exception:
		if ( check_exception() )
		{
			destroyPartialList( dst );
			dst = NULL;
		}
		return dst;
	}
%}

%feature("docstring",
"Extract Partials in the source PartialList having the specified
label and return them in a new PartialList.");

%newobject extractLabeled;
%inline %{
	PartialList * extractLabeled( PartialList * partials, long label )
	{
		PartialList * dst = createPartialList();
		extractLabeled( partials, label, dst );
		
		// check for exception:
		if ( check_exception() )
		{
			destroyPartialList( dst );
			dst = NULL;
		}
		return dst;
	}
%}

%feature("docstring",
"Remove from a PartialList all Partials having the specified label.");
void removeLabeled( PartialList * partials, long label );

%feature("docstring",
"Resample all Partials in a PartialList using the specified
sampling interval, so that the Breakpoints in the Partial
envelopes will all lie on a common temporal grid. The Breakpoint
times in resampled Partials will comprise a contiguous sequence of
integer multiples of the sampling interval, beginning with the
multiple nearest to the Partial's start time and ending with the
multiple nearest to the Partial's end time. Resampling is
performed in-place.");

void resample( PartialList * partials, double interval );

 
%feature("docstring",
"Scale the amplitude of the Partials in a PartialList according 
to an envelope representing a time-varying amplitude scale value.");

void scaleAmp( PartialList * partials, LinearEnvelope * ampEnv );
				 
%feature("docstring",
"Scale the bandwidth of the Partials in a PartialList according 
to an envelope representing a time-varying bandwidth scale value.");

void scaleBandwidth( PartialList * partials, LinearEnvelope * bwEnv );
				 
%feature("docstring",
"Scale the frequency of the Partials in a PartialList according 
to an envelope representing a time-varying frequency scale value.");

void scaleFrequency( PartialList * partials, LinearEnvelope * freqEnv );
				 
%feature("docstring",
"Scale the relative noise content of the Partials in a PartialList 
according to an envelope representing a (time-varying) noise energy 
scale value.");

void scaleNoiseRatio( PartialList * partials, LinearEnvelope * noiseEnv );

%feature("docstring",
"Shift the pitch of all Partials in a PartialList according to 
the given pitch envelope. The pitch envelope is assumed to have 
units of cents (1/100 of a halfstep).");

void shiftPitch( PartialList * partials, LinearEnvelope * pitchEnv );

%inline %{	
	void scaleAmp( PartialList * partials, double val )
	{
		LinearEnvelope e( val );
		scaleAmp( partials, &e );
	}
	
	
	void scaleBandwidth( PartialList * partials, double val )
	{
		LinearEnvelope e( val );
		scaleBandwidth( partials, &e );
	}
	
	
	void scaleFrequency( PartialList * partials, double val )
	{
		LinearEnvelope e( val );
		scaleFrequency( partials, &e );
	}
	
	
	void scaleNoiseRatio( PartialList * partials, double val )
	{
		LinearEnvelope e( val );
		scaleNoiseRatio( partials, &e );
	}
	
	
	void shiftPitch( PartialList * partials, double val )
	{
		LinearEnvelope e( val );
		shiftPitch( partials, &e );
	}
%}	
	


%feature("docstring",
"Shift the time of all the Breakpoints in a Partial by a constant
amount (in seconds).");

void shiftTime( PartialList * partials, double offset );

%feature("docstring",
"Eliminate overlapping Partials having the same label
(except zero). If any two partials with same label
overlap in time, keep only the longer of the two.
Set the label of the shorter duration partial to zero.");

void sift( PartialList * partials );

%feature("docstring",
"Sort the Partials in a PartialList in order of increasing label.
The sort is stable; Partials having the same label are not
reordered.");

void sortByLabel( PartialList * partials );

%feature("docstring",
"Return a string describing the Loris version number.");

%inline %{
	const char * version( void )
	{
		static const char * vstr = LORIS_VERSION_STR;
		return vstr;
	}
%}
 
// ----------------------------------------------------------------
//		wrap Loris classes

//	Wrap all calls into the Loris library with exception
//	handlers to prevent exceptions from leaking out of the
//	C++ code, wherein they can be handled, and into the
//	interpreter, where they will surely cause an immediate
//	halt. Only std::exceptions and Loris::Exceptions (and 
//	subclasses) can be thrown.
//
//	Don't use procedural interface calls here, because this 
//	exception handler doesn't check for exceptions raised in
//	the procedural interface!
//

//	These should probably not all report UnknownError, could
//	make an effort to raise the right kind of (SWIG) exception.
//
%exception {
	try
	{	
		$action
	}
	catch( Loris::Exception & ex ) 
	{
		//	catch Loris::Exceptions:
		std::string s("Loris exception: " );
		s.append( ex.what() );
		SWIG_exception( SWIG_UnknownError, (char *) s.c_str() );
	}
	catch( std::exception & ex ) 
	{
		//	catch std::exceptions:
		std::string s("std C++ exception: " );
		s.append( ex.what() );
		SWIG_exception( SWIG_UnknownError, (char *) s.c_str() );
	}
}

// several classes define a copy member that
// returns a new object:
//
%newobject *::copy;

// ---------------------------------------------------------------------------
//	class Marker
//
%feature("docstring",
"Class Marker represents a labeled time point in a set of Partials
or a vector of samples. Collections of Markers (see the MarkerContainer
definition below) are held by the File I/O classes in Loris (AiffFile,
SdifFile, and SpcFile) to identify temporal features in imported
and exported data.") Marker;

class Marker
{
public:
//	-- construction --
	
%feature("docstring",
"Initialize a Marker with the specified time (in seconds) and name,
or copy the time and name from another Marker. If unspecified, time 
is zero and the label is empty.") Marker;

	Marker( void );
	 
	Marker( double t, const char * s );	 

	Marker( const Marker & other );
	
%feature("docstring",
"Destroy this Marker.") Marker::~Marker;
	~Marker( void );

		 
//	-- access --

%feature("docstring",
"Return the name of this Marker.");

	%extend 
	{
		const char * name( void ) { return self->name().c_str(); }
	}
	 
%feature("docstring",
"Return the time (in seconds) associated with this Marker.");

	double time( void );
	 
//	-- mutation --

%feature("docstring",
"Set the name of the Marker.");

	void setName( const char * s );
	 
%feature("docstring",
"Set the time (in seconds) associated with this Marker.");

	void setTime( double t );

	
};	//	end of class Marker

// ---------------------------------------------------------------------------
//	class AiffFile
//	
%feature("docstring",
"An AiffFile represents a sample file (on disk) in the Audio Interchange
File Format. The file is read from disk and the samples stored in memory
upon construction of an AiffFile instance. The samples are accessed by 
the samples() method, which converts them to double precision floats and
returns them in a vector.") AiffFile;

%newobject AiffFile::samples;

%feature("docstring",
"");

class AiffFile
{
public:
%feature("docstring",
"An AiffFile instance can be initialized in any of the following ways:

Initialize a new AiffFile from a vector of samples and sample rate.

Initialize a new AiffFile using data read from a named file.

Initialize an instance of AiffFile having the specified sample 
rate, accumulating samples rendered at that sample rate from
all Partials on the specified half-open (STL-style) range with
the (optionally) specified Partial fade time (see Synthesizer.h
for an examplanation of fade time). 
") AiffFile;

	AiffFile( const char * filename );
	AiffFile( const std::vector< double > & vec, double samplerate );

%feature("docstring",
"Destroy this AiffFile.") ~AiffFile;

	~AiffFile( void );
	
%feature("docstring",
"Return the sample rate in Hz for this AiffFile.") sampleRate;

	double sampleRate( void ) const;
	
%feature("docstring",
"Return the MIDI note number for this AiffFile. The defaul
note number is 60, corresponding to middle C.") midiNoteNumber;
	
	double midiNoteNumber( void ) const;

	//	this has been renamed
%feature("docstring",
"Return the number of sample frames (equal to the number of samples
in a single channel file) stored by this AiffFile.") numFrames;

	%rename( sampleFrames ) numFrames;
	unsigned long numFrames( void ) const;
		
%feature("docstring",
"Render the specified Partial using the (optionally) specified
Partial fade time, and accumulate the resulting samples into
the sample vector for this AiffFile.") addPartial;

	void addPartial( const Loris::Partial & p, double fadeTime = .001 /* 1 ms */ );

%feature("docstring",
"Set the fractional MIDI note number assigned to this AiffFile. 
If the sound has no definable pitch, use note number 60.0 
(the default).") setMidiNoteNumber;

	void setMidiNoteNumber( double nn );
		 
%feature("docstring",
"Export the sample data represented by this AiffFile to
the file having the specified filename or path. Export
signed integer samples of the specified size, in bits
(8, 16, 24, or 32).") write;

void write( const char * filename, unsigned int bps = 16 );
	
	%extend 
	{

		AiffFile( PartialList * l, double sampleRate = 44100, double fadeTime = .001 ) 
		{
			return new AiffFile( l->begin(), l->end(), sampleRate, fadeTime );
		}
	
%feature("docstring",
"Return a copy of the samples (as floating point numbers
on the range -1,1) stored in this AiffFile.") samples; 

		std::vector< double > samples( void )
		{
			return self->samples();
		}

		 
%feature("docstring",
"The number of channels is always 1. 
Loris only deals in mono AiffFiles") channels;

		int channels( void ) { return 1; }

%feature("docstring",
"Render all Partials on the specified half-open (STL-style) range
with the (optionally) specified Partial fade time (see Synthesizer.h
for an examplanation of fade time), and accumulate the resulting 
samples.") addPartials;

		void addPartials( PartialList * l, double fadeTime = 0.001/* 1ms */ )
		{
			self->addPartials( l->begin(), l->end(), fadeTime );
		}
		
%feature("docstring",
"Return the (possibly empty) collection of Markers for 
this AiffFile.") markers;

		std::vector< Marker > markers( void )
		{
			return self->markers();
		}

%feature("docstring",
"Append a collection of Markers for to the existing
set of Markers for this AiffFile.") addMarkers;

		void addMarkers( const std::vector< Marker > & markers )
		{
			self->markers().insert( self->markers().end(),
			                        markers.begin(), markers.end() );
		}
	
%feature("docstring",
"Specify a new (possibly empty) collection of Markers for
this AiffFile.") setMarkers;

		void setMarkers( const std::vector< Marker > & markers )
		{
			self->markers().assign( markers.begin(), markers.end() );
		}
	}
};

// ---------------------------------------------------------------------------
//	class Analyzer
//	

%feature("docstring",
"An Analyzer represents a configuration of parameters for
performing Reassigned Bandwidth-Enhanced Additive Analysis
of sampled waveforms. This analysis process yields a collection 
of Partials, each having a trio of synchronous, non-uniformly-
sampled breakpoint envelopes representing the time-varying 
frequency, amplitude, and noisiness of a single bandwidth-
enhanced sinusoid. 

For more information about Reassigned Bandwidth-Enhanced 
Analysis and the Reassigned Bandwidth-Enhanced Additive Sound 
Model, refer to the Loris website: 

	http://www.cerlsoundgroup.org/Loris/
") Analyzer;


%newobject Analyzer::analyze;
			
class Analyzer
{
public:
%feature("docstring",
"Construct and return a new Analyzer configured with the given	
frequency resolution (minimum instantaneous frequency	
difference between Partials) and analysis window main 
lobe width (between zeros). All other Analyzer parameters 	
are computed from the specified resolution and window
width. If the window width is not specified, 
then it is assumed to be equal to the resolution.

An Analyzer configuration can also be copied from another
instance.") Analyzer;
	 
	Analyzer( double resolutionHz );
	Analyzer( double resolutionHz, double windowWidthHz );
	Analyzer( const Analyzer & another );

%feature("docstring",
"Destroy this Analyzer.") ~Analyzer;

	~Analyzer( void );
		
	%extend 
	{
%feature("docstring",
"Analyze a vector of (mono) samples at the given sample rate 	  	
(in Hz) and return the resulting Partials in a PartialList.
If specified, use a frequency envelope as a fundamental reference for
Partial formation.") analyze;

		PartialList * analyze( const std::vector< double > & vec, double srate )
		{
			PartialList * partials = new PartialList();
			if ( ! vec.empty() )
			{
				self->analyze( vec, srate );
			}
			partials->splice( partials->end(), self->partials() );
			return partials;
		}
		 
		PartialList * analyze( const std::vector< double > & vec, double srate, 
                             LinearEnvelope * env )
		{
			PartialList * partials = new PartialList();
			if ( ! vec.empty() )
			{
				self->analyze( vec, srate, *env );
			}
			partials->splice( partials->end(), self->partials() );
			return partials;
		}
	}
	
	//	parameter access:
	double freqResolution( void ) const;
	double ampFloor( void ) const;
 	double windowWidth( void ) const;
 	double sidelobeLevel( void ) const;
 	double freqFloor( void ) const;
	double hopTime( void ) const;
 	double freqDrift( void ) const;
 	double cropTime( void ) const;
	double bwRegionWidth( void ) const;
	
	//	parameter mutation:
	void setFreqResolution( double x );
	void setAmpFloor( double x );
	void setWindowWidth( double x );
	void setSidelobeLevel( double x );
	void setFreqFloor( double x );
	void setFreqDrift( double x );
 	void setHopTime( double x );
 	void setCropTime( double x );
 	void setBwRegionWidth( double x );

};	//	end of class Analyzer
			
// ---------------------------------------------------------------------------
//	class LinearEnvelope
//

%feature("docstring",
"A LinearEnvelope represents a linear segment breakpoint 
function with infinite extension at each end (that is, the 
values past either end of the breakpoint function have the 
values at the nearest end).") LinearEnvelope;


class LinearEnvelope
{
public:
%feature("docstring",
"Construct and return a new LinearEnvelope, empty,
or having a single breakpoint at time 0 with the 
specified value.

An LinearEnvelope can also be copied from another
instance.") LinearEnvelope;

	LinearEnvelope( void );
	LinearEnvelope( const LinearEnvelope & );
	LinearEnvelope( double initialValue );
   
   
%feature("docstring",
"Destroy this LinearEnvelope.") ~LinearEnvelope;
   
	~LinearEnvelope( void );
	
%feature("docstring",
"Insert a new breakpoint into the envelope at the specified
time and value.") insertBreakpoint;

	void insertBreakpoint( double time, double value );

%feature("docstring",
"Insert a new breakpoint into the envelope at the specified
time and value.") insert;

	void insert( double time, double value );

%feature("docstring",
"Return the (linearly-interpolated) value of the envelope
at the specified time.") valueAt; 

	double valueAt( double x ) const;		
	 
};	//	end of class LinearEnvelope


%feature("docstring",
"BreakpointEnvelope is deprecated, use LinearEnvelope instead.") BreakpointEnvelope;

// BreakpointEnvelope is a typedef for LinearEnvelope, 
// not a derived class, but I could not make SWIG
// give two names to the same type, even using SWIG's
// %typedef. BreakpointEnvelopes could not be passed
// as arguments to functions expecting LinearEnvelopes.
// This fake inheritance achieves what I want: two 
// interchangeable types.
class BreakpointEnvelope : public LinearEnvelope
{
public:
	BreakpointEnvelope( void );
	BreakpointEnvelope( const BreakpointEnvelope & );
	BreakpointEnvelope( double initialValue );
	~BreakpointEnvelope( void );
	void insertBreakpoint( double time, double value );
	double valueAt( double x ) const;		
};


// ---------------------------------------------------------------------------
//	class SdifFile
//
%feature("docstring",
"Class SdifFile represents reassigned bandwidth-enhanced Partial 
data in a SDIF-format data file. Construction of an SdifFile 
from a stream or filename automatically imports the Partial
data.") SdifFile;


%newobject SdifFile::partials;

class SdifFile
{
public:
 %feature("docstring",
"Initialize an instance of SdifFile by importing Partial data from
the file having the specified filename or path, 
or initialize an instance of SdifFile storing the Partials in
the specified PartialList. If no PartialList is specified,
construct an empty SdifFile.") SdifFile;

	SdifFile( const char * filename );
	SdifFile( void );
	 
%feature("docstring",
"Destroy this SdifFile.") ~SdifFile;

	 ~SdifFile( void );
		
%feature("docstring",
"Export the Partials represented by this SdifFile to
the file having the specified filename or path.") write; 

	void write( const char * path );

%feature("docstring",
"Export the envelope Partials represented by this SdifFile to
the file having the specified filename or path in the 1TRC
format, resampled, and without phase or bandwidth information.") write1TRC;

	void write1TRC( const char * path );
	
	%extend 
	{
		SdifFile( PartialList * l ) 
		{
			return new SdifFile( l->begin(), l->end() );
		}
	
%feature("docstring",
"Return a copy of the Partials represented by this SdifFile.") partials;

		PartialList * partials( void )
		{
			PartialList * plist = new PartialList( self->partials() );
			return plist;
		}
		 
%feature("docstring",
"Add all the Partials in a PartialList to this SdifFile.") addPartials;

		void addPartials( PartialList * l )
		{
			self->addPartials( l->begin(), l->end() );
		}
		 
		//	add members to access Markers
		// 	now much improved to take advantage of 
		// 	SWIG support for std::vector.
%feature("docstring",
"Return the (possibly empty) collection of Markers for 
this SdifFile.") markers;

		std::vector< Marker > markers( void )
		{
			return self->markers();
		}

%feature("docstring",
"Append a collection of Markers for to the existing
set of Markers for this SdifFile.") addMarkers;

		void addMarkers( const std::vector< Marker > & markers )
		{
			self->markers().insert( self->markers().end(),
			                        markers.begin(), markers.end() );
		}
	
%feature("docstring",
"Specify a new (possibly empty) collection of Markers for
this SdifFile.") setMarkers;

		void setMarkers( const std::vector< Marker > & markers )
		{
			self->markers().assign( markers.begin(), markers.end() );
		}	
	}	
		 
};	//	end of class SdifFile

// ---------------------------------------------------------------------------
//	class SpcFile
//
%feature("docstring",
"Class SpcFile represents a collection of reassigned bandwidth-enhanced
Partial data in a SPC-format envelope stream data file, used by the
real-time bandwidth-enhanced additive synthesizer implemented on the
Symbolic Sound Kyma Sound Design Workstation. Class SpcFile manages 
file I/O and conversion between Partials and envelope parameter streams.") SpcFile;

%newobject SpcFile::partials;

class SpcFile
{
public:
%feature("docstring",
"Construct and return a new SpcFile by importing envelope parameter 
streams from the file having the specified filename or path, 
or initialize an instance of SpcFile having the specified fractional
MIDI note number. If a PartialList is specified, add those
Partials to the file. Otherwise, the new SpcFile contains 
no Partials (or envelope parameter streams).
The default MIDI note number is 60 (middle C).") SpcFile;

	SpcFile( const char * filename );
	SpcFile( double midiNoteNum = 60 );

%feature("docstring",
"Destroy this SpcFile.") ~SpcFile;
   
	~SpcFile( void );
	
%feature("docstring",
"Return the sample rate for this SpcFile in Hz.") sampleRate;

	double sampleRate( void ) const;

%feature("docstring",
"Return the MIDI note number for this SpcFile.
Note number 60 corresponds to middle C.") sampleRate;

	double midiNoteNumber( void ) const;

%feature("docstring",
"Add the specified Partial to the enevelope parameter streams
represented by this SpcFile. If a label is specified, use that
label, instead of the Partial's label, for the Partial added to
the SpcFile.

A SpcFile can contain only one Partial having any given (non-zero) 
label, so an added Partial will replace a Partial having the 
same label, if such a Partial exists.

This may throw an InvalidArgument exception if an attempt is made
to add unlabeled Partials, or Partials labeled higher than the
allowable maximum.") addPartial;

	void addPartial( const Loris::Partial & p );
	void addPartial( const Loris::Partial & p, int label );

%feature("docstring",
"Set the fractional MIDI note number assigned to this SpcFile. 
If the sound has no definable pitch, use note number 60.0 (the default).") setMidiNoteNumber;

	void setMidiNoteNumber( double nn );
	 
%feature("docstring",
"Set the sampling freqency in Hz for the spc data in this
SpcFile. This is the rate at which Kyma must be running to ensure
proper playback of bandwidth-enhanced Spc data.
The default sample rate is 44100 Hz.") setSampleRate;

	void setSampleRate( double rate );
			 
%feature("docstring",
"Export the envelope parameter streams represented by this SpcFile to
the file having the specified filename or path. Export phase-correct 
bandwidth-enhanced envelope parameter streams if enhanced is true 
(the default), or pure sinsoidal streams otherwise.

A nonzero endApproachTime indicates that the Partials do not include a
release or decay, but rather end in a static spectrum corresponding to the
final Breakpoint values of the partials. The endApproachTime specifies how
long before the end of the sound the amplitude, frequency, and bandwidth
values are to be modified to make a gradual transition to the static spectrum.

If the endApproachTime is not specified, it is assumed to be zero, 
corresponding to Partials that decay or release normally.") write;

	void write( const char * filename, bool enhanced = true,
				double endApproachTime = 0 );

	
	%extend 
	{
		SpcFile( PartialList * l, double midiNoteNum = 60 ) 
		{
			return new SpcFile( l->begin(), l->end(), midiNoteNum );
		}
	
%feature("docstring",
"Return a copy of the Partials represented by this SdifFile.") partials;

		PartialList * partials( void )
		{
			PartialList * plist = new PartialList( self->partials().begin(), self->partials().end() );
			return plist;
		}

%feature("docstring",
"Add all the Partials in a PartialList to this SpcFile.
			
A SpcFile can contain only one Partial having any given (non-zero) 
label, so an added Partial will replace a Partial having the 
same label, if such a Partial exists.

This may throw an InvalidArgument exception if an attempt is made
to add unlabeled Partials, or Partials labeled higher than the
allowable maximum.") addPartials;

		void addPartials( PartialList * l )
		{
			self->addPartials( l->begin(), l->end() );
		}
		 
%feature("docstring",
"Return the (possibly empty) collection of Markers for 
this SpcFile.") markers;

		std::vector< Marker > markers( void )
		{
			return self->markers();
		}

%feature("docstring",
"Append a collection of Markers for to the existing
set of Markers for this SpcFile.") addMarkers;

		void addMarkers( const std::vector< Marker > & markers )
		{
			self->markers().insert( self->markers().end(),
			                        markers.begin(), markers.end() );
		}
	
%feature("docstring",
"Specify a new (possibly empty) collection of Markers for
this SpcFile.") setMarkers;

		void setMarkers( const std::vector< Marker > & markers )
		{
			self->markers().assign( markers.begin(), markers.end() );
		}
	}
	
};	//	end of class SpcFile

// ----------------------------------------------------------------
//		wrap PartialList classes
//
//	(PartialList, PartialListIterator, Partial, PartialIterator, 
//	and Breakpoint)
//
//	This stuff is kind of big, so it lives in its own interface
//	file.
%include lorisPartialList.i

