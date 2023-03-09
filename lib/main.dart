import 'package:educational_app/views/javatpoint.dart';
import 'package:educational_app/views/w3school.dart';
import 'package:educational_app/views/wikipedia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomePage(),
        'wiki': (context) => const Wikipedia(),
        'w3s': (context) => const W3School(),
        'java': (context) => const JavaPoint(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "E-Learning",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     children: [
      //       Card(
      //         child: ListTile(
      //           title: Text(
      //             "WikiPedia",
      //             style: GoogleFonts.poppins(
      //               fontSize: 18,
      //               fontWeight: FontWeight.w600,
      //             ),
      //           ),
      //           trailing: IconButton(
      //             onPressed: () {
      //               Navigator.of(context).pushNamed('wiki');
      //             },
      //             icon: const Icon(
      //               Icons.arrow_forward_ios_outlined,
      //             ),
      //           ),
      //         ),
      //       ),
      //       Card(
      //         child: ListTile(
      //           title: Text(
      //             "W3School",
      //             style: GoogleFonts.poppins(
      //               fontSize: 18,
      //               fontWeight: FontWeight.w600,
      //             ),
      //           ),
      //           trailing: IconButton(
      //             onPressed: () {
      //               Navigator.of(context).pushNamed('w3s');
      //             },
      //             icon: const Icon(
      //               Icons.arrow_forward_ios_outlined,
      //             ),
      //           ),
      //         ),
      //       ),
      //       Card(
      //         child: ListTile(
      //           title: Text(
      //             "JavatPoint",
      //             style: GoogleFonts.poppins(
      //               fontSize: 18,
      //               fontWeight: FontWeight.w600,
      //             ),
      //           ),
      //           trailing: IconButton(
      //             onPressed: () {
      //               Navigator.of(context).pushNamed('java');
      //             },
      //             icon: const Icon(
      //               Icons.arrow_forward_ios_outlined,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              StaggeredGrid.count(
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('wiki');
                    },
                    child: StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1.5,
                      child: myImageBox(
                        imagePath: "assets/images/wiki.png",
                        imageName: "Wikipedia",
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('w3s');
                    },
                    child: StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1.5,
                      child: myImageBox(
                        imagePath: "assets/images/w3s.jpeg",
                        imageName: "W3School",
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('java');
                    },
                    child: StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1.5,
                      child: myImageBox(
                        imagePath: "assets/images/java.jpg",
                        imageName: "JavaTPoint",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myImageBox({
    required String imagePath,
    required String imageName,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(5),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                imageName,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
