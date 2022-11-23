import 'package:either_dart/either.dart';
import 'package:irep/enums/contact_type_enum.dart';
import 'package:irep/models/contact_model.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/residence_model.dart';
import 'package:irep/service/residence_service.dart';
import 'package:irep/viewmodels/residence_view_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockResidenceService extends Mock implements ResidenceService {}

void main() {
  late MockResidenceService mockResidenceService;
  late ResidenceViewModel viewModel;

  setUp(() {
    mockResidenceService = MockResidenceService();
    viewModel = ResidenceViewModel(mockResidenceService);
  });

  test('initial residences should be empty list', () {
    expect(viewModel.residences, []);
  });

  group('getResidences', () {
    List<ResidenceModel> tResidences = const [
      ResidenceModel(
        nome: 'Republica Teste 1',
        contatos: [
          ContactModel(
            info: '+5537999834175',
            type: ContactTypeEnum.PHONE,
          ),
          ContactModel(
            info: 'zoiosimoes@inatel.br',
            type: ContactTypeEnum.EMAIL,
          )
        ],
        endereco: ResidenceModelEndereco(
          bairro: 'Centro',
          cep: '00000-000',
          cidade: 'Santa Rita do Sapucaí',
          estado: 'MG',
          numero: 99,
          rua: 'Rua dos testes 123',
          uuid: 'f507bb58-a03c-4d0d-a5a4-3eaefa41184f',
        ),
        estacionamento: 0,
        quartos: 5,
        banheiros: 2,
        gas: false,
        internet: true,
        uuid: '87d74a75-e9de-4126-ad7d-0149ce9ed376',
      ),
      ResidenceModel(
        nome: 'Republica Teste 2',
        contatos: [
          ContactModel(
            info: '+5535999830000',
            type: ContactTypeEnum.PHONE,
          ),
          ContactModel(
            info: 'darocaesteves@inatel.br',
            type: ContactTypeEnum.EMAIL,
          )
        ],
        endereco: ResidenceModelEndereco(
          bairro: 'Centro',
          cep: '00000-000',
          cidade: 'Santa Rita do Sapucaí',
          estado: 'MG',
          numero: 25,
          rua: 'Rua dos testes 456',
          uuid: '729c89e2-666b-4f91-a48d-48f6e55f538c',
        ),
        estacionamento: 0,
        quartos: 5,
        banheiros: 2,
        gas: false,
        internet: true,
        uuid: 'e1b123c8-c817-4498-b6bd-b1b27e99c634',
      ),
    ];

    void setUpSuccessServiceCall() {
      when(
        () => mockResidenceService.getResidences(),
      ).thenAnswer(
        (_) async => Right(tResidences),
      );
    }

    void setUpUnsuccessServiceCall() {
      when(
        () => mockResidenceService.getResidences(),
      ).thenAnswer(
        (_) async => const Left(ErrorModel()),
      );
    }

    test('should call ResidenceService.getResidences', () {
      //arrange
      setUpSuccessServiceCall();

      //arrange
      viewModel.getResidences();

      //assert
      verify(
        () => mockResidenceService.getResidences(),
      ).called(1);
    });

    test(
      'should set residences when the call '
      'to service is successful',
      () async {
        //arrange
        setUpSuccessServiceCall();

        //arrange
        await viewModel.getResidences();

        //assert
        expect(viewModel.residences, tResidences);
      },
    );

    test(
      'should set residences to empty list '
      'when the call to service is successful',
      () async {
        //arrange
        setUpUnsuccessServiceCall();

        //arrange
        await viewModel.getResidences();

        //assert
        expect(viewModel.residences, []);
      },
    );
  });

  group('getResidences', () {
    ResidenceModel tResidenceModel = const ResidenceModel(
      nome: 'Republica Teste 1',
      contatos: [
        ContactModel(
          info: '+5537999834175',
          type: ContactTypeEnum.PHONE,
        ),
        ContactModel(
          info: 'zoiosimoes@inatel.br',
          type: ContactTypeEnum.EMAIL,
        )
      ],
      endereco: ResidenceModelEndereco(
        bairro: 'Centro',
        cep: '00000-000',
        cidade: 'Santa Rita do Sapucaí',
        estado: 'MG',
        numero: 99,
        rua: 'Rua dos testes 123',
        uuid: 'f507bb58-a03c-4d0d-a5a4-3eaefa41184f',
      ),
      estacionamento: 0,
      quartos: 5,
      banheiros: 2,
      gas: false,
      internet: true,
      uuid: '87d74a75-e9de-4126-ad7d-0149ce9ed376',
    );

    String tUuid = '87d74a75-e9de-4126-ad7d-0149ce9ed376';

    void setUpSuccessServiceCall() {
      when(
        () => mockResidenceService.getResidenceInformation(
          any(),
        ),
      ).thenAnswer(
        (_) async => Right(tResidenceModel),
      );
    }

    ErrorModel tError = const ErrorModel(
      message: 'Não foi possível buscar os dados da residência.',
    );

    void setUpUnsuccessServiceCall() {
      when(
        () => mockResidenceService.getResidenceInformation(
          any(),
        ),
      ).thenAnswer(
        (_) async => Left(tError),
      );
    }

    test('should call ResidenceService.getResidences', () async {
      //arrange
      setUpSuccessServiceCall();

      //arrange
      await viewModel.getResidenceInformation(tUuid);

      //assert
      verify(
        () => mockResidenceService.getResidenceInformation(tUuid),
      ).called(1);
    });

    test(
      'should return a Right(ResidenceModel) when the call '
      'to service is successful',
      () async {
        //arrange
        setUpSuccessServiceCall();

        //arrange
        var result = await viewModel.getResidenceInformation(tUuid);

        //assert
        expect(result.isRight, true);
        expect(result.right, tResidenceModel);
      },
    );

    test(
      'should return a Left(ErrorModel) '
      'when the call to service is successful',
      () async {
        //arrange
        setUpUnsuccessServiceCall();

        //arrange
        var result = await viewModel.getResidenceInformation(tUuid);

        //assert
        expect(result.isLeft, true);
        expect(result.left, tError);
      },
    );
  });
}
