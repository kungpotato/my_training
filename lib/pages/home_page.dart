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
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: [
          const Text(
            'รายการสัตว์',
            style: TextStyle(fontSize: 25),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                children: pokemonList.map((e) => _buildCard(e)).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCard(PokemonModel item) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: SizedBox(
          width: 180,
          height: 180,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.network(item.imgUrl),
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ),
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

  Future<List<PokemonModel>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon'));
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>;
    return results.map((e) => PokemonModel.fromJson(e)).toList();
  }
}
