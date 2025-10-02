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
  List imageList = [
    'https://plus.unsplash.com/premium_photo-1699210579032-a071593b44db?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1674886270935-bf16a0b15daa?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1674886271082-01dcc2e05375?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1674886271428-9e25ff55aae2?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1699708592737-3ea087278fd9?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1699708592731-49fca14da7d0?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
  ];

  List people = [
    {"name": "Alice", "surname": "Smith", "age": 25},
    {"name": "Bob", "surname": "Johnson", "age": 30},
    {"name": "Charlie", "surname": "Brown", "age": 22},
    {"name": "Diana", "surname": "Miller", "age": 28},
    {"name": "Ethan", "surname": "Taylor", "age": 35},
  ];

  int get counter => _counter;

  void add() {
    if(_counter < imageList.length - 1){
      _counter++;
    }else{
      _counter = 0;
    };

    notifyListeners();
  }

  void subtract() {
    if(_counter > 0){
      _counter--;
    }else{
      _counter = imageList.length - 1;
    };

    notifyListeners();
  }

  void randomWord(){
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
      body: SingleChildScrollView( 
        child: Column(
          // color: Colors.blue[200],
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
            // FloatingActionButton(
            //   onPressed: () {
            //     appState.randomWord();
            //   },
            //   child: const Icon(Icons.add), // The icon displayed on the button
            // ),
            Image.asset(
              'assets/me.jpg',
              fit: BoxFit.cover, // optional
            ),
            SizedBox(height: 20),
            Image(
              image: NetworkImage(appState.imageList[appState._counter])
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(
                  Icons.favorite,
                  color: Colors.pink,
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
                Icon(
                  Icons.audiotrack,
                  color: Colors.green,
                  size: 30.0,
                ),
                Icon(
                  Icons.beach_access,
                  color: Colors.blue,
                  size: 36.0,
                  //                 onPressed: () {
                  //   console.log('hii ther');
                  // },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    appState.subtract();
                  }, 
                  label: Text('Back'),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // 👈 keeps button compact
                    children: [
                      Text('Next'), // text first
                      SizedBox(width: 6), // space between text and icon
                      Icon(Icons.arrow_forward), // icon last
                    ],
                  ),
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
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 400, // give it some fixed height
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: appState.imageList.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      appState.imageList[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: appState.people.map((person) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(person["name"][0]), // first letter of the name
                    ),
                    title: Text("${person["name"]} ${person["surname"]}"),
                    subtitle: Text("Age: ${person["age"]}"),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appState.randomWord();
        },
        child: const Icon(Icons.accessible_forward_rounded),
      ),

      // ✅ POSITION IT (bottom right)
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  
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