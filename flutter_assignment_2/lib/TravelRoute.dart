import 'package:flutter/material.dart';

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
