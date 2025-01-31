class Ticket {
  final int id;
  final String title;
  final String description;
  final String status;

  Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  //Converte JSON para objeto Ticket
  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
    );
  }

  //Converte objeto Ticket para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
    };
  }
}
