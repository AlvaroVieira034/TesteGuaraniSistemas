unit cliente.controller;

interface

uses cliente.model, cliente.repository, iinterface.repository, cliente.service, iinterface.service, conexao,
     System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB;

type
  TCampoInvalido = (ciRazaoSocial, ciCidade, ciUF);
  TClienteController = class

  private
    FCliente: TCliente;
    FClienteRepository : TClienteRepository;
    FClienteService : TClienteService;

  public
    constructor Create(AClienteRepository: IInterfaceRepository<TCliente>; AClienteService: IInterfaceService<TCliente>);
    destructor Destroy; override;
    procedure PreencherGridClientes(APesquisa, ACampo: string);
    procedure PreencherCamposForm(FCliente: TCliente; ACodigo: Integer);
    procedure PreencherComboClientes(TblComboClientes: TFDQuery);
    function Inserir(FCliente: TCliente): Boolean;
    function Alterar(FCliente: TCliente; ACodigo: Integer): Boolean;
    function Excluir(ACodigo: Integer): Boolean;
    function ValidarDados(const ARazaoSocial, ACidade, AUF: string; out AErro: TCampoInvalido): Boolean;
    function ExecutarTransacao(AOperacao: TProc): Boolean;
    function GetDataSource: TDataSource;

  end;

implementation

{ TClienteController }

constructor TClienteController.Create(AClienteRepository: IInterfaceRepository<TCliente>; AClienteService: IInterfaceService<TCliente>);
begin
  FCliente := TCliente.Create();
  FClienteRepository := TClienteRepository.Create;
  FClienteService := TClienteService.Create;
end;

destructor TClienteController.Destroy;
begin
  FCliente.Free;
  FClienteRepository.Free;
  FClienteService.Free;
  inherited Destroy;
end;

function TClienteController.Inserir(FCliente: TCliente): Boolean;
begin
  Result := FClienteRepository.Inserir(FCliente);
end;

function TClienteController.Alterar(FCliente: TCliente; ACodigo: Integer): Boolean;
begin
  Result := FClienteRepository.Alterar(FCliente, ACodigo);
end;

function TClienteController.Excluir(ACodigo: Integer): Boolean;
begin
  Result := FClienteRepository.Excluir(ACodigo);
end;

procedure TClienteController.PreencherGridClientes(APesquisa, ACampo: string);
var LCampo, SErro: string;
begin
  try
    LCampo := ACampo;
    FClienteService.PreencherGridForm(APesquisa, LCampo);
  except
    on E: Exception do
    begin
      SErro := 'Ocorreu um erro ao pesquisar o cliente!' + sLineBreak + E.Message;
      raise Exception.Create(SErro);
    end;
  end;

end;

procedure TClienteController.PreencherCamposForm(FCliente: TCliente; ACodigo: Integer);
var sErro: string;
begin
  try
    FClienteService.PreencherCamposForm(FCliente, ACodigo);
  except on E: Exception do
    begin
      sErro := 'Ocorreu um erro ao carregar o cliente!' + sLineBreak + E.Message;
      raise;
    end;
  end;

end;

procedure TClienteController.PreencherComboClientes(TblComboClientes: TFDQuery);
begin
  FClienteService.PreencherComboBox(TblComboClientes);
end;

function TClienteController.ValidarDados(const ARazaoSocial, ACidade, AUF: string; out AErro: TCampoInvalido): Boolean;
var LCpf, LCnpj: string;
begin
  if ARazaoSocial = EmptyStr then
  begin
    AErro := ciRazaoSocial;
    Exit;
  end;

  if ACidade = EmptyStr then
  begin
    AErro := ciCidade;
    Exit;
  end;

  if AUF = EmptyStr then
  begin
    AErro := ciUF;
    Exit;
  end;

  Result := True;
end;

function TClienteController.ExecutarTransacao(AOperacao: TProc): Boolean;
begin
  Result := FClienteRepository.ExecutarTransacao(AOperacao);
end;

function TClienteController.GetDataSource: TDataSource;
begin
  Result := FClienteService.GetDataSource;
end;

end.
