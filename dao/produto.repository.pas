unit produto.repository;

interface

uses iinterface.repository, produto.model, conexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
     Data.DB;

type
  TProdutoRepository = class(TInterfacedObject, IInterfaceRepository<TProduto>)

  private
    QryProdutos: TFDQuery;
    Transacao: TFDTransaction;

  public
    constructor Create;
    destructor Destroy; override;
    function Inserir(AEntity: TProduto): Boolean;
    function Alterar(AEntity: TProduto; iCodigo: Integer): Boolean;
    function Excluir(iCodigo: Integer): Boolean;
    function ExecutarTransacao(AOperacao: TProc): Boolean;

  end;

implementation

{ TProdutoRepository }

constructor TProdutoRepository.Create;
begin
  inherited Create;
  Transacao := TConexao.GetInstance.Connection.CriarTransaction;
  QryProdutos := TConexao.GetInstance.Connection.CriarQuery;
  QryProdutos.Transaction := Transacao;
end;

destructor TProdutoRepository.Destroy;
begin
  QryProdutos.Free;
  inherited Destroy;
end;

function TProdutoRepository.Inserir(AEntity: TProduto): Boolean;
begin
  Result := ExecutarTransacao(
    procedure
    begin
      with QryProdutos, AEntity do
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert into tab_produto(');
        SQL.Add('des_descricao, ');
        SQL.Add('des_marca, ');
        SQL.Add('val_preco) ');
        SQL.Add('values (:des_descricao, ');
        SQL.Add(':des_marca,');
        SQL.Add(':val_preco)');

        ParamByName('DES_DESCRICAO').AsString := Des_Descricao;
        ParamByName('DES_MARCA').AsString := Des_Marca;
        ParamByName('VAL_PRECO').AsFloat := Val_Preco;


        ExecSQL;
      end;
    end);
end;

function TProdutoRepository.Alterar(AEntity: TProduto; iCodigo: Integer): Boolean;
begin
  Result := ExecutarTransacao(
  procedure
  begin
    with QryProdutos, AEntity do
    begin
      Close;
      SQL.Clear;
      SQL.Add('update tab_produto set ');
      SQL.Add('des_descricao = :des_descricao, ');
      SQL.Add('des_marca = :des_marca, ');
      SQL.Add('val_preco = :val_preco');
      SQL.Add('where cod_produto = :cod_produto');

      ParamByName('DES_DESCRICAO').AsString := Des_Descricao;
      ParamByName('DES_MARCA').AsString := Des_Marca;
      ParamByName('VAL_PRECO').AsFloat := Val_Preco;
      ParamByName('COD_PRODUTO').AsInteger := iCodigo;

      ExecSQL;
    end;
  end);
end;

function TProdutoRepository.Excluir(iCodigo: Integer): Boolean;
begin
  Result := ExecutarTransacao(
  procedure
  begin
    with QryProdutos do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'delete from tab_produto where cod_produto = :cod_produto';
      ParamByName('COD_PRODUTO').AsInteger := iCodigo;

      ExecSQL;
    end;
  end);
end;

function TProdutoRepository.ExecutarTransacao(AOperacao: TProc): Boolean;
begin
  Result := False;
  if not Transacao.Connection.Connected then
    Transacao.Connection.Open();

  Transacao.StartTransaction;
  try
    AOperacao;
    Transacao.Commit;
    Result := True;
  except
    on E: EDatabaseError do
    begin
      Transacao.Rollback;
      if Pos('UNIQUE KEY', UpperCase(E.Message)) > 0 then
        raise Exception.Create('Já existe um produto cadastrado com essa descrição!')
      else
        raise Exception.Create('Erro de banco de dados: ' + E.Message);

    end;
    on E: Exception do
    begin
      Transacao.Rollback;
      raise Exception.Create('Erro na conexão com o banco de dados: ' + E.Message);
    end;
  end;
end;

end.
