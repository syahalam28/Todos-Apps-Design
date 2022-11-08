import 'dart:html';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:english_words/english_words.dart';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

final List bulan = [
  "Januari",
  "Fabruari",
  "Maret",
  "April",
  "Mei",
  "Juni",
  "Juli",
  "Agustus",
  "September",
  "Oktober",
  "November",
  "Desember"
];

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
                              value: 0.8,
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

// Class About
class SecondRoute extends StatelessWidget {
  final double coverHeight = 200;
  final double profileHeight = 80;

  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Me'),
        leading: GestureDetector(
          onTap: () {
            /* Write listener code here */
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back, // add custom icons also
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          builContent(),
        ],
      ),
    );
  }

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: builCoverImage(),
        ),
        Positioned(
          top: top,
          child: builProfileImage(),
        ),
      ],
    );
  }

  Widget builCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          'https://img.freepik.com/free-photo/beautiful-scenery-rock-formations-by-sea-queens-bath-kauai-hawaii-sunset_181624-36857.jpg?size=626&ext=jpg&ga=GA1.2.1763479514.1667833205&semt=sph',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget builProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: const NetworkImage(
            'https://img.freepik.com/free-vector/cute-boy-holding-indonesian-flag-cartoon-vector-icon-illustration-people-holiday-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-3820.jpg?size=338&ext=jpg&ga=GA1.2.1763479514.1667833205&semt=sph'),
      );

  Widget builContent() => Column(
        children: const [
          SizedBox(height: 8),
          Text(
            "To Do List App",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
          Text(
            "About",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: TextStyle(fontSize: 12, color: Colors.white),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      );
}

// Class Travel To Japan
class TravelRoute extends StatelessWidget {
  final double coverHeight = 200;
  final double profileHeight = 80;

  const TravelRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel To Japan'),
        leading: GestureDetector(
          onTap: () {
            /* Write listener code here */
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back, // add custom icons also
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          builContent(),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 900),
            child: _buildSuggestions(),
          )
        ],
      ),
    );
  }

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: builCoverImage(),
        ),
      ],
    );
  }

  Widget builCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          'https://img.freepik.com/free-vector/japanese-temple-surrounded-by-nature_52683-46009.jpg?size=626&ext=jpg&ga=GA1.2.1763479514.1667833205&semt=sph',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget builContent() => Column(
        children: const [
          Padding(
            padding: EdgeInsets.only(right: 150),
            child: Text(
              "Travel to Japan",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 25),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 120, top: 20),
            child: Text(
              "2021-11-11 08:12:30--till--2021-11-21 08:12:30",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 10,
                backgroundColor: Colors.blueGrey,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "Holiday Vacation Trip to Japan finding best foodies and make some vlog for youtube channel",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 250, top: 20),
            child: Text(
              "List Of Tasks",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      );

  Widget _buildSuggestions() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
              onLongPress: () {
                final snackBar = SnackBar(
                  content: const Text('Edit Jadwal'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              onTap: () {
                final snackBar = SnackBar(
                  content: const Text('Tidak Ada Jadwal Bulan Ini'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              title: Text(bulan[index], style: TextStyle(fontSize: 30)),
              subtitle: Text('Lihat Jadwal Bulan ' + bulan[index]),
              leading: CircleAvatar(
                child: Text(bulan[index][0], // ambil karakter pertama text
                    style: TextStyle(fontSize: 20)),
              )),
        );
      },
      itemCount: bulan.length,
    );
  }
}

// Class Deadline
class DeadineRoute extends StatelessWidget {
  final double coverHeight = 200;
  final double profileHeight = 80;

  const DeadineRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Deadline Work'),
          leading: GestureDetector(
            onTap: () {
              /* Write listener code here */
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back, // add custom icons also
            ),
          ),
        ),
        body: Container(
          color: Color.fromARGB(255, 43, 42, 42),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              buildTop(),
              builContent(),
              buildParse(context),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 400),
                child: buildParse(context),
              )
            ],
          ),
        ));
  }

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: builCoverImage(),
        ),
      ],
    );
  }

  Widget builCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          'https://img.freepik.com/free-vector/business-woman-is-holding-her-hair-stress-during-work-hand-drawn-style-vector-design-illustrations_1150-39771.jpg?size=626&ext=jpg&ga=GA1.2.1763479514.1667833205&semt=sph',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget builContent() => Column(
        children: const [
          Padding(
            padding: EdgeInsets.only(right: 150),
            child: Text(
              "Deadline Work",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 25),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 120, top: 20),
            child: Text(
              "2021-11-11 08:12:30--till--2021-11-21 08:12:30",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 10,
                backgroundColor: Colors.blueGrey,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Odit, adipisci Unde aliquam, molestiae ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 250, top: 20),
            child: Text(
              "List Of Tasks",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      );

  Widget buildParse(BuildContext context) {
    return FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as List<MerchantModel>;
            return ListView.builder(
                itemCount: items == null ? 0 : items.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          child: InkWell(
                              onLongPress: () {
                                final snackBar = SnackBar(
                                  content: const Text('Edit Action'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );

                                // Find the ScaffoldMessenger in the widget tree
                                // and use it to show a SnackBar.
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              onTap: () {
                                final snackBar = SnackBar(
                                  content: const Text('Checked Action'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );

                                // Find the ScaffoldMessenger in the widget tree
                                // and use it to show a SnackBar.
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    child: Image(
                                      image: NetworkImage(
                                          items[index].image.toString()),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.only(bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: Text(
                                                items[index].name.toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: Text(
                                                  '${items[index].address.toString()} ${items[index].address.toString()}'),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ))));
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

// Model Merchant Json Data Untuk Deadline Class
class MerchantModel {
  int? id;
  String? name;
  String? address;
  double? long;
  double? lat;
  String? image;

  MerchantModel(
      {this.id, this.name, this.address, this.long, this.lat, this.image});

  MerchantModel.fromJson(Map<String, dynamic> json) {
    id = json['merchantId'];
    name = json['merchantName'];
    address = json['merchantAddress'];
    long = double.parse(json['long']);
    lat = double.parse(json['lat']);
    image = json['image'];
  }
}

Future<List<MerchantModel>> ReadJsonData() async {
  final jsondata = await rootBundle.loadString('assets/data/merchant.json');
  final List<dynamic> list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => MerchantModel.fromJson(e)).toList();
}
