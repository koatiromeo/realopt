class Note {
  int id;
  String title;
  String content;
  DateTime modifiedTime;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.modifiedTime,
  });
}


List<Note> sampleNotes = [
  Note(
    id: 0,
    title: 'Jacob Ramirez',
    content:
    'john88@example.com',
    modifiedTime: DateTime(2022,1,1,34,5),
  ),
  Note(
    id: 1,
    title: 'Douglas Wilson',
    content:
    'michael83@example.net',
    modifiedTime: DateTime(2022,1,1,34,5),
  ),
  Note(
    id: 2,
    title: 'Rodney Smith',
    content:
    'melinda76@example.org',
    modifiedTime: DateTime(2023,3,1,19,5),
  ),
  Note(
    id: 3,
    title: 'Bethany Wallace',
    content: 'smithlisa@example.com',
    modifiedTime: DateTime(2023,1,4,16,53),
  ),
  Note(
    id: 4,
    title: 'Pamela Reynolds',
    content:
    'edwardmcgee@example.org',
    modifiedTime: DateTime(2023,5,1,11,6),
  ),
  Note(
    id: 5,
    title: 'Brittany Wright',
    content:
    'carlashelton@example.com',
    modifiedTime: DateTime(2023,1,6,13,9),
  ),
  Note(
    id: 6,
    title: 'Stephen Edwards',
    content: "travisferguson@example.com",
    modifiedTime: DateTime(2023,3,7,11,12),
  ),
  Note(
    id: 7,
    title: 'Michaela Best',
    content:
    'castillokathryn@example.org',
    modifiedTime: DateTime(2023,2,1,15,14),
  ),
  Note(
    id: 8,
    title: 'Carolyn Medina',
    content:
    'kathryn42@example.net',
    modifiedTime: DateTime(2023,2,1,12,34),
  ),
];