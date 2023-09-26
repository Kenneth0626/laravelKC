import 'package:flutter/material.dart';
import 'package:mobile/loading.dart';
import 'package:mobile/provider/post_provider.dart';
import 'package:provider/provider.dart';
// import 'package:mobile/components/hello_world.dart';
// import 'package:mobile/pages/pageNumber/page_one.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (context) => PostProvider(),

      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.grey,
          primaryColorLight: Colors.grey[200],
          disabledColor: Colors.grey[300],
          indicatorColor: Colors.grey[400],
          highlightColor: Colors.blue[300],
          cardColor: Colors.blue[100],
          scaffoldBackgroundColor: Colors.cyanAccent,
          shadowColor: Colors.black,
        ),
        home: const FirstOpen(),
      ),
      
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
