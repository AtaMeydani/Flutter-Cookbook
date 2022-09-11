import 'dart:convert';

import 'package:chapter_08/pizza.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'httphelper.dart';
import 'pizza_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int appCounter = 0;
  final storage = const FlutterSecureStorage();
  final myKey = 'myPass';
  final pwdController = TextEditingController();
  String myPass = '';

  @override
  void initState() {
    super.initState();
    readAndWritePreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PizzaDetail(
                isNew: false,
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('You have opened the app $appCounter times.'),
              ElevatedButton(
                onPressed: () {
                  deletePreference();
                },
                child: const Text('Reset counter'),
              ),
              FutureBuilder(
                  // future: readJsonFile(),
                  future: callPizzas(),
                  builder: (BuildContext context, AsyncSnapshot<List<Pizza>> pizzas) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: pizzas.data?.length ?? 0,
                          itemBuilder: (BuildContext context, int position) {
                            return Dismissible(
                              key: Key(position.toString()),
                              onDismissed: (item) {
                                HttpHelper helper = HttpHelper();
                                pizzas.data?.removeWhere((element) => element.id == pizzas.data![position].id);
                                helper.deletePizza(pizzas.data?[position].id);
                              },
                              child: ListTile(
                                title: Text(pizzas.data![position].pizzaName!),
                                subtitle: Text('${pizzas.data![position].description!} - \$ ${pizzas.data![position].price}'),
                              ),
                            );
                          }),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  void readAndWritePreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    appCounter = preferences.getInt('appCounter') ?? 0;
    appCounter++;
    await preferences.setInt('appCounter', appCounter);
    setState(() {});
  }

  void deletePreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    setState(() {
      appCounter = 0;
    });
  }

  Future writeToSecureStorage() async {
    await storage.write(key: myKey, value: pwdController.text);
  }

  Future<String?> readFromSecureStorage() async {
    String? secret = await storage.read(key: myKey);
    return secret;
  }

  Future<List<Pizza>> callPizzas() async {
    HttpHelper helper = HttpHelper();
    List<Pizza> pizzas = await helper.getPizzaList();
    return pizzas;
  }

  String convertToJson(List<Pizza> pizzas) {
    String json = '[';
    for (var pizza in pizzas) {
      json += jsonEncode(pizza);
    }
    json += ']';
    return json;
  }

  Future<List<Pizza>> readJsonFile() async {
    String myString = await DefaultAssetBundle.of(context).loadString('assets/pizzalist.json');
    List myMap = jsonDecode(myString);
    List<Pizza> myList = [];
    for (var pizza in myMap) {
      Pizza newPizza = Pizza.fromJsonOrNull(pizza);
      if (newPizza.id != null) {
        myList.add(newPizza);
      }
    }

    return myList;
  }
}
