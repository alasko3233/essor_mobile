// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/categorie.dart';
import '../model/journal.dart';
import '../model/post.dart';

class EssorService {
  static var baseUrl = Uri.parse("https://lessor.ml/api/");
  // Future<dynamic> getJournal() async {
  //   var client = http.Client();
  //   var uri = Uri.parse('https://lessor.ml/api/getJournal');

  //   var response = await client.get(uri);

  //   if (response.statusCode == 200) {
  //     var json = response.body;
  //     return jsonDecode(json);
  //   } else {
  //     throw Exception("Failed to load data from API");
  //   }
  // }
  // List<Journal> journal = [];

  getJournal() async {
    var client = http.Client();
    var uri = Uri.parse('https://lessor.ml/api/getJournal');

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body.toString());
      var data = Journal.fromJson(json);
      print(data);
      return data;
    } else {
      // Si la requête n'a pas abouti, lancer une exception
      throw Exception('Failed to load journal data');
    }
  }

  getPost(String slug) async {
    var client = http.Client();
    var uri = Uri.parse('https://lessor.ml/api/get-Post/$slug');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body.toString());
      var data = Post.fromJson(json);
      print(data);
      return data;
    } else {
      // Si la requête n'a pas abouti, lancer une exception
      throw Exception('Failed to load journal data');
    }
  }

  getCategorie(String id) async {
    var client = http.Client();
    var uri = Uri.parse('https://lessor.ml/api/getCategorie/$id');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body.toString());
      var data = Categorie.fromJson(json);
      print(data);
      return data;
    } else {
      // Si la requête n'a pas abouti, lancer une exception
      throw Exception('Failed to load journal data');
    }
  }

  Future<Map<String, dynamic>> getArticles() async {
    try {
      var response = await http.get(baseUrl);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'error': 'Failed to load articles'};
      }
    } catch (e) {
      return {'error': 'Failed to load articles'};
    }
  }
}
