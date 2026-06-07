public class TriangoloRettangolo extends FiguraGeometrica{
    public double base;
    public double altezza;

    public TriangoloRettangolo(double base, double altezza){
        this.base = base;
        this.altezza = altezza;
    }

    public double getBase() {
        return base;
    }

    public double getAltezza() {
        return altezza;
    }

    public void setBase(double base) {
        this.base = base;
    }

    public void setAltezza(double altezza) {
        this.altezza = altezza;
    }

    public double ipotenusa(double base, double altezza){
        double ipo =  Math.sqrt((altezza*altezza)+(base*base));
        return ipo;
    }

    @Override
    public double area() throws InvalidShapeException {
        if(base > 0 || altezza > 0) {
            double A = (base * altezza)/2;
            return A;
        } else throw new InvalidShapeException("[Attenzione] la dimensione della base e dell'altezza non può essere uguale a zero");
    }

    @Override
    public double perimetro() throws InvalidShapeException {
        if(base > 0 || altezza > 0) {
            double A = base+altezza+ipotenusa(base,altezza);
            return A;
        } else throw new InvalidShapeException("[Attenzione] la dimensione della base e dell'altezza non può essere uguale a zero");
    }
}
