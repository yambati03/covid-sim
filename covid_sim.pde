//global constants
//number of people in each environment
final int pop_size = 200;
//timestep
final int tDay = 10;
//radius of infection
final int infect_radius = 20;
//days before infected person is quarantined
final int q_days = 2;
//how many people to infect with the "i" key
final int init_infect = 5;
//threshold cases for response
final int num_response = 20;
//aerosol circle lifetime
final int a_lifetime = 5;

float p_not_sd = 1.0;
boolean did_response = false;
boolean show_eradicated = false;

boolean do_hub = false;
boolean do_quarantine = false;
boolean do_travel = false;
boolean do_aerosols = true;

PrintWriter output;

//initialize environments and quarantine
Env main1 = new Env(20, 20, 400);
Env main2 = new Env(20, 440, 400);
Env quarantine = new Env(440, 20, 300);
//construct world with intialized environments
World w = new World(quarantine, main1);

//start quarantining, 
void do_response(){
  do_quarantine = true;
  do_travel = false;
  p_not_sd = 0.2;
  do_aerosols = false;
}

//ease up
void no_response(){
  do_travel = true;
  p_not_sd = 1.0;
}

void setup() {
  size(760, 440);
  output = createWriter("data.csv"); 
}

void draw() {
  background(0);
  w.show();
  w.update();
  if(do_travel) { w.travel(); }
  if(do_quarantine) { w.move_to_quarantine(); }
  w.show_people();
  if(do_aerosols){
    w.show_aerosols();
    w.remove_aerosols();
  }
  //trigger response if number infected goes above specified threshold
  int infected = getStats();
  if(infected > num_response && !did_response){ 
    do_response();
    did_response = !did_response;
  } else if(infected == 0 && show_eradicated){
    textSize(15);
    fill(59, 168, 82);
    text("DISEASE\nERADICATED", 600, 380); 
  }
  delay(25);
}

//write stats at each iteration to text file
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
  output.println(stats[0] + ", " + (stats[1] + stats[4]) + ", " + stats[2] + ", " + stats[3]); 
  return stats[1]; //return number infected
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
    main1.people.get((int)random(0, main1.people.size())).setState(1);
    main1.people.get((int)random(0, main1.people.size())).setState(1);
    show_eradicated = true;
  } else if(keyIndex == 13){ 
    no_response();
  } else if(keyIndex == 22){
    output.flush();
    output.close();
    exit(); 
  } else {
    println(keyIndex);
  }
}
