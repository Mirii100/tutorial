import 'package:flutter/material.dart';
class DetailScreen extends StatefulWidget {
  final int contentId;

  const DetailScreen({Key? key, required this.contentId}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isLiked = false;
  int likeCount = 0;
  final TextEditingController _commentController = TextEditingController();
  final List<Map<String, dynamic>> _comments = [];

  @override
  void initState() {
    super.initState();
    // Initialize with random like count
    likeCount = 10 + (widget.contentId * 57) % 490;

    // Add some dummy comments
    _comments.add({
      'username': 'User 1',
      'comment': 'This is an amazing post!',
      'time': '2 hours ago',
      'likes': 5,
    });
    _comments.add({
      'username': 'User 2',
      'comment': 'I totally agree with this. Great content!',
      'time': '1 hour ago',
      'likes': 3,
    });
    _comments.add({
      'username': 'User 3',
      'comment': 'Thanks for sharing this information.',
      'time': '30 minutes ago',
      'likes': 1,
    });
  }

  void _addComment() {
    if (_commentController.text.trim().isNotEmpty) {
      setState(() {
        _comments.add({
          'username': 'You',
          'comment': _commentController.text,
          'time': 'Just now',
          'likes': 0,
        });
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post ${widget.contentId}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Content Image
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.primaries[widget.contentId % Colors.primaries.length],
              child: Center(
                child: Text(
                  'Content ${widget.contentId}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),

            // Author info and actions
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Text('U${widget.contentId % 10}'),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User ${widget.contentId % 10}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${DateTime.now().day - widget.contentId % 5} days ago',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : null,
                        ),
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                            likeCount += isLiked ? 1 : -1;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.comment),
                        onPressed: () {
                          // Focus on comment field
                          FocusScope.of(context).requestFocus(FocusNode());
                          _commentController.text = '';
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.bookmark_border),
                        onPressed: () {
                          // Bookmark action
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Like count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '$likeCount likes',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Content description
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This is an amazing content post #${widget.contentId}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This is a detailed description for the content. It provides more information about what the content is about and why it might be interesting to the user. The content creator has put a lot of thought into making this post informative and engaging.',
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),

            // Divider before comments
            const Divider(),

            // Comments section title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Comments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Comments list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                final comment = _comments[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey[300],
                        child: Text(
                          comment['username'].toString().substring(0, 1),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                                  TextSpan(
                                    text: comment['username'],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${comment['comment']}',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  comment['time'],
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  'Like',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  'Reply',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite_border, size: 16),
                            onPressed: () {
                              // Like comment action
                            },
                          ),
                          Text(
                            comment['likes'].toString(),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            // Add comment section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey,
                    child: Text(
                      'Y',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _addComment(),
                    ),
                  ),
                  TextButton(
                    onPressed: _addComment,
                    child: const Text('Post'),
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