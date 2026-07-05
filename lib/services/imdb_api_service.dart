import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/imdb_title.dart';
import '../models/imdb_credit.dart';
import '../models/imdb_box_office.dart';

class ImdbApiService {
  static const String baseUrl = 'https://api.imdbapi.dev';

  // Get a specific title
  Future<ImdbTitle> getTitle(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/titles/$id'));
    if (response.statusCode == 200) {
      return ImdbTitle.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load title');
    }
  }

  // Get credits for a title
  Future<List<ImdbCredit>> getTitleCredits(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/titles/$id/credits?pageSize=15'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final credits = jsonResponse['credits'] as List<dynamic>?;
      if (credits != null) {
        return credits.map((c) => ImdbCredit.fromJson(c)).toList();
      }
      return [];
    } else {
      throw Exception('Failed to load credits');
    }
  }

  // Get box office for a title
  Future<ImdbBoxOffice?> getTitleBoxOffice(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/titles/$id/boxOffice'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      // It might return empty object if no box office data
      if (body.isEmpty) return null;
      return ImdbBoxOffice.fromJson(body);
    } else {
      // Box office may not exist, don't throw, just return null
      return null;
    }
  }

  // Browse titles with filters
  Future<List<ImdbTitle>> getTitles({
    List<String> types = const ['MOVIE'],
    String sortBy = 'SORT_BY_POPULARITY',
    String sortOrder = 'DESC',
    int? minVoteCount,
    List<String>? genres,
    String? pageToken,
  }) async {
    var uri = Uri.parse('$baseUrl/titles').replace(queryParameters: {
      'types': types,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
      if (minVoteCount != null) 'minVoteCount': minVoteCount.toString(),
      if (genres != null && genres.isNotEmpty) 'genres': genres,
      if (pageToken != null) 'pageToken': pageToken,
    });

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final titles = jsonResponse['titles'] as List<dynamic>?;
      if (titles != null) {
        return titles.map((t) => ImdbTitle.fromJson(t)).toList();
      }
      return [];
    } else {
      throw Exception('Failed to load titles');
    }
  }

  // Search titles
  Future<List<ImdbTitle>> searchTitles(String query, {int limit = 20}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search/titles').replace(queryParameters: {
        'query': query,
        'limit': limit.toString(),
      }),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final titles = jsonResponse['titles'] as List<dynamic>?;
      if (titles != null) {
        return titles.map((t) => ImdbTitle.fromJson(t)).toList();
      }
      return [];
    } else {
      throw Exception('Failed to search titles');
    }
  }
}
