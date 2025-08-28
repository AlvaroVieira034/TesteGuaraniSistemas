unit urelpedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.Controls, conexao, produto.model, produto.controller, produto.repository, produto.service,
  cliente.model, cliente.controller, pedido.model, pedidoitens.model, pedido.controller, pedido.repository,
  ipedido.repository, pedido.service, ipedido.service, pedidoitens.controller, cliente.repository,
  iinterface.repository, cliente.service, iinterface.service, untFormat, upesqpedidos, umostrapedido,
  System.Generics.Collections;

type
  TFrmRelPedidos = class(TForm)
    DbGridRelatorio: TDBGrid;
    Panel1: TPanel;
    Label1: TLabel;
    EdtDataDe: TEdit;
    Label2: TLabel;
    BtnPesquisar: TSpeedButton;
    EdtDataAte: TEdit;
    BtnSair: TSpeedButton;
    ChkRelatorio: TCheckBox;
    procedure EdtDataDeChange(Sender: TObject);
    procedure EdtDataAteChange(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    TblPedidos: TFDQuery;
    DsRelatorio: TDataSource;
    FPedido: TPedido;
    FPedidoController: TPedidoController;
    FPedidoItens: TPedidoItens;
    FPedidoItensController: TPedidoItensController;

    procedure PreencherGridRelatorio;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  end;

var
  FrmRelPedidos: TFrmRelPedidos;

implementation

{$R *.dfm}

constructor TFrmRelPedidos.Create(AOwner: TComponent);
begin
  inherited;
  TblPedidos := TFDQuery.Create(nil);
  DsRelatorio := TDataSource.Create(nil);
end;

destructor TFrmRelPedidos.Destroy;
begin
  TblPedidos.Free;
  DsRelatorio.Free;
  inherited Destroy;
end;

procedure TFrmRelPedidos.FormCreate(Sender: TObject);
var sCampo: string;
begin
  inherited;
  if TConexao.GetInstance.Connection.TestarConexao then
  begin
     // Cria Tabelas
    TblPedidos := TConexao.GetInstance.Connection.CriarQuery;

    // Cria DataSource
    DsRelatorio := TConexao.GetInstance.Connection.CriarDataSource;
    DbGridRelatorio.DataSource := DsRelatorio;

    // Atribui DataSet às tabelas
    DsRelatorio.DataSet := TblPedidos;

    //Instancias Classes
    FPedido := TPedido.Create;
    FPedidoController := TPedidoController.Create(TPedidoRepository.Create, TPedidoService.Create);
  end
  else
  begin
    ShowMessage('Não foi possível conectar ao banco de dados!');
    Close;
  end;

end;

procedure TFrmRelPedidos.FormShow(Sender: TObject);
begin
  PreencherGridRelatorio();
end;

procedure TFrmRelPedidos.PreencherGridRelatorio;
var CkRelatorio: Integer;
begin
  if ChkRelatorio.Checked then
      CkRelatorio := 0
    else
      CkRelatorio := 1;

  FPedidoController.PreencherGridRelatorio(TblPedidos, EdtDataDe.Text, EdtDataAte.Text, CkRelatorio);
end;

procedure TFrmRelPedidos.EdtDataDeChange(Sender: TObject);
begin
  Formatar(EdtDataDe, TFormato.Dt);
end;

procedure TFrmRelPedidos.EdtDataAteChange(Sender: TObject);
begin
  Formatar(EdtDataAte, TFormato.Dt);
end;

procedure TFrmRelPedidos.BtnPesquisarClick(Sender: TObject);
begin
  PreencherGridRelatorio();
end;

procedure TFrmRelPedidos.BtnSairClick(Sender: TObject);
begin
  Close;
end;

end.
