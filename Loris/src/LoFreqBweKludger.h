#ifndef __low_freq_bwe_kludge__
#define __low_freq_bwe_kludge__

// ===========================================================================
//	LoFreqBweKludger.h
//
//	Class definintion for Loris::LoFreqBweKludger.
//
//	BW enhanced synthesis still sounds bad if applied to low frequency
//	partials. For breakpoints below a certain cutoff, it is best to set
//	the bandwidth to zero, and adjust the amplitude to account for the
//	missing noise energy. 
//
//	This kludger does the trick. Inherits PartialIterator, and transforms
//	amplitudes and bandwidths of low frequency Partials.
//
//	-kel 7 Oct 99
//
// ===========================================================================

#include "LorisLib.h"
#include "PartialIterator.h"

Begin_Namespace( Loris )

class Partial;
class Breakpoint;

// ---------------------------------------------------------------------------
//	class LoFreqBweKludger
//
class LoFreqBweKludger : public PartialDecorIterator
{
public:
	LoFreqBweKludger( double f );
	LoFreqBweKludger( const Partial & pin, double f );
	LoFreqBweKludger( const LoFreqBweKludger & other ) :
		_cutoff( other._cutoff ), PartialDecorIterator( other ) {}
	
//	cloning:
//	In standard C++, an overriding member can return a type that
//	is derived from the type of the overidden parent member.
//	But not in MIPSPro C++.
#if defined(__sgi) && ! defined(__GNUC__)
	PartialIterator * 
#else
	LoFreqBweKludger *	
#endif
		clone( void ) const { return new LoFreqBweKludger( *this ); }

	//	override these two:
	double amplitude( void ) const;
	double bandwidth( void ) const;
	
private:
	//	helper
	static inline double bwclamp( double bw );
	
	//	instance variable:
	double _cutoff;
	
};	//	end of class LoFreqBweKludger

End_Namespace( Loris )

#endif	// ndef __low_freq_bwe_kludge__
