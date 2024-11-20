// Position 클래스: 거래 포지션 정보를 관리하는 모델 클래스
class Position {
  // 포지션의 고유 식별자
  final int id;
  // 거래 종목 심볼 (예: AAPL, GOOGL 등)
  final String ticker;
  // 진입 가격 (매수/매도 시점의 가격)
  final double entryPrice;
  // 포지션 생성 시간
  final DateTime createdAt;

  // 생성자: 모든 필드가 필수값으로 지정됨
  Position({
    required this.id,
    required this.ticker,
    required this.entryPrice,
    required this.createdAt,
  });

  // fromMap: DB나 JSON 등의 Map 데이터를 Position 객체로 변환하는 팩토리 생성자
  factory Position.fromMap(Map<String, dynamic> map) {
    return Position(
      id: map['id'],
      ticker: map['ticker'],
      entryPrice: map['entry_price'],  // DB의 snake_case 키를 camelCase로 매핑
      createdAt: DateTime.parse(map['created_at']),  // 문자열 날짜를 DateTime 객체로 변환
    );
  }

  // toMap: Position 객체를 DB 저장용 Map으로 변환하는 메서드
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ticker': ticker,
      'entry_price': entryPrice,  // camelCase 변수를 DB의 snake_case로 매핑
      'created_at': createdAt.toIso8601String(),  // DateTime을 표준 ISO 8601 형식 문자열로 변환
    };
  }

  // SQLite 테이블 생성 쿼리를 반환하는 정적 getter
  static String get createTableQuery => '''
    CREATE TABLE IF NOT EXISTS positions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,  // 자동 증가하는 기본키
      ticker TEXT NOT NULL,                  // 종목 심볼 (필수)
      entry_price REAL NOT NULL,             // 진입 가격 (필수)
      created_at TEXT NOT NULL               // 생성 시간 (필수)
    )
  ''';
}