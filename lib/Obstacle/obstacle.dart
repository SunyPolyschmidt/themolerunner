
import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:themolerunner/mole-runner.dart';
import 'package:flame/components/mixins/resizable.dart';
enum ObstacleStatus{Onscreen, Offscreen}
class Obstacle extends PositionComponent with Resizable {
  Sprite obSprite;
  Rect obRect;
  Paint obPaint;
  bool removable = false;
  int speed;
  ObstacleStatus status = ObstacleStatus.Onscreen;
  Obstacle(int type, double x, double y)
  {
    print("ob type $type was created");
    if(type == 1) {
      obSprite = Sprite('spike1.png');
      obRect = Rect.fromLTWH(x, y, 16, 48);

    }
   /* else
      {
        obRect = Rect.fromLTWH(x, y, 16, 48);
        obPaint = Paint();
      }

    */
  }
  void render(Canvas canvas)
  {
    obSprite.renderRect(canvas, obRect);
    //canvas.drawRect(obRect, obPaint);
  }
  void update(double t)
  {
    obRect = obRect.translate(-5,0);
    if(obRect.left < 0)
      {
        removable = true;

      }
  }
}
