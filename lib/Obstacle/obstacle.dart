
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'dart:math';
enum ObstacleStatus{Onscreen, Offscreen}
class Obstacle extends PositionComponent with Resizable {
  Sprite obSprite;
  Rect obRect;
  Paint obPaint;
  bool removable = false;
  Random rnd;
  int min = 3;
  int max = 7;
  double speed;

  ObstacleStatus status = ObstacleStatus.Onscreen;
  Obstacle(int type, double x, double y)
  {
    print("ob type $type was created");
    if(type == 1) {
      rnd = new Random();
      speed = (min + rnd.nextInt(max - min)).toDouble();
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
  double getX()
  {
    return obRect.left;
  }
  double getHeight()
  {
    return obRect.top;
  }
  void update(double t)
  {
    obRect = obRect.translate(-speed,0);
    if(obRect.left < 0)
      {
        removable = true;

      }
  }
}
