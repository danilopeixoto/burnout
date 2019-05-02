import java.util.Random;

final class RandomProcessBuilder extends ProcessBuilder {
    private int seed;
    private int minimumBurstTime;
    private int maximumBurstTime;
    private Random random;
    
    public RandomProcessBuilder() {
        random = new Random();
    }
    public RandomProcessBuilder(int seed, int minimumBurstTime, int maximumBurstTime) {
        this();
        this.seed = seed;
        this.minimumBurstTime = minimumBurstTime;
        this.maximumBurstTime = maximumBurstTime;
    }
    
    public void setSeed(int seed) {
        this.seed = seed;
        random.setSeed(seed);
    }
    public void setMinimumBurstTime(int minimumBurstTime) {
        this.minimumBurstTime = minimumBurstTime;
    }
    public void setMaximumBurstTime(int maximumBurstTime) {
        this.maximumBurstTime = maximumBurstTime;
    }
    public int getSeed() {
        return seed;
    }
    public int getMinimumBurstTime() {
        return minimumBurstTime;
    }
    public int getMaximumBurstTime() {
        return maximumBurstTime;
    }
    
    @Override
    public Process next() {
        return new Process(globalProcessCount++, int(minimumBurstTime + (maximumBurstTime - minimumBurstTime) * random.nextFloat()));
    }
}
