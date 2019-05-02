static int globalCPUCount = 0;

abstract class Device extends Shape {
    protected int id;
    protected Process process;
    
    public Device() {
        id = globalCPUCount++;
    }
    
    public int getID() {
        return id;
    }
    public Process getProcess() {
        return process;
    }
    
    public abstract void commit(Process process);
    public abstract void release();
    public abstract void execute();
    
    public abstract boolean isIdle();
    public abstract boolean isInterrupted(int quantum);
}
