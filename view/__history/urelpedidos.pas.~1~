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
    procedure EdtDataDeChange(Sender: TObject);
    procedure EdtDataAteChange(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DbGridRelatorioDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DbGridRelatorioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    TblPedidos: TFDQuery;
    DsRelatorio: TDataSource;
    FPedido: TPedido;
    FPedidoController: TPedidoController;
    FPedidoItens: TPedidoItens;
    FPedidoItensController: TPedidoItensController;

    procedure PreencherGridRelatorio;
    procedure ExibirDetalhesPedido;

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
    FPedidoItens := TPedidoItens.Create;
    FPedidoItensController := TPedidoItensController.Create;
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
begin
  FPedidoController.PreencherGridRelatorio(TblPedidos, EdtDataDe.Text, EdtDataAte.Text);
end;

procedure TFrmRelPedidos.DbGridRelatorioDblClick(Sender: TObject);
begin
  ExibirDetalhesPedido();
end;

procedure TFrmRelPedidos.DbGridRelatorioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    ExibirDetalhesPedido();
    Key := 0;
  end;
end;

procedure TFrmRelPedidos.EdtDataDeChange(Sender: TObject);
begin
  Formatar(EdtDataDe, TFormato.Dt);
end;

procedure TFrmRelPedidos.ExibirDetalhesPedido;
var CodPedido: Integer;
    Item: TPedidoItens;
    ItensPedido: TList<TPedidoItens>;
begin
  if not TblPedidos.IsEmpty then
  begin
    CodPedido := TblPedidos.FieldByName('ID').AsInteger;
    if not Assigned(FrmMostraPedido) then
      Application.CreateForm(TFrmMostraPedido, FrmMostraPedido);

    with FrmMostraPedido do
    begin
      EdtCodPedido.Text    := TblPedidos.FieldByName('ID').AsString;
      EdtDataPedido.Text   := DateToStr(TblPedidos.FieldByName('dta_pedido').AsDateTime);
      EdtCodCliente.Text   := TblPedidos.FieldByName('cod_cliente').AsString;
      EdtTotalPedido.Text  := FormatFloat('#,##0.00', TblPedidos.FieldByName('val_pedido').AsFloat);

      // Chama o método para carregar os itens do pedido
      ItensPedido := FPedidoItensController.CarregarItensPedido(CodPedido);
      try
        for Item in ItensPedido do
        begin
          with FrmMostraPedido do
          begin
            MTblPedidoItem.Append;
            MTblPedidoItemID_PEDIDO.AsInteger := Item.Id_Pedido;
            MTblPedidoItemCOD_PEDIDO.AsInteger := Item.Cod_Pedido;
            MTblPedidoItemCOD_PRODUTO.AsInteger := Item.Cod_Produto;
            MTblPedidoItemDES_DESCRICAO.AsString := Item.Des_Descricao;
            MTblPedidoItemVAL_QUANTIDADE.AsInteger := Item.Val_Quantidade;
            MTblPedidoItemVAL_PRECOUNITARIO.AsFloat := Item.Val_PrecoUnitario;
            MTblPedidoItemVAL_TOTALITEM.AsFloat := Item.Val_TotalItem;
            MTblPedidoItem.Post;
          end;
        end;
      finally
        ItensPedido.Free;
      end;
    end;

    FrmMostraPedido.ShowModal;
  end;

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
