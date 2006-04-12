#ifndef MORPH_AREA_H
#define MORPH_AREA_H

/*
 * This is Fossa, a grapical control application for analysis, synthesis, 
 * and manipulations of digitized sounds using Loris (Fitz and Haken). 
 *
 * Fossa is Copyright (c) 2001 - 2002 by Susanne Lefvert
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
 * morphArea.h
 *
 * Definition of the MorphArea class.
 * 
 *
 * Susanne Lefvert, 1 March 2002
 *
 *
 */

#include "LinearEnvelope.h"
#include "axis.h"
#include "soundList.h"
#include "pointWithText.h"

#include <qcanvas.h>
#include <qsortedlist.h> 
#include <qlist.h> 

class PointWithText;
class QStatusBar;

class SoundList;
class Axis;

class FrequencyPoint;
class AmplitudePoint;
class NoisePoint;

/*
--------------------------------------------------------------------------------
class MorphArea
MorphArea inherits QCanvasView and lets a user insert and direct manipulate 
amplitude, frequency, and noise breakpoints into the canvas and are visible
on the QCanvasView. The  breakpoints represents the morphing function between 
two sounds. The MorphArea has 4 states; amplitude, frequency, noise, and all three 
states combined, which is the default state. When we are in a certain state, 
for example amplitude, we can insert, remove, and drag amplitude points.  
*/

class MorphArea:public QCanvasView{ 
  Q_OBJECT

  public:
    MorphArea(
	QCanvas*	canvas,
	QWidget*	parent,
	char*		name,
	SoundList*	soundList,
	QStatusBar*	statusbar
    );
    void		contentsMousePressEvent(QMouseEvent* e);
    void		contentsMouseMoveEvent(QMouseEvent* e);
    void		contentsMouseReleaseEvent(QMouseEvent* e);
    void		addPoint(int x, int y);
    int			rtti() const;
    double		toXAxisValue(int x);
    double		toYAxisValue(int y);
    const QPoint	getOrigo() const;
 
  public slots:
    void		clearAll();
    void		showHideClear(int buttonId);
    void		morph();
    void		setMorph1(int Pos, QString& name);
    void		setMorph2(int Pos, QString& name);

  private:
    enum		State {all, amplitude, frequency, noise};
    State		state;
    Axis*		lAxis;
    Axis*		rAxis;
    Axis*		bAxis;
    QStatusBar*		statusbar;
    QList<QCanvasItem>	moving;
    SoundList*		soundList;
 
    QString		morph1;
    QString		morph2;

    int			morphPos1;
    int			morphPos2;

    int			leftMargin;
    int			rightMargin;
    int			topMargin;
    int			bottomMargin;
    int			width;
    int			height;
    int			newPointIndex;

    QSortedList<PointWithText>	aList;
    QSortedList<PointWithText>	fList;
    QSortedList<PointWithText>	nList;

    bool	inArea(int, int);

    void	fillEnvelope(
			QSortedList<PointWithText>&	list,
			LinearEnvelope&			envelope
    );

    void	showHideList(
			QSortedList<PointWithText>&	list,
			bool				show
    );

    void	addpointHelp(
			QSortedList<PointWithText>&	list,
			PointWithText*			newPoint
    );

    void	rightButtonHelp(
			QSortedList<PointWithText>&	list,
			PointWithText*			point
    );

    void	moveHelp(
			QSortedList<PointWithText>&	list,
			PointWithText*			movingPoint,
			int				x,
			int				y
    );

    void	setHorizontalAxis();
};
#endif // MORPH_AREA_H
