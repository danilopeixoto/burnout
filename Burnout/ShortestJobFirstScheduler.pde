import java.util.PriorityQueue;

final class ShortestJobFirstScheduler extends Scheduler {
    public ShortestJobFirstScheduler() {
        super(SchedulerType.ShortestJobFirst);
        collection = new PriorityQueue<Process>();
    }
    public ShortestJobFirstScheduler(ProcessBuilder processBuilder, ArrayList<Device> devices) {
        super(processBuilder, devices, SchedulerType.ShortestJobFirst);
        collection = new PriorityQueue<Process>();
    }
    
    @Override
    protected void update() {
        enqueue(processBuilder.next());
        
        for (Device device : devices) {
            if (device.isIdle()) {
                device.release();
                
                if (hasNext())
                    device.commit(dispatch());
            }
            else
                device.execute();
        }
    }
    @Override
    protected void enqueue(Process process) {
        collection.add(process);
    }
    @Override
    protected Process dispatch() {
        return ((PriorityQueue<Process>)collection).poll();
    }
    @Override
    protected boolean hasNext() {
        return !collection.isEmpty();
    }
}
