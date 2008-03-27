#ifndef INCLUDE_SYNTHESIZER_H
#define INCLUDE_SYNTHESIZER_H
/*
 * This is the Loris C++ Class Library, implementing analysis, 
 * manipulation, and synthesis of digitized sounds using the Reassigned 
 * Bandwidth-Enhanced Additive Sound Model.
 *
 * Loris is Copyright (c) 1999-2008 by Kelly Fitz and Lippold Haken
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
 * Synthesizer.h
 *
 * Definition of class Loris::Synthesizer, a renderer of 
 * bandwidth-enhanced Partials.
 *
 * Kelly Fitz, 16 Aug 1999
 * loris@cerlsoundgroup.org
 *
 * http://www.cerlsoundgroup.org/Loris/
 *
 */

#include "Oscillator.h"
#include "PartialList.h"
#include "PartialUtils.h"

#include <vector>

//	begin namespace
namespace Loris {

// ---------------------------------------------------------------------------
//	class Synthesizer
//
//!   A Synthesizer renders bandwidth-enhanced Partials into a buffer
//!   of samples. 
//!	
//!	Class Synthesizer represents an algorithm for rendering
//!	bandwidth-enhanced Partials as floating point (double) samples at a
//!	specified sampling rate, and accumulating them into a buffer. 
//!
//!	The Synthesizer does not own the sample buffer, the client is responsible
//!	for its construction and destruction, and many Synthesizers may share
//!	a buffer.
//
class Synthesizer
{
//	-- public interface --
public:
//	-- construction --

	//!	Construct a Synthesizer using the specified sampling rate, sample
	//!	buffer (a standard library vector), and Partial
	//!	fade time (in seconds). Since Partials generated by the Loris Analyzer
	//!	generally begin and end at non-zero amplitude, zero-amplitude
	//!	Breakpoints are inserted at either end of the Partial, at a temporal
	//!	distance equal to the fade time, to reduce turn-on and turn-off
	//!	artifacts. If the fade time is unspecified, the default value of one
	//!	millisecond (0.001 seconds) is used.
	//!
	//!	\param	srate The rate (Hz) at which to synthesize samples
	//!			   (must be positive).
	//!	\param	buffer The vector (of doubles) into which rendered samples
	//!			   should be accumulated.
	//!	\param	fadeTime The Partial fade time in seconds (must be non-negative).
	//!	\throw	InvalidArgument if the specfied sample rate is non-positive.
	//!	\throw	InvalidArgument if the specified fade time is negative.
	Synthesizer( double srate, std::vector<double> & buffer, double fadeTime = .001 );
	
	// 	Compiler can generate copy, assign, and destroy.
	//	Synthesizer( const Synthesizer & other );
	//	~Synthesizer( void );
	//	Synthesizer & operator= ( const Synthesizer & other );
	 
//	-- synthesis --

	//!	Synthesize a bandwidth-enhanced sinusoidal Partial. Zero-amplitude
	//!	Breakpoints are inserted at either end of the Partial to reduce
	//!	turn-on and turn-off artifacts, as described above. The synthesizer
	//!	will resize the buffer as necessary to accommodate all the samples,
	//!	including the fade out. Previous contents of the buffer are not
	//!	overwritten. Partials with start times earlier than the Partial fade
	//!	time will have shorter onset fades. Partials are not rendered at
	//!   frequencies above the half-sample rate. 
	//!
	//! \param  p The Partial to synthesize.
	//! \return Nothing.
	//!	\pre    The partial must have non-negative start time.
	//! \post   This Synthesizer's sample buffer (vector) has been 
	//!         resized to accommodate the entire duration of the 
	//!         Partial, p, including fade out at the end.
	//!	\throw	InvalidPartial if the Partial has negative start time.
	void synthesize( const Partial & p );	
	 
	//!	Function call operator: same as synthesize( p ).
	void operator() ( const Partial & p ) { synthesize( p ) ; }

	 
	//!	Synthesize all Partials on the specified half-open (STL-style) range.
	//!	Null Breakpoints are inserted at either end of the Partial to reduce
	//!	turn-on and turn-off artifacts, as described above. The synthesizer
	//!	will resize the buffer as necessary to accommodate all the samples,
	//!	including the fade outs. Previous contents of the buffer are not
	//!	overwritten. Partials with start times earlier than the Partial fade
	//!	time will have shorter onset fades.  Partials are not rendered at
	//! frequencies above the half-sample rate. 
	//!
	//! \param  begin_partials The beginning of the range of Partials 
	//!         to synthesize.
	//! \param 	end_partials The end of the range of Partials 
	//!         to synthesize.
	//! \return Nothing.
	//!	\pre    The partials must have non-negative start times.
	//! \post   This Synthesizer's sample buffer (vector) has been 
	//!         resized to accommodate the entire duration of all the 
	//!         Partials including fade out at the ends.
	//!	\throw	InvalidPartial if any Partial has negative start time.
#if ! defined(NO_TEMPLATE_MEMBERS)
	template< typename Iter >
	void synthesize( Iter begin_partials, Iter end_partials );
#else
    inline
	void synthesize( PartialList::iterator begin_partials, 
					 PartialList::iterator end_partials );	
#endif
	 
	//!	Function call operator: same as 
	//!	synthesize( begin_partials, end_partials ).
#if ! defined(NO_TEMPLATE_MEMBERS)
	template< typename Iter >
	void operator() ( Iter begin_partials, Iter end_partials );
#else
    inline
	void operator() ( PartialList::iterator begin_partials, 
					  PartialList::iterator end_partials );
#endif
	
//	-- access --
	//!	Return this Synthesizer's Partial fade time, in seconds.
	double fadeTime( void ) const;
	 
	//!	Return the sampling rate (in Hz) for this Synthesizer.
	double sampleRate( void ) const;

	//!	Return a const reference to the sample buffer used (not
	//!	owned) by this Synthesizer.
	const std::vector<double> & samples( void ) const;

	//!	Return a reference to the sample buffer used (not
	//!	owned) by this Synthesizer.
	std::vector<double> & samples( void );
	
//	-- mutation --

	//!	Set this Synthesizer's fade time to the specified value 
	//!	(in seconds, must be non-negative).
	//!
	//!	\param	t The new Partial fade time.
	//!	\throw	InvalidArgument if the specified fade time is negative.
	void setFadeTime( double t );
	 
//	-- implementation --
private:
	Oscillator osc;
	std::vector< double > * sampleBuffer;  //	samples are computed and stored here
	double tfade;                          //   Partial fade in/out time in seconds
	double srate;                          //	sample rate in Hz
	
};	//	end of class Synthesizer


// ---------------------------------------------------------------------------
//	synthesize 
// ---------------------------------------------------------------------------
//!	Synthesize all Partials on the specified half-open (STL-style) range.
//!	Null Breakpoints are inserted at either end of the Partial to reduce
//!	turn-on and turn-off artifacts, as described above. The synthesizer
//!	will resize the buffer as necessary to accommodate all the samples,
//!	including the fade outs. Previous contents of the buffer are not
//!	overwritten. Partials with start times earlier than the Partial fade
//!	time will have shorter onset fades.
//!
//! \param  begin_partials The beginning of the range of Partials 
//!         to synthesize.
//! \param 	end_partials The end of the range of Partials 
//!         to synthesize.
//! \return Nothing.
//!	\pre    The partials must have non-negative start times.
//! \post   This Synthesizer's sample buffer (vector) has been 
//!         resized to accommodate the entire duration of all the 
//!         Partials including fade out at the ends.
//!	\throw	InvalidPartial if any Partial has negative start time.
//
#if ! defined(NO_TEMPLATE_MEMBERS)
template<typename Iter>
void 
Synthesizer::synthesize( Iter begin_partials, Iter end_partials ) 
#else
inline void 
Synthesizer::synthesize( PartialList::iterator begin_partials, 
						 PartialList::iterator end_partials ) 
#endif
{ 
	//	grow the sample buffer if necessary
	typedef std::vector< double >::size_type Sz_Type;
	Sz_Type Nsamps = 1 +  
		Sz_Type( PartialUtils::timeSpan( begin_partials, end_partials ).second * srate );
	if ( sampleBuffer->size() < Nsamps )
	{
   	sampleBuffer->resize( Nsamps );
   }
   
	while ( begin_partials != end_partials ) 
   {
		synthesize( *(begin_partials++) ); 
   }
}

// ---------------------------------------------------------------------------
//	operator() 
// ---------------------------------------------------------------------------
//!	Function call operator: same as 
//!		synthesize( begin_partials, end_partials, timeShift ).
//
#if ! defined(NO_TEMPLATE_MEMBERS)
template<typename Iter>
void
Synthesizer::operator() ( Iter begin_partials, Iter end_partials ) 
#else
inline void
Synthesizer::operator() ( PartialList::iterator begin_partials, 
                          PartialList::iterator end_partials ) 
#endif
{ 
	synthesize( begin_partials, end_partials ); 
}

}	//	end of namespace Loris

#endif /* ndef INCLUDE_SYNTHESIZER_H */
