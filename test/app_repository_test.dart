import 'package:aha_demo/repositories/app_repository.dart';
import 'package:aha_demo/repositories/dto/response/users_result_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AppRepository>()])
import 'app_repository_test.mocks.dart';

void main() {
  late MockAppRepository mockAppRepo;

  setUpAll(() {
    mockAppRepo = MockAppRepository();
  });

  test('test findUsers data', () async {
    const int pageSize = 16;
    const String? pageToken = null;

    final data = UsersResultDto(
      users: [
        UserRecord(
          uid: 'QWSXZA',
          email: 'gary@gmail.com',
          emailVerified: true,
          displayName: 'Gary',
          photoURL: '',
          passwordHash: null,
          passwordSalt: null,
          tokensValidAfterTime: DateTime.now(),
          creationTime: DateTime.now(),
          lastSignInTime: DateTime.now(),
          lastRefreshTime: DateTime.now(),
        ),
      ],
      pageToken: '123',
    );

    when(
      mockAppRepo.findUsers(pageSize, pageToken),
    ).thenAnswer(
      (_) async => data,
    );

    final result = await mockAppRepo.findUsers(pageSize, pageToken);
    expect(result, isA<UsersResultDto>());
    expect(result.users, isA<List<UserRecord>>());
    expect(result, data);
  });
}
