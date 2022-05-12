import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tests_demo/models/album_model.dart';
import 'fetch_album_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group("FetchAlbum", () {
    // *Tests for 200 [OK] response
    test(
      "returns an album if the http call completes successfully",
      () async {
        final client = MockClient();
        when(
          client.get(
            Uri.parse("https://jsonplaceholder.typicode.com/albums/1"),
          ),
        ).thenAnswer(
          (realInvocation) async =>
              http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200),
        );
        expect(await fetchAlbum(client), isA<Album>());
      },
    );
  });

  test(
    "Throws and execption if the call completes with an error",
    () async {
      final client = MockClient();
      when(
        client.get(
          Uri.parse("https://jsonplaceholder.typicode.com/albums/1"),
        ),
      ).thenAnswer((realInvocation) async => http.Response('Not Found', 404));
      expect(fetchAlbum(client), throwsException);
    },
  );
}

Future<Album> fetchAlbum(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
