final class CPUDevice extends Device {
    public CPUDevice() {
        super();
    }
    
    @Override
    public void commit(Process process) {
        this.process = process;
        execute();
    }
    @Override
    public void release() {
        this.process = null;
    }
    @Override
    public void execute() {
        process.execute();
    }
    
    @Override
    public boolean isIdle() {
        if (process == null)
            return true;
        
        return process.getExecutionTime() >= process.getBurstTime();
    }
    @Override
    public boolean isInterrupted(int quantum) {
        if (process == null)
            return true;
        
        return process.getExecutionTime() % quantum == 0;
    }
    
    @Override
    public void draw() {
        float padding = 20;
        float size = 60 + padding;
        float textSize = 16;
        
        pushStyle();
        
        noFill();
        
        stroke(0);
        strokeWeight(2.0);
        
        rect(anchorPoint.x, anchorPoint.y, size, size, 8.0);
        
        fill(0);
        textSize(textSize);
        textAlign(CENTER, CENTER);
        text("CPU" + String.valueOf(id), anchorPoint.x + size / 2.0, anchorPoint.y + size + textSize);
        
        popStyle();
        
        float halfPadding = padding / 2.0;
        PVector position = new PVector(anchorPoint.x + halfPadding, anchorPoint.y + halfPadding);
        
        if (process != null) {
            process.setAnchorPoint(position);
            process.draw();
        }
    }
}
