import 'dart:ui';
import 'package:flame/sprite.dart';
class Ground{
  Sprite groundSprite;
  Rect groundRect;

  Ground()
  {

    groundSprite = Sprite('ground.png');
    groundRect = Rect.fromLTWH(0,409,500,13);

  }
  void render(Canvas c) {
    groundSprite.renderRect(c, groundRect);
  }

  void update(double t) {}



}