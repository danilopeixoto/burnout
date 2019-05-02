static int globalProcessCount = 0;

abstract class ProcessBuilder {
    public ProcessBuilder() {}
    
    public abstract Process next();
}
