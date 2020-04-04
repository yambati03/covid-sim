World world = new World(20, 20, 540);
World quarantine = new World(580, 20, 200);

void setup() {
  size(800, 600);
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
    if (world.people.get(i).t_infected > 15){
      world.people.get(i).move(world, quarantine);
      i = i - 1;
      continue;
    }
    world.people.get(i).show();
    world.people.get(i).update(world);
  }
  int[] stats = world.getStatistics();
  System.out.printf("healthy: %s, recovered: %s, deceased: %s \n", stats[0], stats[1], stats[2]);
  delay(25);
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
    world.people.get((int)random(0, 200)).setState(1);
  } else {
    println(keyIndex);
  }
}
