part of tp_exercice_9;

class Board extends Surface {
  var blueCars = new MovablePieces(5);
  var myCar = new MovablePiece(1);
  var y = 0;
  var x = 0;
  var big = true;
  
  Board(CanvasElement canvas) : super(canvas) {
    initVehicule(myCar, 50, 50, canvas.width, canvas.width - 50, canvas.height, canvas.height - 50, "red", 225, 225);
    myCar.move();
  //  myCar.randomInit();
    document.onMouseMove.listen((MouseEvent e) {
      myCar.x = e.offset.x - myCar.width  / 2;
          myCar.y = e.offset.y - myCar.height / 2; 
          myCar.move();
        });
    
    document.onMouseDown.listen((MouseEvent e) {
          if (big == false) {
            myCar.width = 50;
            myCar.height = 100;
            myCar.colorCode = "red";
            big = true;
          }
        });
    
    blueCars.forEach((car) {
      initVehicule(car, 50, 50, canvas.width, canvas.width - 50, canvas.height, canvas.height - 50, "blue", y, x);
      y += 100;
      if (y >= (canvas.height - 50)) {
        y = 0;
        x += 100;
      }
      
      });
    window.animationFrame.then(gameLoop); 
  }
  
    initVehicule(MovablePiece mp, num width, num height, num distanceMinWidth,
                 num distanceMaxWidth, num distanceMinHeight, num distanceMaxHeight, String color, int y, int x) {
      mp.shape = PieceShape.VEHICLE;
      mp.width = width;
      mp.height = height;
      //mp.distanceMinWidth = distanceMinWidth;
      //mp.distanceMaxWidth = distanceMaxWidth;
      //mp.distanceMinHeight = distanceMinHeight;
      //mp.distanceMaxHeight = distanceMaxHeight;
      mp.color = 'black';
      mp.y = y;
      mp.x = x;
      mp.speed = randomNum(5)  + 1;
      print(mp.speed);
    }
      
    gameLoop(num delta) {
      draw();
      window.animationFrame.then(gameLoop);
    }
      
    draw() {
      clear();
      
      blueCars.forEach((car) {
        car.move();
        blueCars.avoidCollisions(car);
        if (big == true && myCar.hit(car) == true) {
          myCar.width = 20;
          myCar.height = 20;
          myCar.colorCode = "black";
          big = false;
        }
          
        drawPiece(car);
      });
      drawPiece(myCar);
    }
 }

