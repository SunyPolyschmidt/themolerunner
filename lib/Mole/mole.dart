import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components/mixins/resizable.dart';


enum MoleStatus{wait, walking, jumping}
class Mole extends PositionComponent with Resizable{
  WaitMole waitMole;
  WalkMole walkMole;
  JumpMole jumpMole;

  double jumpV= 0.0;
  int jCount = 0;
  Size screenSize;

  MoleStatus status = MoleStatus.walking;
  Mole(Image spriteImage):
        waitMole = WaitMole(spriteImage),
        walkMole = WalkMole(spriteImage),
        jumpMole = JumpMole(spriteImage),
        super();

  void setScreenSize(Size s) {
    screenSize = s;
  }
  Size getScreenSize() {
    return screenSize;
  }


  /*void setPosition(x,y)
  {
    this.x = x;
    this.y = y;
  }
   */
  PositionComponent get currentMole{
    switch (status){
      case MoleStatus.wait:
        return waitMole;
      case MoleStatus.walking:
        return walkMole;
      case MoleStatus.jumping:
        return jumpMole;
      default:
        return waitMole;
    }
  }
  void doJump()
  {
    if(status == MoleStatus.jumping) return;
    status = MoleStatus.jumping;
    this.jumpV = -14;
  }
  void reset()
  {
    y = groundY;
    jumpV= 0.0;
    status = MoleStatus.walking;
  }
  void render(Canvas c){
    this.currentMole.render(c);
  }
  void update(double t){
    if(status == MoleStatus.jumping){
      y +=(jumpV);
      this.jumpV+= .7;
      if(this.y > this.groundY)
        this.reset();
    }
    else{
      y = this.groundY;
    }
    updateCoordinates(t);
  }
  void updateCoordinates(double t) {
    this.currentMole.x = x;
    this.currentMole.y = y;
    this.currentMole.update(t);
  }
  double get groundY {
    if (screenSize == null) return 0.0;
    return (screenSize.height / 2);
  }
}

class WaitMole extends SpriteComponent{
  WaitMole(Image spriteImage)
      :super.fromSprite(42,50,Sprite.fromImage(spriteImage));

}
class WalkMole extends AnimationComponent{
  WalkMole(Image spriteImage)
      :super(39,
      50,
      Animation.spriteList([
        Sprite.fromImage(
            spriteImage,
            width: 39,
            height: 50,
            y:5,
            x:0,
            ),
        Sprite.fromImage(
            spriteImage,
            width: 39,
            height: 50,
            y:5,
            x:44,),
         Sprite.fromImage(
            spriteImage,
            width: 39,
            height: 50,
            y:5,
            x:85,),
         Sprite.fromImage(
           spriteImage,
           width: 39,
           height: 50,
           y:5,
           x:129,)


  ],stepTime: 0.2, loop: true));
}
class JumpMole extends SpriteComponent {
  JumpMole(Image spriteImage)
      :super.fromSprite(40, 55, Sprite.fromImage(spriteImage, width: 40, height: 55, y: 0, x: 303));

}