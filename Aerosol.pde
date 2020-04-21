class Aerosol{
  float x, y, radius;
  int t_alive = 0;
  
  Aerosol(float x, float y){
    this.x = x;
    this.y = y;
    this.radius = random(40, 60);
  }

  void show(){
    fill(212, 57, 73, 70);
    stroke(212, 57, 73, 70);
    circle(this.x, this.y, this.radius);
  }
  
  void update(Env e){
    t_alive += 1;
  }
}
