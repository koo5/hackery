/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the demonstration applications of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "chip.h"

#include <QtWidgets>

Chip::Chip(const QColor &color, int x, int y)
{
    this->x = x;
    this->y = y;
    this->color = color;
    setZValue((x + y) % 2);

	setFlags(ItemIsSelectable | ItemIsMovable);
    setAcceptHoverEvents(true);
}

QRectF Chip::boundingRect() const
{
    return QRectF(0, 0, 110, 70);
}

QPainterPath Chip::shape() const
{
    QPainterPath path;
    path.addRect(14, 14, 82, 42);
    return path;
}

void Chip::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget)
{
    Q_UNUSED(widget);
	const int lod_int = (option->levelOfDetailFromTransform(painter->worldTransform()) < 0.2) ? 0 : 1;
	bool isSelected		= option->state & QStyle::State_Selected;
	bool isMouseOver	= option->state & QStyle::State_MouseOver;
	if (text_id == -1)
	{
		text_id = texts.size();
		texts.append(text);
	}
	QPicture &picture = pictures[lod_int][isSelected][isMouseOver];
	if (picture.isNull())
		buildPicture(&picture, lod_int, isSelected, isMouseOver);
	painter->drawPicture(picture);
}

static void Chip::buildPicture(QPicture *picture, QString text, int lod, bool isSelected, bool isMouseOver)
{

	QPainter *painter;
	painter->begin(picture);
	QColor fillColor = (isSelected) ? color.dark(150) : color;
	if (isMouseOver)
		fillColor = fillColor.light(125);

	if (!lod) {
		painter->fillRect(QRectF(0, 0, 110, 70), fillColor);
	}
	else
	{
		QPen oldPen = painter->pen();
		QPen pen = oldPen;
		int width = 0;
		if (isSelected)
			width += 2;

		pen.setWidth(width);
		QBrush b = painter->brush();
		painter->setBrush(QBrush(fillColor.dark(option->state & QStyle::State_Sunken ? 120 : 100)));

		painter->drawRect(QRect(14, 14, 79, 39));
		painter->setBrush(b);

		// Draw text
		{
			QFont font("Times", 10);
			font.setStyleStrategy(QFont::ForceOutline);
			painter->setFont(font);
			painter->save();
			painter->scale(0.1, 0.1);
			painter->drawText(170, 180, QString("Model: VSC-2000 (Very Small Chip) at %1x%2").arg(x).arg(y));
			painter->drawText(170, 200, QString("Serial number: DLWR-WEER-123L-ZZ33-SDSJ"));
			painter->drawText(170, 220, QString("Manufacturer: Chip Manufacturer"));
			painter->restore();
		}
		painter->drawLines(lines.data(), lines.size());
	}
	painter.end();
}

void Chip::mousePressEvent(QGraphicsSceneMouseEvent *event)
{
    QGraphicsItem::mousePressEvent(event);
    update();
}

void Chip::mouseMoveEvent(QGraphicsSceneMouseEvent *event)
{
    QGraphicsItem::mouseMoveEvent(event);
}

void Chip::mouseReleaseEvent(QGraphicsSceneMouseEvent *event)
{
    QGraphicsItem::mouseReleaseEvent(event);
    update();
}


{
for x in change:
	if change.type == 'created_node':
	   URI new_node_uri = change;
		NewNode
		for group in rows[new_node .row]:
			if (group.size() && group[0].parent == new_node.parent):
				addNodeToGroup(NewNode,
	   change.parent_id
	   node =
	   change.prototype_id






}
