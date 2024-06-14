class Log {
  final String clientIP;
  final String lastActivity;
  final String lastCommand;
  final String sessionStart;
  final String tty;
  final String user;

  Log({
    required this.clientIP,
    required this.lastActivity,
    required this.lastCommand,
    required this.sessionStart,
    required this.tty,
    required this.user,
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      clientIP: json['Client IP'],
      lastActivity: json['Last Activity'],
      lastCommand: json['Last Command'],
      sessionStart: json['Session Start'],
      tty: json['TTY'],
      user: json['User'],
    );
  }
}
