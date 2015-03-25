part of tp_exercice_9;

class Board extends Surface {
  var blueCars = new MovablePieces(5);
  var myCar = new MovablePiece(1);
  var big = true;
  
  Board(CanvasElement canvas) : super(canvas) {
    initVehicule(myCar, canvas.width / 2 - myCar.width, canvas.height / 2 - myCar.height, 
        100, 40, "red");
    
    document.onMouseMove.listen((MouseEvent e) {
      myCar.x = e.offset.x - myCar.width  / 2;
      myCar.y = e.offset.y - myCar.height / 2; 
      myCar.move();
    });
    
    document.onMouseDown.listen((MouseEvent e) {
      if (big == false) {
        myCar.width = 100;
        myCar.height = 40;
        myCar.color = "red";
        big = true;
      }
    });
   
    var y = 0;
    blueCars.forEach((car) {
      initVehicule(car, 0, 0, 80, 40, "blue");
      y = y + 2 * car.height;
      car.y = y;
      if (car.y >= (canvas.height - car.height)) {
        car.y = 0;
      }
    });
  }
  
  initVehicule(MovablePiece mp, num y, num x, num width, num height, String color) {
    mp.shape = PieceShape.VEHICLE;
    mp.y = y;
    mp.x = x;
    mp.width = width;;
    mp.height = height;
    mp.space = new Size(canvas.width, canvas.height);
    mp.color = color;
    mp.speed.dx = randomNum(5);
    mp.speed.dy = randomNum(4);
  }
      
  draw() {
    clear();   
    blueCars.forEach((car) {
      car.move();
      blueCars.avoidCollisions(car);
      if (big == true && myCar.hit(car) == true) {
        myCar.width = 20;
        myCar.height = 20;
        myCar.color = "black";
        big = false;
      }          
      drawPiece(car);
    });
    drawPiece(myCar);
  }
}

