final class Process extends Shape implements Comparable<Process> {
    private int pid;
    private int burstTime;
    private int executionTime;
    
    public Process() {
        super();
    }
    public Process(int pid, int burstTime) {
        super();
        this.pid = pid;
        this.burstTime = burstTime;
    }
    
    public void setPID(int pid) {
        this.pid = pid;
    }
    public void setBurstTime(int burstTime) {
        this.burstTime = burstTime;
    }
    public int getPID() {
        return pid;
    }
    public int getBurstTime() {
        return burstTime;
    }
    public int getExecutionTime() {
        return executionTime;
    }
    
    public void execute() {
        executionTime++;
    }
    
    @Override
    public int compareTo(Process other) {
        if (burstTime < other.burstTime)
            return -1;
        else if (burstTime > other.burstTime)
            return 1;
        
        return 0;
    }
    
    @Override
    public void draw() {
        float size = 60;
        float textSize = 16;
        
        pushStyle();
        
        noStroke();
        
        fill(220, 220, 220);
        rect(anchorPoint.x, anchorPoint.y, size, size, 8.0);
        
        fill(0, 255, 125);
        rect(anchorPoint.x, anchorPoint.y, size * executionTime / burstTime, size, 8.0);
        
        fill(0);
        textSize(textSize);
        textAlign(CENTER, CENTER);
        text("PID" + String.valueOf(pid) + "\n" + "BT" + String.valueOf(burstTime), anchorPoint.x + size / 2.0, anchorPoint.y + size / 2.0);
        
        popStyle();
    }
}
