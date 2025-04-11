import 'package:flutter/material.dart';

import 'chatscreen.dart';
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add new message action
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.primaries[index % Colors.primaries.length],
              child: Text(
                'U${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text('User ${index + 1}'),
            subtitle: Text('Latest message from user ${index + 1}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${(index % 12) + 1}:${(index % 60).toString().padLeft(2, '0')} PM'),
                const SizedBox(height: 5),
                if (index % 3 == 0)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${index % 5 + 1}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(userId: index + 1),
                ),
              );
            },
          );
        },
      ),
    );
  }
}