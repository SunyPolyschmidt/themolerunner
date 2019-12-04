import 'dart:ui';
import 'package:flame/sprite.dart';
class TheBackdrop{
  Sprite bgSprite;
  Rect bgRect;
  TheBackdrop()
  {
    bgSprite = Sprite('background.png');
    bgRect = Rect.fromLTWH(0,0,500,900);
  }
  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}