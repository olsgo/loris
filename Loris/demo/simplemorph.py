#!python
#
#   This is the Loris C++ Class Library, implementing analysis, 
#   manipulation, and synthesis of digitized sounds using the Reassigned 
#   Bandwidth-Enhanced Additive Sound Model.
#   
#   Loris is Copyright (c) 1999-2000 by Kelly Fitz and Lippold Haken
#  
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#  
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY, without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#   GNU General Public License for more details.
#  
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#  
#  
#	simplemorph.py
#
#	Very simple Loris instrument tone morphing demonstration.
#
#   Kelly Fitz, 19 Nov 2000
#   loris@cerlsoundgroup.org
#  
#   http://www.cerlsoundgroup.org/Loris/
#
"""
Welcome to the very simple Loris morphing demo!
Kelly Fitz 2000

Generates a simple linear morph between a 
clarinet and a flute.
"""
print __doc__

import loris, os, time
print '(in %s)' % os.getcwd()

#
#	analyze clarinet tone
#
print 'analyzing clarinet 3G# (%s)' % time.ctime(time.time())
a = loris.Analyzer(270)
v = loris.importAiff( 'clarinet.aiff' )
(n, samplerate, nchans) = loris.infoAiff( 'clarinet.aiff' )

clar = a.analyze( v, samplerate )

loris.channelize( clar, loris.createFreqReference( clar, 20, 0, 1000 ), 1 )
loris.distill( clar )

loris.shiftPitch( clar, loris.BreakpointEnvelopeWithValue( -600 ) )

# check clarinet synthesis:
# loris.exportAiff( 'clarOK.aiff', loris.synthesize( clar, samplerate ), samplerate, 1, 16 )

#
#	analyze flute tone (reuse Analyzer)
#
print 'analyzing flute 3D (%s)' % time.ctime(time.time())
# reuse: a = loris.Analyzer(270)
v = loris.importAiff( 'flute.aiff' )
(n, samplerate, nchans) = loris.infoAiff( 'flute.aiff' )

flut = a.analyze( v, samplerate )

loris.channelize( flut, loris.createFreqReference( flut, 20, 0, 1000 ), 1 )
loris.distill( flut )

# check flute synthesis:
# loris.exportAiff( 'flutOK.aiff', loris.synthesize( flut, samplerate ), samplerate, 1, 16 )

#
#	perform temporal dilation
#
flute_times = [0.4, 1.]
clar_times = [0.2, 1.]
tgt_times = [0.3, 1.2]

print 'dilating sounds to match', tgt_times, '(%s)' % time.ctime(time.time())
print 'flute times:', flute_times
loris.dilate( flut, str(flute_times), str(tgt_times) )
print 'clarinet times:', clar_times
loris.dilate( clar, str(clar_times), str(tgt_times) )

#
#	perform morph
#
print 'morphing flute and clarinet (%s)' % time.ctime(time.time())
mf = loris.BreakpointEnvelope()
mf.insertBreakpoint( 0.6, 0 )
mf.insertBreakpoint( 2, 1 )
m = loris.morph( clar, flut, mf, mf, mf )
loris.exportAiff( 'simple_morph.aiff', 
				  loris.synthesize( m, samplerate ), 
				  samplerate, 1, 16 )
