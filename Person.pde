class Person {
  private int state; //0 = healthy; 1 = infected; 2 = recovered; 3 = deceased; 4 = incubation
  private int age, infect_radius;
  private float rot, dr, x, y, p_d, p_i;
  private int t_incubated, t_infected = 0;
  private final int tDay = 5;
  
  public Person(int x_min, int x_max, int y_min, int y_max){
    state = 0;
    p_i = 0.2;
    p_d = 0.2;
    infect_radius = 30;
    rot = random(0, 360);
    dr = random(10, 20);
    x = random(x_min, x_max);
    y = random(y_min, y_max);
  }
  
  void p_infect(){
    float r = random(0, 1);
    if(r < p_i){ this.state = 4; }
  }
  
  void setState(int state){
    this.state = state;
  }
  
  int getState(){
    return this.state;
  }
  
  void p_remove(){
    float r = random(0, 1);
    if(r < p_d){ this.state = 3; } else { this.state = 2; }
  }
  
  void infect_neighbors(World w){
    for(Person p : w.people){
        if(p.getState() == 0) {
          float distance = sqrt(pow(p.x - this.x, 2) + pow(p.y - this.y, 2));
          if(distance < this.infect_radius){ p.p_infect(); }
        }
     }
  }
  
  void move(World from, World to){
    to.people.add(this);
    from.people.remove(this);
    x = to.x_min + (to.side / 2); //lerp(x, to.x_min + (to.side / 2), 0.1);
    y = to.y_min + (to.side / 2); //lerp(y, to.y_min + (to.side / 2), 0.1);
  }
  
  void update(World w){
    if(state != 3){
      rot = rot + random(-10, 10);
      float target_x = x + dr * cos(radians(rot));
      float target_y = y + dr * sin(radians(rot));
      x = lerp(x, target_x, 0.1);
      y = lerp(y, target_y, 0.1);
    }
    
    if(!w.is_in_world(this)){
      w.constrain_to_world(this);
    }
    
    switch(state){
      case 4:
        t_incubated = t_incubated + 1;
        if(t_incubated > 14 * tDay) {
          this.state = 1;
        }
        break;
      case 1:
        t_infected = t_infected + 1;
        if(t_infected > 30 * tDay) {
          this.p_remove();
        }
      default:
        break;
    }
  }
  
  void show(){
    if(state == 0){
       stroke(0, 255, 0);
       fill(0, 255, 0); 
    } else if(state == 1){
       stroke(255, 0, 0);
       fill(255, 0, 0);
    } else if(state == 4){
       stroke(255, 255, 0);
       fill(255, 255, 0);
    }  else if(state == 2 || state == 3){
       stroke(100);
       fill(100);
    }
    ellipse(x, y, 10, 10);
  }
}
