import 'package:flutter/material.dart';
import '../data/teach_mate_storage.dart';
import '../models/section.dart';
import '../models/user.dart';

class NewSection extends StatefulWidget {
  final int courseId;
  final VoidCallback onSectionAdded;

  const NewSection({
    super.key,
    required this.courseId,
    required this.onSectionAdded,
  });

  @override
  State<NewSection> createState() => _NewSectionState();
}

class _NewSectionState extends State<NewSection> {
  final _nameController = TextEditingController();
  List<User> _instructors = [];
  User? _selectedInstructor;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInstructors();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadInstructors() async {
    try {
      final instructors = await TeachMateStorage.instance.users.getAll();
      setState(() {
        _instructors = instructors;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Invalid Input'),
            content: Text(
              'Error loading instructors: $e',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      }
    }
  }

  Future<void> _submit() async {
    if (_nameController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text(
            'Please make sure you enter a section name',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );

      return;
    }

    try {
      final section = Section(
        name: _nameController.text.trim(),
        courseId: widget.courseId,
      );

      await TeachMateStorage.instance.sections.insert(section);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Section added successfully'),
            backgroundColor: Colors.green.shade600,
          ),
        );
      }

      widget.onSectionAdded();
      Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding section: $e'),
            backgroundColor: Colors.red.shade400,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          24,
          24,
          MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add New Section',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade900,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close, color: Colors.grey.shade600),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Text(
              'Section Name',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'e.g., Section A',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade900, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Instructor (Optional)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            if (_isLoading)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<User?>(
                    value: _selectedInstructor,
                    isExpanded: true,
                    hint: Text(
                      'Select an instructor',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey.shade600,
                    ),
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade900),
                    items: [
                      DropdownMenuItem<User?>(
                        value: null,
                        child: Text(
                          'No instructor assigned',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ),
                      ..._instructors.map((instructor) {
                        return DropdownMenuItem<User?>(
                          value: instructor,
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 16,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 8),
                              Text(instructor.name),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                    onChanged: (val) {
                      setState(() => _selectedInstructor = val);
                    },
                  ),
                ),
              ),
            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade900,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Add Section',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
