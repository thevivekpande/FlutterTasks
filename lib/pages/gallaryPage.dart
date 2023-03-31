import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test/modals/photos.dart';
import 'package:test/pages/showImage.dart';
import 'package:test/utils/colors.dart';

class GallaryPage extends StatefulWidget {
  const GallaryPage({super.key});

  @override
  State<GallaryPage> createState() => _GallaryPageState();
}

class _GallaryPageState extends State<GallaryPage> {
  List _photosDetails = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAlbum();
    print(_photosDetails);
  }

  Future<void> fetchAlbum() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      print('success');
      List jsonResponse = json.decode(response.body);
      final data = jsonResponse.map((e) => Photo.fromJson(e)).toList();
      setState(() {
        _photosDetails = data;
      });
    } else {
      throw Exception('Error happened!');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.fromARGB(255, 253, 148, 0), primaryColor],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Gallary'),
          backgroundColor: primaryColor,
        ),
        body: Center(
          child: _isLoading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Container(
                  child: ListView.builder(
                    itemCount: _photosDetails.length,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                        leading: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => ShowImage(
                                      url: _photosDetails[index]!.url))),
                          child: Image.network(
                            _photosDetails[index]!.thumbnailUrl,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          _photosDetails[index]!.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Photo id: ${_photosDetails[index]!.id}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
