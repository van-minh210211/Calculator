import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String input = "";
  String relust = "";
  List<String> textString = [
    "C",
    "%",
    "⌫",
    "+",
    "7",
    "8",
    "9",
    "-",
    "4",
    "5",
    "6",
    "x",
    "1",
    "2",
    "3",
    "/",
    "⇵",
    "0",
    ".",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
        ),
        body: new Container(
            child: Column(
          children: <Widget>[
            Container(
              color: Colors.blue,
              alignment: Alignment.centerRight,
              child: Text(input,
                  style: new TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Container(
              color: Colors.blue,
              alignment: Alignment.centerRight,
              padding:
                  new EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(relust,
                  style: new TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0),
                  itemCount: textString.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomButon(textString[index]);
                  }),
            ),
          ],
        )));
  }

  Widget CustomButon(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          handtext(text);
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: getButon(text), border: Border.all(color: Colors.black12)),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w700, color: getColor(text)),
        )),
      ),
    );
  }

  getColor(String text) {
    if (text == "C" ||
        text == "%" ||
        text == "⌫" ||
        text == "+" ||
        text == "-" ||
        text == "x" ||
        text == "⇵" ||
        text == "/") {
      return Colors.blue;
    }
    if (text == "=") {
      return Colors.white;
    }
    return Colors.black;
  }

  getButon(String text) {
    if (text == "=") {
      return Colors.blue;
    }
    return Colors.white;
  }

  handtext(String text) {
    if (text == "⌫") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        return;
      }
    }

    if (text == "C") {
      input = "";
      relust = "0";
      return;
    }
    if (text == "=") {
      relust = calculator();

      input = relust;
      if (relust == "") {
        return;
      }
      if (input.endsWith(".0")) {
        input = input.replaceAll(".0", "");
      }
      if (relust.endsWith(".0")) {
        relust = relust.replaceAll(".0", "");
        return;
      }
    }
    input = input + text;
  }

  String calculator() {
    input = input.replaceAll("x", "*");
    try {
      var exp = Parser().parse(input);
      var value = exp.evaluate(EvaluationType.REAL, ContextModel());
      return value.toString();
    } catch (e) {
      return "";
    }
  }
}
