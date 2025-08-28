unit umostrapedido;

interface

{$REGION 'Uses'}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.Controls, conexao, produto.model, produto.controller, produto.repository, produto.service,
  cliente.model, cliente.controller, pedido.model, pedidoitens.model, pedido.controller, pedido.repository,
  ipedido.repository, pedido.service, ipedido.service, pedidoitens.controller, cliente.repository,
  iinterface.repository, cliente.service, iinterface.service, untFormat, upesqpedidos, System.Generics.Collections;

{$ENDREGION}

type
  TFrmMostraPedido = class(TForm)
    PnlDados: TPanel;
    GrbDados: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    EdtCodPedido: TEdit;
    EdtDataPedido: TEdit;
    EdtTotalPedido: TEdit;
    EdtCodCliente: TEdit;
    LcbxNomeCliente: TDBLookupComboBox;
    PnlGrid: TPanel;
    LblTotRegistros: TLabel;
    GrbGrid: TGroupBox;
    DbGridItensPedido: TDBGrid;
    MTblPedidoItem: TFDMemTable;
    MTblPedidoItemID_PEDIDO: TIntegerField;
    MTblPedidoItemCOD_PEDIDO: TIntegerField;
    MTblPedidoItemCOD_PRODUTO: TIntegerField;
    MTblPedidoItemDES_DESCRICAO: TStringField;
    MTblPedidoItemVAL_QUANTIDADE: TIntegerField;
    MTblPedidoItemVAL_PRECOUNITARIO: TFloatField;
    MTblPedidoItemVAL_TOTALITEM: TFloatField;
    DsPedidoItem: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    ValoresOriginais: array of string;
    TblProdutos: TFDQuery;
    TblClientes: TFDQuery;
    DsProdutos: TDataSource;
    DsClientes: TDataSource;
    FProdutoController: TProdutoController;
    FClienteController: TClienteController;
    FPedido: TPedido;
    FPedidoController: TPedidoController;
    FPedidoItens: TPedidoItens;
    FPedidoItensController: TPedidoItensController;
    TransacaoPedidos : TFDTransaction;


  public
    codigoPedido: Integer;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  end;

var
  FrmMostraPedido: TFrmMostraPedido;

implementation

{$R *.dfm}

constructor TFrmMostraPedido.Create(AOwner: TComponent);
begin
  inherited;
  TblProdutos := TFDQuery.Create(nil);
  TblClientes := TFDQuery.Create(nil);
  DsProdutos := TDataSource.Create(nil);
  DsClientes := TDataSource.Create(nil);
end;

destructor TFrmMostraPedido.Destroy;
begin
  TblProdutos.Free;
  TblClientes.Free;
  DsProdutos.Free;
  DsClientes.Free;
  inherited Destroy;
end;

procedure TFrmMostraPedido.FormCreate(Sender: TObject);
var sCampo: string;
begin
  inherited;
  if TConexao.GetInstance.Connection.TestarConexao then
  begin
    // Define Transacao pra Pedidos
    TConexao.GetInstance.Connection.InciarTransacao;
    TransacaoPedidos := TConexao.GetInstance.Connection.CriarTransaction;

    // Cria Tabelas
    TblClientes := TConexao.GetInstance.Connection.CriarQuery;

    // Cria DataSource
    DsClientes := TConexao.GetInstance.Connection.CriarDataSource;

    // Atribui DataSet às tabelas
    DsClientes.DataSet := TblClientes;

    //Instancias Classes
    FClienteController := TClienteController.Create(TClienteRepository.Create, TClienteService.Create);
    FPedido := TPedido.Create;
    FPedidoController := TPedidoController.Create(TPedidoRepository.Create, TPedidoService.Create);
    FPedidoItens := TPedidoItens.Create;
    FPedidoItensController := TPedidoItensController.Create;

    MTblPedidoItem.CreateDataSet;

    // Define configuração DbLookupComboBox
    LcbxNomeCliente.KeyField := 'cod_cliente';
    LcbxNomeCliente.ListField := 'des_nomecliente';
    LcbxNomeCliente.ListSource := DsClientes;
  end
  else
  begin
    ShowMessage('Não foi possível conectar ao banco de dados!');
    Close;
  end;
end;

procedure TFrmMostraPedido.FormShow(Sender: TObject);
begin
  FClienteController.PreencherComboClientes(TblClientes);
  DbGridItensPedido.Columns[0].Width := 320;
  DbGridItensPedido.Columns[1].Width := 90;
  DbGridItensPedido.Columns[2].Width := 115;
  DbGridItensPedido.Columns[3].Width := 115;
  LCbxNomeCliente.KeyValue := StrToInt(EdtCodCliente.Text);
end;

end.
