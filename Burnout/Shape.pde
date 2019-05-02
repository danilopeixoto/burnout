abstract class Shape {
    protected PVector anchorPoint;
    
    public Shape() {
        anchorPoint = new PVector(0, 0);
    }
    public Shape(PVector anchorPoint) {
        this.anchorPoint = anchorPoint;
    }
    
    public void setAnchorPoint(PVector anchorPoint) {
        this.anchorPoint = anchorPoint;
    }
    public PVector getAnchorPoint() {
        return anchorPoint;
    }
    
    public abstract void draw();
}
