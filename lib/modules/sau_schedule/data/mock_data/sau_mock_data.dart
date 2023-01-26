class Sau {
  final String day;
  final String date;
  final List<String> saus;
  final bool isToday;

  const Sau({
    required this.day,
    required this.date,
    required this.saus,
    required this.isToday,
  });
}

List<Sau> saus = const [
  Sau(
    day: "Понедельник",
    date: "25 января",
    saus: [
      "Русский язык",
      "Казахский язык",
    ],
    isToday: true,
  ),
  Sau(
    day: "Понедельник",
    date: "25 января",
    saus: [],
    isToday: false,
  ),
  Sau(
    day: "Понедельник",
    date: "25 января",
    saus: [
      "Русский язык",
      "Казахский язык",
    ],
    isToday: false,
  ),
  Sau(
    day: "Понедельник",
    date: "25 января",
    saus: [
      "Русский язык",
      "Казахский язык",
    ],
    isToday: false,
  ),
  Sau(
    day: "Понедельник",
    date: "25 января",
    saus: [
      "Русский язык",
      "Казахский язык",
    ],
    isToday: false,
  ),
  Sau(
    day: "Понедельник",
    date: "25 января",
    saus: [
      "Русский язык",
      "Казахский язык",
    ],
    isToday: false,
  ),
];
