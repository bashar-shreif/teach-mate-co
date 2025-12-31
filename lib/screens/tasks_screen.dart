import 'package:flutter/material.dart';
import '../data/teach_mate_storage.dart';
import '../models/task.dart';
import '../widgets/new_task.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await TeachMateStorage.instance.tasks.getAll();
    setState(() => _tasks = tasks);
  }

  void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => NewTask(_loadTasks),
    );
  }

  void _deleteTask(id) async {
    await TeachMateStorage.instance.tasks.delete(id);
  }

  @override
  Widget build(BuildContext context) {
    final pendingTasks = _tasks
        .where((t) => t.status == TaskStatus.pending)
        .toList();
    final completedTasks = _tasks
        .where((t) => t.status == TaskStatus.done)
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tasks',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${pendingTasks.length} pending, ${completedTasks.length} completed',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: _openAddTaskOverlay,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Task'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade900,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              'Pending',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),

          ...pendingTasks.map((task) => _buildTaskCard(task, false)).toList(),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              'Completed',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          ...completedTasks.map((task) => _buildTaskCard(task, true)).toList(),
        ],
      ),
    );
  }

  Future<void> _toggleTaskStatus(Task task) async {
    final newStatus = task.status == TaskStatus.done
        ? TaskStatus.pending
        : TaskStatus.done;

    final updatedTask = Task(
      id: task.id,
      description: task.description,
      status: newStatus,
      dueDate: task.dueDate,
      category: task.category,
    );

    await TeachMateStorage.instance.tasks.update(updatedTask);
    await _loadTasks();
  }

  Widget _buildTaskCard(Task task, bool isCompleted) {
    return Dismissible(
      key: ValueKey(task.id),
      onDismissed: (_) => _deleteTask(task.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _toggleTaskStatus(task),
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(
                  isCompleted ? Icons.check_circle : Icons.circle_outlined,
                  color: isCompleted
                      ? Colors.grey.shade600
                      : Colors.grey.shade400,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.description,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isCompleted
                          ? Colors.grey.shade700
                          : Colors.grey.shade900,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          task.category.name,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        task.dueDate.toLocal().toString().split(' ')[0],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
