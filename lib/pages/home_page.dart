import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/models/pokemon_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PokemonModel> pokemonList = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: pokemonList
            .map((e) => ListTile(
                  title: Text(e.name),
                  leading: Image.network(e.imgUrl),
                ))
            .toList(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final data = await fetchData();
      setState(() {
        pokemonList = data; // re render
      });
    });
  }

  fetchData() async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon'));
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>;
    return results.map((e) => PokemonModel.fromJson(e)).toList();
  }
}
