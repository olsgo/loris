#ifndef __Loris_morph__
#define __Loris_morph__
// ===========================================================================
//	Morph.h
//	
//	The Morph object performs sound morphing (cite Lip's papers, and the book)
//	by interpolating Partial parmeter envelopes of corresponding Partials in
//	a pair of source sounds. The correspondences are established by labeling.
//	The Morph object collects morphed Partials in a list<Partial>, that can
//	be accessed by clients.
//
//	-kel 15 Oct 99
//
// ===========================================================================
#include "Partial.h"
#include "Map.h"
#include <memory>	//	for auto_ptr

#if !defined( NO_LORIS_NAMESPACE )
//	begin namespace
namespace Loris {
#endif

// ---------------------------------------------------------------------------
//	class Morph
//
//	Hey, how about a comment?
//
class Morph : public PartialCollector
{
//	-- instance variables --
	std::auto_ptr< Map > _freqFunction;	//	frequency morphing function
	std::auto_ptr< Map > _ampFunction;	//	amplitude morphing function
	std::auto_ptr< Map > _bwFunction;	//	bandwidth morphing function
	
//	-- public interface --
public:
//	construction:
//	(allow compiler to generate destructor)
	Morph( void );
	Morph( const Map & f );
	Morph( const Map & ff, const Map & af, const Map & bwf );
	
//	morphing:
//	Morph two sounds (collections of Partials labeled to indicate
//	correspondences) into a single labeled collection of Partials.
	void morph( PartialList::const_iterator begin0, 
				PartialList::const_iterator end0,
				PartialList::const_iterator begin1, 
				PartialList::const_iterator end1 );

//	morphing functions access/mutation:	
	void setFrequencyFunction( const Map & f );
	void setAmplitudeFunction( const Map & f );
	void setBandwidthFunction( const Map & f );

	const Map & frequencyFunction( void ) const { return * _freqFunction; }
	const Map & amplitudeFunction( void ) const { return * _ampFunction; }
	const Map & bandwidthFunction( void ) const { return * _bwFunction; }
	
	Map & frequencyFunction( void ) { return * _freqFunction; }
	Map & amplitudeFunction( void ) { return * _ampFunction; }
	Map & bandwidthFunction( void ) { return * _bwFunction; }
	
//	-- helpers --
protected:	
//	morph two list of Partials:
//	(distills the each list into a single partial for morphing,
//	the morphed Partial is assigned the specified label)
	void morphLists( const PartialList & fromlist, 
					 const PartialList & tolist,
					 int assignLabel = 0 );
	
//	single Partial morph:
//	(core morphing operation, called by morph() and crossfade())
	void morphPartial( const Partial & p1, const Partial & p2, int assignLabel = 0 );
	
//	crossfade Partials with no correspondences:
//	(crossfaded Partials are unlabeled, or assigned the 
//	default label, 0)
	void crossfadeLists( const PartialList & fromlist, 
						 const PartialList & tolist );

//	-- unimplemented until useful --
private:
	Morph( const Morph & other );
	Morph & operator= ( const Morph & other );

};	//	end of class Morph

#if !defined( NO_LORIS_NAMESPACE )
}	//	end of namespace Loris
#endif

#endif	// ndef __Loris_morph__
