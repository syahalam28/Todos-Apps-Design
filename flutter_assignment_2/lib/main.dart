import 'dart:html';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:english_words/english_words.dart';
import './SecondRoute.dart';
import './TravelRoute.dart';
import './DeadlineRoute.dart';
import './Models.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  // =======Widget Crousel==========
  Widget crousle(BuildContext context) {
    final List<Widget> myData = [
      // ======= Indeks 0 ===============
      FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var items = data.data as List<MerchantModel>;
              // return ListView.builder(
              //     itemCount: items == null ? 0 : items.length,
              //     itemBuilder: (context, index) {

              //     });

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DeadineRoute()),
                  );
                },
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Column(
                                    children: [Icon(Icons.lock_clock_outlined)],
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 250),
                                      child: Icon(Icons.more_vert)),
                                ],
                              )),
                          Container(
                              padding:
                                  const EdgeInsets.only(top: 200, left: 20),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 170),
                                        child: Text(
                                            items.length.toString() + " Task"),
                                      ),
                                      Text(
                                        "Deadline Works",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.black26,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blue,
                              ),
                              value: items.length.toDouble() / 10,
                            ),
                          )
                        ],
                      )),
                    ],
                  ),
                  height: 200,
                  width: double.infinity,
                  color: Colors.deepOrange,
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      // ==========Indeks 1=============
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TravelRoute()),
          );
        },
        child: Container(
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Column(
                            children: [Icon(Icons.lock_clock_outlined)],
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 250),
                              child: Icon(Icons.more_vert)),
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.only(top: 200, left: 20),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 170),
                                child: Text("3 Task"),
                              ),
                              Text(
                                "Travel To Japan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.black26,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blue,
                      ),
                      value: 0.2,
                    ),
                  )
                ],
              )),
            ],
          ),
          height: 200,
          width: double.infinity,
          color: Colors.blueGrey,
        ),
      ),
    ];
    return CarouselSlider(
      items: myData,
      carouselController: _controller,
      options: CarouselOptions(
          height: 400.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          viewportFraction: 1,
          enlargeCenterPage: true,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {
            if (index == 0) {
              leading:
              GestureDetector(
                onTap: () {
                  /* Write listener code here */
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back, // add custom icons also
                ),
              );
            }

            setState(() {
              _current = index;
            });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TODO",
          style: TextStyle(fontSize: 26.0),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.search),
          ),
        ],
        elevation: 0.0,
      ),
      // Membuat Menu sidebar
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: NetworkImage(
                    "https://img.freepik.com/free-vector/gradient-mountain-landscape_23-2149152830.jpg?size=626&ext=jpg&ga=GA1.2.1763479514.1667833205&semt=sph",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Text('Flutter - Todo List App'),
            ),
            ListTile(
              title: const Text('Task'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
            ),
            ListTile(
              title: const Text('About'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              //padding kanan-kiri, atas-bawah
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Icon(
                      Icons.account_circle,
                      size: 45.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    //Left Top Right Bott
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 14),
                    child: Text(
                      "Hello, Izaaz Azaam",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                  Text("Hope you all the best!."),
                  Text("Down bellow is your daily to do task."),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: crousle(context),
            )
          ],
        ),
      ),
    );
  }
}
