import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider.dart';

class CharacterDetailPage extends ConsumerWidget {
  final int id;

  const CharacterDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final character = ref.watch(characterDetailProvider(id));

    if (character == null) {
      return const Scaffold(
        body: Center(child: Text("Character not found")),
      );
    }

    final isAlive = character.status.toLowerCase() == "alive";

    return Scaffold(
      body: Stack(
        children: [
          /// 🌌 Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF141E30), Color(0xFF243B55)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// 📜 Scrollable Content
          SingleChildScrollView(
            child: Column(
              children: [
                /// 🖼️ Image + Back Button
                Stack(
                  children: [
                    Hero(
                      tag: character.id,
                      child: Image.network(
                        character.image,
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Positioned(
                      top: 40,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ],
                ),

                /// 📦 Info Card
                Transform.translate(
                  offset: const Offset(0, -40),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 🧑 Name + Status Dot
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                character.name,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.circle,
                              size: 12,
                              color: isAlive ? Colors.green : Colors.red,
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        /// 🎬 Episode Count
                        _chip("Episodes: ${character.episode.length }"),

                        const SizedBox(height: 10),

                        /// 🏷️ Tags
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _chip(character.species),
                            _chip(character.gender),
                            if (character.type.isNotEmpty)
                              _chip(character.type),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// 🌍 Origin
                        _sectionTitle("Origin"),
                        _info(character.originName),

                        const SizedBox(height: 20),

                        /// 🕒 Created
                        _sectionTitle("Created"),
                        _info(character.created),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Chip Widget
  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  /// 🔹 Section Title
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// 🔹 Info Text
  Widget _info(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }
}