import 'package:flutter/material.dart';
import './Models.dart';

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
