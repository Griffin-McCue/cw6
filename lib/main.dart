import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  Future<void> signOut() async => await _auth.signOut();
}

class Task {
  String id;
  String name;
  bool isCompleted;
  String parentTimeSlot;

  Task({required this.id, required this.name, this.isCompleted = false, this.parentTimeSlot = ''});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isCompleted': isCompleted,
      'parentTimeSlot': parentTimeSlot,
    };
  }

  static Task fromDocument(DocumentSnapshot doc) {
    return Task(
      id: doc.id,
      name: doc['name'],
      isCompleted: doc['isCompleted'],
      parentTimeSlot: doc['parentTimeSlot'] ?? '',
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: emailController, decoration: InputDecoration(hintText: 'Email')),
            TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(hintText: 'Password')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var user = await _auth.signIn(emailController.text, passwordController.text);
                if (user != null) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TaskListScreen()));
                }
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _taskController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String selectedTimeSlot = "Monday_9_10";

  void _addTask(String taskName, String timeSlot) {
    if (taskName.isNotEmpty) {
      _firestore.collection('tasks').add({
        'name': taskName,
        'isCompleted': false,
        'parentTimeSlot': timeSlot,
      });
      _taskController.clear();
    }
  }

  void _toggleTask(Task task) {
    _firestore.collection('tasks').doc(task.id).update({'isCompleted': !task.isCompleted});
  }

  void _deleteTask(String id) {
    _firestore.collection('tasks').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _taskController)),
                DropdownButton<String>(
                  value: selectedTimeSlot,
                  items: [
                    'Monday_9_10',
                    'Monday_12_2',
                    'Tuesday_10_11',
                    'Wednesday_1_3',
                    'Friday_4_6',
                  ].map((slot) => DropdownMenuItem(value: slot, child: Text(slot))).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedTimeSlot = val!;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addTask(_taskController.text, selectedTimeSlot),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('tasks').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                Map<String, List<Task>> groupedTasks = {};

                for (var doc in snapshot.data!.docs) {
                  Task task = Task.fromDocument(doc);
                  groupedTasks.putIfAbsent(task.parentTimeSlot, () => []).add(task);
                }

                return ListView(
                  children: groupedTasks.entries.map((entry) {
                    return ExpansionTile(
                      title: Text(entry.key),
                      children: entry.value.map((task) {
                        return ListTile(
                          title: Text(task.name),
                          leading: Checkbox(
                            value: task.isCompleted,
                            onChanged: (_) => _toggleTask(task),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteTask(task.id),
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
