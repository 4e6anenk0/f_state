import 'package:f_state/f_state.dart';

/* 
example:

String => Option[String] //stringToNonEmptyString
          String => Option[Int] //stringToNumber

*/

// simple function
int increment(int value) => value + 1;
String toStr(int value) => value.toString();

// monad function
Value<num> monadicIncrement(num x) {
  return Value(x + 1);
}

Value<num> monadicInverse(num x) {
  if (x == 0) {
    return Value(0);
  } else {
    return Value(1 / x);
  }
}

// monad function
Value<String> monadicToStr(num x) {
  return Value('$x');
}

FState badMonadicIncrement(num x) {
  return FState();
}

/* 
MetaFunc monadicInverse(num value) {
  if (num == 0) {
    return (_) => Nothing();
  }
  return (value) => Value(1 / value);
} */

void main() {
  Value value = Value(10);
  Pipeline pipeline = Pipeline();
  /* pipeline
      .bind(monadicIncrement)
      .bind(monadicIncrement)
      .bind(monadicInverse)
      .bind(monadicToStr)
      .bind(monadicIncrement); // Error bind !!! */

  /* pipeline
      .bind(monadicIncrement)
      .bind(monadicIncrement)
      .bind(badMonadicIncrement); // Error bind !!! */

  /* pipeline
      .bind(monadicIncrement)
      .bind(monadicToStr)
      .bind(monadicIncrement); // Error bind !!! */

  var p = Pipeline<int, String>(func: (int x) => Value<String>(x.toString()))
      .bind((String x) => Value<bool>(x.length > 5));

  var badP = Pipeline()
      .bind((int x) => Value<String>(x.toString()))
      .bind((String x) => Value<bool>(x.length > 5))
      .bind((int x) => Value<String>(x.toString()));

  var result = p.produce(123);
  print(result.extract()); // Output: false

  //print(pipeline.produce(value).extract());
}
