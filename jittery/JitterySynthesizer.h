#ifndef INCLUDE_SYNTHESIZER_H
#define INCLUDE_SYNTHESIZER_H
/*
 * This is the Loris C++ Class Library, implementing analysis, 
 * manipulation, and synthesis of digitized sounds using the Reassigned 
 * Bandwidth-Enhanced Additive Sound Model.
 *
 * Loris is Copyright (c) 1999-2000 by Kelly Fitz and Lippold Haken
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

#include <ODonnellOscil.h>

#include <memory>
#include <vector>

//	begin namespace
namespace Loris {

class Envelope;
class Partial;

// ---------------------------------------------------------------------------
//	class Synthesizer
//	
//	Class Synthesizer represents an algorithm for rendering
//	bandwidth-enhanced Partials as floating point (double) samples at a
//	specified sampling rate, and accumulating them into a buffer. The
//	Synthesizer does not own the sample buffer, the client is responsible
//	for its construction and destruction, and many Synthesizers may share
//	a buffer.
//
class Synthesizer
{
//	-- public interface --
public:
//	-- construction --
	Synthesizer( double srate, std::vector<double> & buffer, double fadeTime = .001 );
	/*	Construct a Synthesizer using the specified sampling rate, sample
		buffer (a standard library vector), and Partial
		fade time (in seconds). Since Partials generated by the Loris Analyzer
		generally begin and end at non-zero amplitude, zero-amplitude
		Breakpoints are inserted at either end of the Partial, at a temporal
		distance equal to the fade time, to reduce turn-on and turn-off
		artifacts. If the fade time is unspecified, the default value of one
		millisecond (0.001 seconds) is used.
	 */
	 
	Synthesizer( const Synthesizer & other );
	/*	Construct a Synthesizer that is an exact copy of another Synthesizer,
		that is, uses the same sample buffer, sampling rate, and fade time.
	 */
	 
	~Synthesizer( void );
	/*	 Destroy this Synthesizer. (Does not destroy the sample buffer.)
	 */
	
	Synthesizer & operator= ( const Synthesizer & other );
	/*	Assignment operator: change this synthesizer to be an exact copy
		of the specified Synthesizer, rhs, that is, using the same sample
		buffer, sampling rate, and fade time.
	 */
	 
//	-- synthesis --
	void synthesize( const Partial & p );	
	/*	Synthesize a bandwidth-enhanced sinusoidal Partial. Zero-amplitude
		Breakpoints are inserted at either end of the Partial to reduce
		turn-on and turn-off artifacts, as described above. The client is
		responsible or insuring that this Synthesizer's buffer is long enough
		to hold all samples from the  padded Partials.
		Synthesizer will not generate samples outside the buffer, but neither
		will any attempt be made to eliminate clicks at the buffer boundaries.
	 */
	 
	void operator() ( const Partial & p )
		{ synthesize( p ) ; }
	/*	Function call operator: same as synthesize( p ).
	 */
	 
#if !defined(NO_TEMPLATE_MEMBERS)
	template<typename Iter>
	void synthesize( Iter begin_partials, Iter end_partials )
		{ while ( begin_partials != end_partials ) synthesize( *(begin_partials++) ); }
	/*	Synthesize all Partials on the specified half-open range. Zero-amplitude
		Breakpoints are inserted at either end of the Partial to reduce
		turn-on and turn-off artifacts, as described above. The client is
		responsible or insuring that this Synthesizer's buffer is long enough
		to hold all samples from the padded Partials.
		Synthesizer will not generate samples outside the buffer, but neither
		will any attempt be made to eliminate clicks at the buffer boundaries.
		
		If compiled with NO_TEMPLATE_MEMBERS defined, this member is not
		defined.
	 */
	 
	template<typename Iter>
	void operator() ( Iter begin_partials, Iter end_partials )
		{ synthesize( begin_partials, end_partials ); }
	/*	Function call operator: same as 
		synthesize( begin_partials, end_partials ).
		
		If compiled with NO_TEMPLATE_MEMBERS defined, this member
		is not defined.
	 */
#endif
	
//	-- access --
	double fadeTime( void ) const;
	/* 	Return this Synthesizer's Partial fade time, in seconds.
	 */
	 
	std::vector<double>::size_type numSamples( void ) const;
	/*	Return the size of the sample buffer used (but not owned) by
		this Synthesizer.
	 */
	 
	double sampleRate( void ) const;
	/*	Return the sampling rate (in Hz) for this Synthesizer.
	 */

	const std::vector<double> samples( void ) const;
	std::vector<double> samples( void );
	/*	Return a reference (or const reference) to the sample buffer used (not
		owned) by this Synthesizer.
	 */
	
//	-- mutation --
	void setFadeTime( double partialFadeTime );
	/*	Set this Synthesizer's fade time to the specified value 
		(in seconds, must be non-negative).
	 */
	 
	void configureJitter( const Envelope & gain, const Envelope & coherence,
						  unsigned int coherenceCutoff );
	/*	Configure this jittery Synthesizer to use the specified envelops
		controlling jitter gain and coherence. Partials labeled greater
		than the coherence cutoff are completely incoherent.
	 */

//	-- implementation --
private:
	Oscillator osc;
	std::vector< double > & sampleBuffer;	//	samples are computed and stored here
	double tfade;							// 	Partial fade in/out time in seconds
	double srate;							//	sample rate in Hz
	
	std::auto_ptr< Envelope > jitterGain;
	std::auto_ptr< Envelope > jitterCoherence;
	unsigned int jitterCutoff;


//	-- helpers --
	double coherenceAt( double t, int pnum ) const;
	double jitterAt( double t ) const;
	bool useJitter( void ) const;
		 
};	//	end of class Synthesizer

}	//	end of namespace Loris

#endif /* ndef INCLUDE_SYNTHESIZER_H */
