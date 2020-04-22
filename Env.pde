class Env{
  private int x_min, x_max, y_min, y_max, side;
  ArrayList<Person> people = new ArrayList<Person>();
  ArrayList<Aerosol> aerosols = new ArrayList<Aerosol>();
  
  Env(int x, int y, int side){
    this.side = side;
    this.x_min = x;
    this.y_min = y;
    this.x_max = x + side;
    this.y_max = y + side;
  }
  
  void gen_pop(){
    for(int i = 0; i < pop_size; i++){
      Person person = new Person(this.x_min, this.x_max, this.y_min, this.y_max);
      this.people.add(person);
    }
  }
  
  void show(){
    noFill();
    stroke(200);
    rect(this.x_min, this.y_min, this.side, this.side);
  }
  
  void update(){
    for(Person p : this.people){
      if(p.getState() == 1 || p.getState() == 4){
         p.infect_neighbors(this);  
      }
    }
    for(Aerosol a : this.aerosols){
      for(Person p : this.people){
        if(p.getState() == 0){ p.a_infect(a); }
      }
    }
  }
  
  boolean is_in_world(Person p){
    if(p.x < x_max && p.x > x_min && p.y < y_max && p.y > y_min){
      return true;
    } else {
      return false;
    }
  }
  
  int[] getStatistics(){
    int[] stats = new int[5];
    stats[0] = stats[1] = stats[2] = stats[3] = stats[4] = 0;
    for(Person p : people){
      switch(p.getState()){
        case 0: //healthy
          stats[0] += 1;
          break;
        case 1: //infected
          stats[1] += 1;
          break;
        case 2: //recovered
          stats[2] += 1;
          break;
        case 3: //deceased
          stats[3] += 1;
          break;
        case 4: //incubation
          stats[4] += 1;
          break;
        default:
          break;
      }
    }
    return stats;
  }
  
  void constrain_to_world(Person p){
    if(p.x > x_max) { 
      p.x = x_max; 
      p.rot = 180;
    }
    if(p.x < x_min) { 
      p.x = x_min;
      p.rot = 0;
    }
    if(p.y > y_max) { 
      p.y = y_max; 
      p.rot = 270;
    }
    if(p.y < y_min) { 
      p.y = y_min; 
      p.rot = 90;
    }
  }
}
