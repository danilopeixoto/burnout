import java.util.LinkedList;

final class RoundRobinScheduler extends Scheduler {
    private int quantum;
    
    public RoundRobinScheduler() {
        super(SchedulerType.RoundRobin);
        collection = new LinkedList<Process>();
    }
    public RoundRobinScheduler(ProcessBuilder processBuilder, ArrayList<Device> devices, int quantum) {
        super(processBuilder, devices, SchedulerType.RoundRobin);
        this.quantum = quantum;
        collection = new LinkedList<Process>();
    }
    
    public void setQuantum(int quantum) {
        this.quantum = quantum;
    }
    public int getQuantum() {
        return quantum;
    }
    
    @Override
    protected void update() {
        enqueue(processBuilder.next());
        
        for (Device device : devices) {
            if (device.isInterrupted(quantum)) {
                if (!device.isIdle())
                    enqueue(device.getProcess());
                    
                device.release();
                
                if (hasNext())
                    device.commit(dispatch());
            }
            else {
                if (device.isIdle()) {
                    device.release();
                    
                    if (hasNext())
                        device.commit(dispatch());
                }
                
                device.execute();
            }
        }
    }
    @Override
    protected void enqueue(Process process) {
        collection.add(process);
    }
    @Override
    protected Process dispatch() {
        return ((LinkedList<Process>)collection).poll();
    }
    @Override
    protected boolean hasNext() {
        return !collection.isEmpty();
    }
}
