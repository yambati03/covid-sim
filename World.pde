class World{
  ArrayList<Env> envs = new ArrayList<Env>();
  Env quarantine;
  
  World(Env quarantine, Env ...envs){
    this.quarantine = quarantine;
    for(Env e : envs){
      this.envs.add(e);
      e.gen_pop();
    }
  }
  
  void show(){
    noFill();
    stroke(200);
    for(Env e : envs){
      e.show();
    }
    quarantine.show();
  }
  
  void update(){
    for(Env e : envs){
      e.update();
    }
    quarantine.update();
  }
  
  void move_to_quarantine(){
    for(Env e : envs){
      for(int i = 0; i < e.people.size(); i++){
        //move infected people to quarantine after q_days * tDay timesteps
        if (do_quarantine && e.people.get(i).t_infected > q_days * tDay){
          e.people.get(i).move(e, quarantine);
          i = i - 1;
          continue;
        }
      }
    }
  }
  
  void show_people(){
    for(Person p : quarantine.people){
      p.show();
      p.update(quarantine);
    }
    for(Env e : envs){
      for(Person p : e.people){
        p.show();
        p.update(e);
      }
    }
  }
  
  int[] getStatistics(){
    int[] total = quarantine.getStatistics();
    for(Env e : envs){
      total = add(total, e.getStatistics());
    }
    return total;
  }
  
  //add two arrays element-wise
  int[] add(int[] first, int[] second){
    int len = first.length < second.length ? first.length : second.length; 
    int[] result = new int[len]; 
    for (int i = 0; i < len; i++) { 
      result[i] = first[i] + second[i]; 
    } 
    return result;
  }
}
