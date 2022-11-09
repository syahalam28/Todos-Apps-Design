import 'package:flutter/material.dart';

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
