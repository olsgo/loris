#!/usr/bin/python

"""
nonsense.py

Analyze and reconstruct the fried vocal sample sent by Ben Gillett.

This sound definitely gives better harmonic tracking when reanalyzed
using the tracking analysis and the fundamental extracted in the first
analysis, BUT the reconstruction is a little bit worse in that case. 

Two partials per harmonic are always necessary for decent
sound, and the sound doesn't improve with the improved tracking.
One partial per harmonic is completely unlistenable.


Last updated: 23 Aug 2007 by Kelly Fitz
"""

import loris, time, os

orate = 44100

tag = ''

stuff = {}

# ----------------------------------------------------------------------------

def doNonsense( exportDir = '' ):

	name = 'nonsense'
	f = loris.AiffFile( name + '.aiff' )
	
	print 'analyzing %s (%s)'%(name, time.ctime(time.time()))
	res = 50
	width = 180
	anal = loris.Analyzer( res, width )
	anal.setFreqFloor( 50 )
	anal.setFreqDrift( 40 )
	anal.setBwRegionWidth( 0 ) # no BW association
	anal.buildFundamentalEnv( 40, 155 )
	
	p = anal.analyze( f.samples(), f.sampleRate() )
	ref = anal.fundamentalEnv()
	
	# distill at 2 Partials per harmonic
	print 'sifting and distilling %i partials (%s)'%(p.size(), time.ctime(time.time()))
	N = 2
	loris.channelize( p, ref, N )
	loris.sift( p )
	loris.distill( p )

# 	
# 	# reanalyze using tracking
# 	print 're-analyzing %s with fundamental track (%s)'%(name, time.ctime(time.time()))
# 	ptk = anal.analyze( f.samples(), f.sampleRate(), ref )
# 	
# 	# distill at N Partials per harmonic
# 	print 'sifting and distilling %i partials (%s)'%(p.size(), time.ctime(time.time()))
# 	loris.channelize( ptk, ref, N )
# 	loris.sift( ptk )
# 	loris.distill( ptk )
# 	
	
	if exportDir:
	
		print 'synthesizing %i distilled partials, %i per harmonic (%s)'%(p.size(), N, time.ctime(time.time()))
		out_sfile = loris.AiffFile( p, orate )
		
		opath = os.path.join( exportDir, name + tag + '.%i.recon.aiff'%(N) ) 
		print 'writing %s (%s)'%(opath, time.ctime(time.time()))
		out_sfile.setMarkers( f.markers() )
		out_sfile.write( opath )
		
		opath = os.path.join( exportDir, name + tag + '.%i.sdif'%(N) )
		print 'writing %s (%s)'%(opath, time.ctime(time.time()))
		out_pfile = loris.SdifFile( p )
		out_pfile.setMarkers( f.markers() )
		out_pfile.write( opath )	
				

# 		print 'synthesizing %i distilled tracked partials, %i per harmonic (%s)'%(ptk.size(), N, time.ctime(time.time()))
# 		out_sfile = loris.AiffFile( ptk, orate )
# 		
# 		opath = os.path.join( exportDir, name + tag + '.tk%i.recon.aiff'%(N) ) 
# 		print 'writing %s (%s)'%(opath, time.ctime(time.time()))
# 		out_sfile.setMarkers( f.markers() )
# 		out_sfile.write( opath )
# 		
# 		opath = os.path.join( exportDir, name + tag + '.tk%i.sdif'%(N) )
# 		print 'writing %s (%s)'%(opath, time.ctime(time.time()))
# 		out_pfile = loris.SdifFile( ptk )
# 		out_pfile.setMarkers( f.markers() )
# 		out_pfile.write( opath )	
# 

	stuff[ name ] = ( p, ref, anal )
	
	print 'Done. (%s)'%(time.ctime(time.time()))		


# ----------------------------------------------------------------------------

if __name__ == '__main__':
	print __doc__

	print 'Using Loris version %s'%( loris.version() )

	import sys
	odir = os.curdir
	if len( sys.argv ) > 1:
		tag = '.' + sys.argv[1]
		
	doNonsense( odir )
	