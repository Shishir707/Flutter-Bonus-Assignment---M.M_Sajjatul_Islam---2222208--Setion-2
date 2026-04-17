import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String docId;
  final String title;
  final String subtitle;
  final IconData? icon;
  final VoidCallback? onTap;

  const TaskCardWidget({
    super.key,
    required this.docId,
    required this.title,
    required this.subtitle,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        leading: icon != null ? Icon(icon) : const Icon(Icons.task),

        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed:
              onTap ??
              () async {
                await FirebaseFirestore.instance
                    .collection('task')
                    .doc(docId)
                    .delete();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Task deleted successfully!,",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
        ),
      ),
    );
  }
}
