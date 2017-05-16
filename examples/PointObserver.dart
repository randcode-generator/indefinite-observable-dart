import "../lib/IndefiniteObservable.dart";

class Point {
	Point(double x, double y)
		: this.x = x,
			this.y = y;

	String toString() {
		return "x: ${this.x}, y: ${this.y}";
	}

	double x;
	double y;
}

class PointObserver<T> extends Observer<T> {
  Function n;
  PointObserver(void n(T t)) {
    this.n = n;
  }
  @override
  void next(T value) {
    n(value);
  }
}

class PointObservable<T> extends IndefiniteObservable<PointObserver<T>> {
  PointObservable(Disconnect connect(PointObserver<T> m)) : super(connect);
}

void main() {
	Point point = new Point(50.2, 69.5);
  var po = new PointObservable<Point>((o) {
    o.next(point);
    return () {};
	});
  var s = mo.subscribe(new PointObserver<Point>((o) {
    print(o);
  }));
  s.unsubscribe();
}