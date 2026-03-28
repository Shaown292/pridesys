import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider.dart';

class EditCharacterPage extends ConsumerStatefulWidget {
  final int id;

  const EditCharacterPage({super.key, required this.id});

  @override
  ConsumerState<EditCharacterPage> createState() =>
      _EditCharacterPageState();
}

class _EditCharacterPageState
    extends ConsumerState<EditCharacterPage> {
  final nameController = TextEditingController();
  final statusController = TextEditingController();
  final speciesController = TextEditingController();
  final typeController = TextEditingController();
  final genderController = TextEditingController();
  final originController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final c = ref.read(characterDetailProvider(widget.id));

    if (c != null) {
      nameController.text = c.name;
      statusController.text = c.status;
      speciesController.text = c.species;
      typeController.text = c.type;
      genderController.text = c.gender;
      originController.text = c.originName;
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.read(repositoryProvider);
    final character = ref.watch(characterDetailProvider(widget.id));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Character"),
        centerTitle: true,
      ),
      body: character == null
          ? const Center(child: Text("Character not found"))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔥 Avatar
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(character.image),
            ),
            const SizedBox(height: 16),

            /// Name
            _sectionCard(
              title: "Basic Info",
              children: [
                _field("Name", nameController),
                _field("Status", statusController),
                _field("Species", speciesController),
              ],
            ),

            const SizedBox(height: 16),

            /// Extra Info
            _sectionCard(
              title: "Additional Info",
              children: [
                _field("Type", typeController),
                _field("Gender", genderController),
                _field("Origin", originController),
              ],
            ),

            const SizedBox(height: 24),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final c =
                  ref.read(characterDetailProvider(widget.id));
                  if (c == null) return;

                  final updated = c.copyWith(
                    name: nameController.text,
                    status: statusController.text,
                    species: speciesController.text,
                    type: typeController.text,
                    gender: genderController.text,
                    originName: originController.text,
                  );

                  await repo.updateCharacter(updated);

                  ref.invalidate(characterListProvider);
                  ref.invalidate(
                      characterDetailProvider(widget.id));

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}