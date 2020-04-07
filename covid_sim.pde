//global constants
final int pop_size = 200;
final int tDay = 5;
final int infect_radius = 30;
final int q_days = 2;
final boolean do_quarantine = true;
final boolean travel = true;

Env main1 = new Env(20, 20, 540);
Env main2 = new Env(20, 600, 540);
Env quarantine = new Env(580, 20, 300);
World w = new World(quarantine, main1, main2);

void setup() {
  size(900, 1200);
}

void draw() {
  background(0);
  w.show();
  w.update();
  if(travel) { w.travel(); }
  if(do_quarantine) { w.move_to_quarantine(); }
  w.show_people();
  printStats();
  delay(25);
}

void printStats(){
  int[] stats = w.getStatistics();
  System.out.printf("healthy: %s, recovered: %s, deceased: %s \n", stats[0], stats[1], stats[2]);
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
    main1.people.get((int)random(0, pop_size)).setState(1);
    main2.people.get((int)random(0, pop_size)).setState(1);
  } else {
    println(keyIndex);
  }
}
