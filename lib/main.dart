import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var name = 'Neo';
  int _counter = 0;
  var imageList = [
    'https://plus.unsplash.com/premium_photo-1699210579032-a071593b44db?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1674886270935-bf16a0b15daa?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1674886271082-01dcc2e05375?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1674886271428-9e25ff55aae2?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1699708592737-3ea087278fd9?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1699708592731-49fca14da7d0?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
  ];

  int get counter => _counter;

  void add() {
    if(_counter < imageList.length - 1){
      _counter++;
    }else{
      _counter = 0;
    };

    current = WordPair.random();
    notifyListeners();
  }

  void subtract() {
    if(_counter > 0){
      _counter--;
    }else{
      _counter = imageList.length - 1;
    };

    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    // final List<String> menuItems = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Top Nav'),
        centerTitle: true,
        backgroundColor: Colors.red[200]
      ),
      body: Column(
        children: [
          Text('${appState._counter}. ${pair.asLowerCase}'), 
          Text(
            "${appState.name}'s App",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.green[200]
            )
          ),
          BigCard(pair: pair),
          Image(
            image: NetworkImage(appState.imageList[appState._counter])
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  appState.subtract();
                }, 
                child: Text('Back'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[400], // Background color
                    foregroundColor: Colors.white, // Text/icon color
                    shape: RoundedRectangleBorder( // Rounded corners
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding
                    elevation: 5, // Shadow elevation
                  ),
              ),
              SizedBox(width: 16), // <-- Add space here (16px)
              OutlinedButton(
                onPressed: () {
                  appState.add();
                },
                child: Text('Next'),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green[400], // Text/icon color
                    shape: RoundedRectangleBorder( // Rounded corners
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding
                    elevation: 5, // Shadow elevation
                  ),
              ),
            ],
          )
    
          // PopupMenuButton<String>(
          //   onSelected: (String result) {
          //     // Handle menu item selection
          //     print('You selected $result');
          //   },
          //   itemBuilder: (BuildContext context) {
          //     return menuItems.map((String item) {
          //       return PopupMenuItem<String>(
          //         value: item,
          //         child: Text(item),
          //       );
          //     }).toList();
          //   },
          // ),
          
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pair});

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asLowerCase),
      ),
    );
  }
}