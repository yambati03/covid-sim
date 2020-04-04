//global constants
final int pop_size = 200;
final int tDay = 5;
final int infect_radius = 30;
final int q_days = 2;

World world = new World(20, 20, 540);
World quarantine = new World(580, 20, 300);

void setup() {
  size(900, 600);
  world.gen_pop();
}

void draw() {
  background(0);
  quarantine.show();
  quarantine.update();
  world.show();
  world.update();
  for(Person p : quarantine.people){
    p.show();
    p.update(quarantine);
  }
  for(int i = 0; i < world.people.size(); i++){
    //move infected people to quarantine after q_days * tDay timesteps
    if (world.people.get(i).t_infected > q_days * tDay){
      world.people.get(i).move(world, quarantine);
      i = i - 1;
      continue;
    }
    world.people.get(i).show();
    world.people.get(i).update(world);
  }
  printStats();
  delay(25);
}

void printStats(){
  int[] stats = add(world.getStatistics(), quarantine.getStatistics());
  System.out.printf("healthy: %s, recovered: %s, deceased: %s \n", stats[0], stats[1], stats[2]);
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

void keyPressed() {
  int keyIndex = -1;
  if (key >= 'A' && key <= 'Z') {
    keyIndex = key - 'A';
  } else if (key >= 'a' && key <= 'z') {
    keyIndex = key - 'a';
  }
  if (keyIndex == -1) {
    background(0);
  } else if(keyIndex == 8){ 
    //infect a random person in the population
    world.people.get((int)random(0, pop_size)).setState(1);
  } else {
    println(keyIndex);
  }
}
