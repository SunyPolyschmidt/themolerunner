import 'dart:ui';
import 'package:flame/game.dart';
import'package:themolerunner/Mole/mole.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:themolerunner/Obstacle/obstacle.dart';
import 'package:themolerunner/TheBackdrop/thebackdrop.dart';
import 'package:themolerunner/TheBackdrop/ground.dart';
import 'dart:math';



enum MoleRunnerStatus{gameOver,playing}
class MoleRunner extends Game with Resizable {

  Mole mole;
  Random rnd;
  int min = 1;
  int max = 3;
  double tileSize;
  Size screenSize;
  int score = 0;
  int timer = 0;
  int seconds = 0;
  int obsAdded = 0;
  int modifier = 2;
  bool col = false;
  List<Obstacle> obstacles;
  Ground floor;
  TheBackdrop bg;
  MoleRunnerStatus status = MoleRunnerStatus.playing;


  MoleRunner({Image spriteImage, String bg}) {
  initialize(spriteImage);
  }

  void render(Canvas canvas) {
    @override
    //Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
     Paint bgPaint = Paint();
     bgPaint.color = Color(0xff576574);
    //canvas.drawRect(bgRect, bgPaint);
    bg.render(canvas);
    floor.render(canvas);
    obstacles.forEach((Obstacle obstacle) => obstacle.render(canvas));
    mole.render(canvas);

  }

  void onTap() {
    if(col == true)
      {
        reset();
        return;
      }
    mole.doJump();
    print(mole.height);
    obstacles.forEach((Obstacle obstacle){
      print(obstacle.getX());
    });

  }

  void update(double t) {
    //print(size);
    if(col == true)
      {
        return;
      }
    bool firstObstacle = false;
    if(mole.screenSize==null) mole.screenSize=size;
    mole.update(t);
    obstacles.forEach((Obstacle obstacle)=>obstacle.update(t));
    timer++;
    if(timer == 60) {
      seconds++;
      timer = 0;
      print(seconds);

    }
    if(seconds % 2 == 0)
      {
        if(seconds > 3 && firstObstacle == false)
          firstObstacle = true;
        if(obsAdded <= 0) {
          if (firstObstacle == true) {
            obsAdded += 1;
            addObstacle();
          }
        }

      }
    else {obsAdded = 0;}

    removeObstacle();
    if(collision())
      {
        gameOver();
      }

  }

  void initialize(Image spriteImage) async{
    bg = TheBackdrop();
    floor = Ground();
    mole = Mole(spriteImage);
    obstacles = List<Obstacle>();
  }

  void addObstacle()
  {
    rnd = new Random();
    //int type = min + rnd.nextInt(max - min);
    int type = 1;
    obstacles.add(Obstacle(type, size.width, size.height/2));
    obsAdded++;
    print("obstacle added");
  }
  void removeObstacle(){
    obstacles.removeWhere((obstacle)=>(obstacle.removable == true));
  }
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }
  void reset(){
    obstacles.clear();
    col = false;
    seconds = 0;
    score = 0;
    mole.reset();
  }
  void gameOver()
  {
    status = MoleRunnerStatus.gameOver;
    mole.status = MoleStatus.end;
  }


  bool collision()
  {
    obstacles.forEach((Obstacle obstacle){
      if(obstacle.getX()> mole.currentMole.width)
        return;
      else{
        if(mole.currentMole.y >= obstacle.getHeight()) {
          col = true;
        }
      }
    });

    return col;
  }
}
