import java.util.AbstractCollection;
import java.util.Iterator;

enum SchedulerType {
    ShortestJobFirst,
    RoundRobin
}

abstract class Scheduler extends Shape {
    protected ProcessBuilder processBuilder;
    protected ArrayList<Device> devices;
    protected AbstractCollection<Process> collection;
    protected SchedulerType type;
    
    public Scheduler(SchedulerType type) {
        this.type = type;
    }
    public Scheduler(ProcessBuilder processBuilder, ArrayList<Device> devices, SchedulerType type) {
        this(type);
        this.processBuilder = processBuilder;
        this.devices = devices;
    }
    
    public void setProcessBuilder(ProcessBuilder processBuilder) {
        this.processBuilder = processBuilder;
    }
    public void setDevices(ArrayList<Device> devices) {
        this.devices = devices;
    }
    public ProcessBuilder getProcessBuilder() {
        return processBuilder;
    }
    public ArrayList<Device> getDevices() {
        return devices;
    }
    public AbstractCollection<Process> getCollection() {
        return collection;
    }
    public SchedulerType getType() {
        return type;
    }
    
    protected abstract void update();
    protected abstract void enqueue(Process process);
    protected abstract Process dispatch();
    protected abstract boolean hasNext();
    
    @Override
    public void draw() {
        float spacing = 10.0;
        
        float processOffset = 60.0 + spacing;
        float deviceOffset = 80.0 + spacing;
        
        pushStyle();
    
        fill(0);
        
        textSize(18);
        textAlign(CENTER, CENTER);
        
        switch (type) {
            case ShortestJobFirst:
                text("Shortest Job First", width / 2.0, 85.0);
                break;
            case RoundRobin:
                text("Round Robin", width / 2.0, 85.0);
                break;
            default:
                break;
        }
        
        textSize(18);
        textAlign(LEFT, CENTER);
        
        text("PROCESSES", 10.0, 130.0);
        text("DEVICES", 10.0, 280.0);
        
        popStyle();
        
        int i = 0;
        
        for (Iterator<Process> iterator = collection.iterator(); iterator.hasNext(); i++) {
            Process process = iterator.next();
            
            process.setAnchorPoint(new PVector(spacing + i * processOffset, height / 4.0));
            process.draw();
        }
        
        for (i = 0; i < devices.size(); i++) {
            Device device = devices.get(i);
            
            device.setAnchorPoint(new PVector(spacing + i * deviceOffset, height / 2.0));
            device.draw();
        }
    }
}
