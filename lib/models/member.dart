/*
  날짜 : 2025-12-17
  내용 : Member 테이블
  이름 : 이수연
*/

class Member {
  final int memberId;           // 사용자 식별자
  final String loginId;         // 로그인 아이디
  final String password;        // 비밀번호 (암호화된 상태)
  final String memberName;      // 사용자 이름
  final String lastNameEn;      // 사용자 영문 성
  final String firstNameEn;     // 사용자 영문 이름
  final DateTime birthDate;     // 생년월일
  final String rrn;             // 주민등록번호
  final int? age;               // 나이
  final String? ageGroup;       // 연령대
  final String gender;          // 성별 (M/F)
  final String phoneNumber;     // 휴대폰 번호
  final String mobileCarrier;   // 휴대폰 통신사
  final String? email;          // 이메일
  final String? postalCode;     // 우편번호
  final String? address;        // 주소
  final String? addressDetail;  // 상세주소
  final DateTime createdAt;     // 가입일시
  final String memberStatus;    // 회원 상태

  Member({
    required this.memberId,
    required this.loginId,
    required this.password,
    required this.memberName,
    required this.lastNameEn,
    required this.firstNameEn,
    required this.birthDate,
    required this.rrn,
    this.age,
    this.ageGroup,
    required this.gender,
    required this.phoneNumber,
    required this.mobileCarrier,
    this.email,
    this.postalCode,
    this.address,
    this.addressDetail,
    required this.createdAt,
    required this.memberStatus,
  });

  // --- 서버에서 받은 JSON 데이터를 Dart 객체로 변환 (역직렬화) ---
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberId: json['MEMBER_ID'] as int,
      loginId: json['LOGIN_ID'] as String,
      password: json['PASSWORD'] as String,
      memberName: json['MEMBER_NAME'] as String,
      lastNameEn: json['LAST_NAME_EN'] as String,
      firstNameEn: json['FIRST_NAME_ENV'] as String,
      birthDate: DateTime.parse(json['BIRTHDATE']),
      rrn: json['RRN'] as String,
      age: json['AGE'] as int?,
      ageGroup: json['AGE_GROUP'] as String?,
      gender: json['GENDER'] as String,
      phoneNumber: json['PHONE_NUMBER'] as String,
      mobileCarrier: json['MOBILE_CARRIER'] as String,
      email: json['EMAIL'] as String?,
      postalCode: json['POSTAL_CODE'] as String?,
      address: json['ADDRESS'] as String?,
      addressDetail: json['ADDRESS_DETAIL'] as String?,
      createdAt: DateTime.parse(json['CREATED_AT']),
      memberStatus: json['MEMBER_STATUS'] as String,
    );
  }

  // --- Dart 객체를 JSON으로 변환 (직렬화, 서버 전송용) ---
  Map<String, dynamic> toJson() {
    return {
      'MEMBER_ID': memberId,
      'LOGIN_ID': loginId,
      'PASSWORD': password,
      'MEMBER_NAME': memberName,
      'LAST_NAME_EN': lastNameEn,
      'FIRST_NAME_ENV': firstNameEn,
      'BIRTHDATE': birthDate.toIso8601String(),
      'RRN': rrn,
      'AGE': age,
      'AGE_GROUP': ageGroup,
      'GENDER': gender,
      'PHONE_NUMBER': phoneNumber,
      'MOBILE_CARRIER': mobileCarrier,
      'EMAIL': email,
      'POSTAL_CODE': postalCode,
      'ADDRESS': address,
      'ADDRESS_DETAIL': addressDetail,
      'CREATED_AT': createdAt.toIso8601String(),
      'MEMBER_STATUS': memberStatus,
    };
  }

  // --- 유틸리티 메서드: 풀네임 반환 ---
  String get fullEnglishName => '$firstNameEn $lastNameEn';
}