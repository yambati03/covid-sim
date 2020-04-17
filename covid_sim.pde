//global constants
final int pop_size = 250;
final int tDay = 10;
final int infect_radius = 10;
final int q_days = 1;
final int init_infect = 5;
final int num_response = 10;

float p_not_sd = 1.0;
boolean do_hub = false;
boolean do_quarantine = false;
boolean do_travel = true;

//initialize environments and quarantine
Env main1 = new Env(20, 20, 400);
Env main2 = new Env(20, 440, 400);
Env quarantine = new Env(440, 20, 300);
Env central_hub = new Env(440, 440, 200);
World w = new World(quarantine, central_hub, main1);

void do_response(){
  do_quarantine = true;
  do_travel = false;
  p_not_sd = 0.2;
}

void setup() {
  size(760, 460);
  for(int i = 0; i < init_infect; i++){
    main1.people.get((int)random(0, pop_size)).setState(1);
  }
}

void draw() {
  background(0);
  w.show();
  w.update();
  if(do_travel) { w.travel(); }
  if(do_quarantine) { w.move_to_quarantine(); }
  w.show_people();
  //trigger response if number infected goes above specified threshold
  int infected = getStats();
  if(infected > num_response){ 
    //do_response();
  } else if(infected == 0){
    textSize(15);
    fill(59, 168, 82);
    text("DISEASE\nERADICATED", 600, 380); 
  }
  delay(25);
}

int getStats(){
  int[] stats = w.getStatistics();
  textSize(12);
  fill(59, 168, 82);
  text(String.format("healthy       %s", stats[0]), 440, 360);
  fill(212, 57, 73);
  text(String.format("infected      %s", stats[1]), 440, 380);
  fill(255);
  text(String.format("recovered   %s", stats[2]), 440, 400);
  fill(200);
  text(String.format("deceased    %s", stats[3]), 440, 420);
  return stats[1]; //return number infected
}
