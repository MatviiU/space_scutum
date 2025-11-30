import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteTaskDialog extends StatelessWidget {
  const DeleteTaskDialog({required this.onConfirm, super.key});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: .circular(20)),
      title: const Text(
        'Delete Task?',
        textAlign: .center,
        style: TextStyle(fontWeight: .bold, fontSize: 20),
      ),
      content: const Text(
        'Are you sure you want to permanently delete this task?',
        textAlign: .center,
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
      actionsAlignment: .center,
      actionsPadding: const .fromLTRB(20, 0, 20, 20),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => context.pop(false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEBEFF5),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: .circular(12)),
                  padding: const .symmetric(vertical: 12),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontWeight: .w600),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  onConfirm();
                  context.pop(true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4B4B),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: .circular(12)),
                  padding: const .symmetric(vertical: 12),
                ),
                child: const Text(
                  'Delete',
                  style: TextStyle(fontWeight: .w600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
