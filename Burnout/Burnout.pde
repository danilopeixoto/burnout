float speed = 1.0;
int seed = 0;
int minimumBurstTime = 5;
int maximumBurstTime = 15;
int quantum = 5;

Scheduler scheduler;
ShortestJobFirstScheduler shortestJobFirstScheduler;
RoundRobinScheduler roundRobinScheduler;

boolean pause = false;

void setup() {
    size(800, 600);
    
    ProcessBuilder processBuilder = new RandomProcessBuilder(seed, minimumBurstTime, maximumBurstTime);
    
    ArrayList<Device> devices = new ArrayList();
    
    devices.add(new CPUDevice());
    devices.add(new CPUDevice());
    
    shortestJobFirstScheduler = new ShortestJobFirstScheduler(processBuilder, devices);
    roundRobinScheduler = new RoundRobinScheduler(processBuilder, devices, quantum);
    
    scheduler = shortestJobFirstScheduler;
}

void draw() {
    background(255);
    
    delay(int(1000 / speed));
    
    if (!pause)
        scheduler.update();
    
    scheduler.draw();
    
    drawMainScreen();
}

void drawMainScreen() {
    pushStyle();
    
    fill(0);
    
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Burnout Scheduler", width / 2.0, 50.0);
    
    textSize(12);
    textAlign(CENTER, CENTER);
    text("Copyright © 2019, Danilo Peixoto and Débora Bacelar. All rights reserved.", width / 2.0, height - 20.0);
    
    textSize(12);
    textAlign(CENTER, CENTER);
    text("OPTIONS", width / 2.0, 440.0);
    
    textSize(12);
    textAlign(LEFT, CENTER);
    text("1 - Add CPU Device\n" +
         "2 - Remove CPU Device\n" +
         "3 - Clear and Release Processes\n" +
         "4 - Switch Scheduler Algorithm (Non-Preemptive Shortest Job First or Round Robin)\n" +
         "5 - Pause/Resume", 10.0, 500.0);
    
    popStyle();
}

void keyPressed() {
    if (key == '1') {
        ArrayList<Device> devices = scheduler.getDevices();
        devices.add(new CPUDevice());
    }
    else if (key == '2') {
        ArrayList<Device> devices = scheduler.getDevices();
        int size = devices.size();
        
        if (size > 0) 
            devices.remove(size - 1);
    }
    if (key == '3') {
        AbstractCollection<Process> collection = scheduler.getCollection();
        collection.clear();
        
        for (Device device : scheduler.getDevices())
            device.release();
    }
    else if (key == '4') {
        scheduler = scheduler.getType() == SchedulerType.ShortestJobFirst ? roundRobinScheduler : shortestJobFirstScheduler;
        
        AbstractCollection<Process> collection = scheduler.getCollection();
        collection.clear();
        
        for (Device device : scheduler.getDevices())
            device.release();
    }
    else if (key == '5')
        pause = !pause;
}
