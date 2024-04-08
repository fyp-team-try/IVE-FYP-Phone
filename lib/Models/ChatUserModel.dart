class ChatUser {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  ChatUser({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isOnline,
  });
}

// YOU - current user
final ChatUser currentUser = ChatUser(
  id: 0,
  name: 'Nick Fury',
  imageUrl: 'assets/images/black.png',
  isOnline: true,
);

// USERS
final ChatUser ironMan = ChatUser(
  id: 1,
  name: 'Iron Man',
  imageUrl: 'assets/images/black.png',
  isOnline: true,
);
final ChatUser captainAmerica = ChatUser(
  id: 2,
  name: 'Captain America',
  imageUrl: 'assets/images/black.png',
  isOnline: true,
);
final ChatUser hulk = ChatUser(
  id: 3,
  name: 'Hulk',
  imageUrl: 'assets/images/black.png',
  isOnline: false,
);
final ChatUser scarletWitch = ChatUser(
  id: 4,
  name: 'Scarlet Witch',
  imageUrl: 'assets/images/black.png',
  isOnline: false,
);
final ChatUser spiderMan = ChatUser(
  id: 5,
  name: 'Spider Man',
  imageUrl: 'assets/images/black.png',
  isOnline: true,
);
final ChatUser blackWindow = ChatUser(
  id: 6,
  name: 'Black Widow',
  imageUrl: 'assets/images/black.png',
  isOnline: false,
);
final ChatUser thor = ChatUser(
  id: 7,
  name: 'Thor',
  imageUrl: 'assets/images/black.png',
  isOnline: false,
);
final ChatUser captainMarvel = ChatUser(
  id: 8,
  name: 'Captain Marvel',
  imageUrl: 'assets/images/black.png',
  isOnline: false,
);