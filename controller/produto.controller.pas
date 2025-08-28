unit produto.controller;

interface

uses produto.model, produto.repository, iinterface.repository, produto.service, iinterface.service, system.SysUtils,
     Vcl.Forms, FireDAC.Comp.Client, Data.DB;

type
  TCampoInvalido = (ciNome, ciDescricao, ciPreco, ciPrecoZero);
  TProdutoController = class

  private
    FProduto: TProduto;
    FProdutoRepository: TProdutoRepository;
    FProdutoService: TProdutoService;
    FDataSource: TDataSource;

  public
    constructor Create(AProdutoRepository: IInterfaceRepository<TProduto>; AProdutoService: IInterfaceService<TProduto>);
    destructor Destroy; override;
    procedure PreencherGridProdutos(APesquisa, ACampo: string);
    procedure PreencherComboProdutos(TblProdutos: TFDQuery);
    function PreencherCamposForm(FProduto: TProduto; iCodigo: Integer): Boolean;
    function Inserir(FProduto: TProduto): Boolean;
    function Alterar(FProduto: TProduto; iCodigo: Integer): Boolean;
    function Excluir(iCodigo: Integer): Boolean;
    function GetValorUnitario(ACodigo: Integer): Double;
    function GetDataSource: TDataSource;
    function ValidarDados(const ADescricao, APreco: string; out AErro: TCampoInvalido): Boolean;
    function ExecutarTransacao(AOperacao: TProc): Boolean;

  end;

implementation

{ TProdutoController }


constructor TProdutoController.Create(AProdutoRepository: IInterfaceRepository<TProduto>; AProdutoService: IInterfaceService<TProduto>);
begin
  FProduto := TProduto.Create();
  FProdutoRepository := TProdutoRepository.Create;
  FProdutoService := TProdutoService.Create;
end;

destructor TProdutoController.Destroy;
begin
  FProduto.Free;
  inherited;
end;

procedure TProdutoController.PreencherGridProdutos(APesquisa, ACampo: string);
var LCampo, SErro: string;
begin
   try
    LCampo := ACampo;
    FProdutoService.PreencherGridForm(APesquisa, LCampo);
  except
    on E: Exception do
    begin
      SErro := 'Ocorreu um erro ao pesquisar o produto!' + sLineBreak + E.Message;
      raise Exception.Create(SErro);
    end;
  end;

end;

procedure TProdutoController.PreencherComboProdutos(TblProdutos: TFDQuery);
begin
  FProdutoService.PreencherComboBox(TblProdutos);
end;

function TProdutoController.PreencherCamposForm(FProduto: TProduto; iCodigo: Integer): Boolean;
var sErro: string;
begin
  try
    FProdutoService.PreencherCamposForm(FProduto, iCodigo);
  except on E: Exception do
    begin
      sErro := 'Ocorreu um erro ao carregar o produto!' + sLineBreak + E.Message;
      Result := False;
      raise;
    end;
  end;
end;

function TProdutoController.Inserir(FProduto: TProduto): Boolean;
begin
  Result := FProdutoRepository.Inserir(FProduto);
end;

function TProdutoController.Alterar(FProduto: TProduto; iCodigo: Integer): Boolean;
begin
  Result := FProdutoRepository.Alterar(FProduto, iCodigo);
end;

function TProdutoController.Excluir(iCodigo: Integer): Boolean;
begin
  Result := FProdutoRepository.Excluir(iCodigo);
end;

function TProdutoController.GetValorUnitario(ACodigo: Integer): Double;
begin
  Result := FProdutoService.GetValorUnitario(ACodigo);
end;

function TProdutoController.GetDataSource: TDataSource;
begin
  Result := FProdutoService.GetDataSource;
end;

function TProdutoController.ExecutarTransacao(AOperacao: TProc): Boolean;
begin
  Result := FProdutoRepository.ExecutarTransacao(AOperacao);
end;

function TProdutoController.ValidarDados(const ADescricao, APreco: string; out AErro: TCampoInvalido): Boolean;
begin
  Result := True;
  if ADescricao = EmptyStr then
  begin
    AErro := ciDescricao;
    Result := False;
    Exit;
  end;

  if APreco = EmptyStr then
  begin
    AErro := ciPreco;
    Result := False;
    Exit;
  end;

  if APreco = '0.00' then
  begin
    AErro := ciPrecoZero;
    Result := False;
    Exit;
  end;
end;

end.
