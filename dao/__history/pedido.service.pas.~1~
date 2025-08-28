unit pedido.service;

interface

uses ipedido.service, pedido.model, conexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
     Data.DB;

type
  TPedidoService = class(TInterfacedObject, IPedidoService)

  private
    TblPedidos: TFDQuery;
    DsPedidos: TDataSource;

  public
    constructor Create;
    destructor Destroy; override;
    procedure PreencherGridPedidos(TblPedidos: TFDQuery; APesquisa, ACampo: string);
    procedure PreencherCamposForm(FPedido: TPedido; ACodigo: Integer);
    procedure PreencherGridRelatorio(TblPedidos: TFDQuery; ADataDe, ADataAte: string);

  end;

implementation

{ TPedidoService }

constructor TPedidoService.Create;
begin
  TblPedidos := TConexao.GetInstance.Connection.CriarQuery;
end;

destructor TPedidoService.Destroy;
begin
  TblPedidos.Free;

  inherited;
end;

procedure TPedidoService.PreencherGridPedidos(TblPedidos: TFDQuery; APesquisa, ACampo: string);
begin
  with TblPedidos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select vda.cod_Pedido, ');
    SQL.Add('vda.dta_Pedido, ');
    SQL.Add('vda.cod_cliente, ');
    SQL.Add('cli.des_nomecliente as nomecliente, ');
    SQL.Add('vda.val_Pedido');
    SQL.Add('from tab_Pedido vda');
    SQL.Add('join tab_cliente cli on vda.cod_cliente = cli.cod_cliente ');
    SQL.Add('where ' + ACampo + ' like :pNOME');
    SQL.Add('order by ' + ACampo + ' desc');
    ParamByName('PNOME').AsString := APesquisa;
    Prepared := True;
    Open();
  end;
end;

procedure TPedidoService.PreencherGridRelatorio(TblPedidos: TFDQuery; ADataDe, ADataAte: string);
var DataDe, DataAte: TDate;
begin
  with TblPedidos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select vda.cod_pedido as ID, ');
    SQL.Add('vda.dta_pedido, ');
    SQL.Add('vda.cod_cliente, ');
    SQL.Add('cli.des_nomecliente as des_cliente, ');
    SQL.Add('vda.val_pedido,');
    SQL.Add('count(itm.cod_produto) as val_itens');
    SQL.Add('from tab_pedido vda');
    SQL.Add('join tab_cliente cli on vda.cod_cliente = cli.cod_cliente ');
    SQL.Add('join tab_pedido_item itm on vda.cod_pedido = itm.cod_pedido');

    if (Trim(ADataDe) <> '') and (Trim(ADataAte) <> '') then
    begin
      DataDe := StrToDate(ADataDe);
      DataAte := StrToDate(ADataAte);
      SQL.Add('where vda.dta_pedido between :DataDE and :DataATE');
      ParamByName('DataDE').AsDate := DataDe;
      ParamByName('DataATE').AsDate := DataAte;
    end;

    SQL.Add('group by vda.cod_pedido, vda.dta_pedido, vda.cod_cliente, vda.val_pedido, cli.des_nomecliente');
    SQL.Add('order by vda.dta_pedido desc');
    Prepared := True;
    Open();
  end;
end;

procedure TPedidoService.PreencherCamposForm(FPedido: TPedido; ACodigo: Integer);
begin
  with TblPedidos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select vda.cod_Pedido, ');
    SQL.Add('vda.dta_Pedido, ');
    SQL.Add('vda.cod_cliente, ');
    SQL.Add('cli.des_nomecliente as des_cliente, ');
    SQL.Add('vda.val_Pedido');
    SQL.Add('from tab_Pedido vda');
    SQL.Add('join tab_cliente cli on vda.cod_cliente = cli.cod_cliente ');
    SQL.Add('where vda.cod_Pedido = :cod_Pedido');
    ParamByName('COD_Pedido').AsInteger := ACodigo;
    Open();

    with FPedido, TblPedidos do
    begin
      Cod_Pedido := FieldByName('COD_Pedido').AsInteger;
      Dta_Pedido := FieldByName('DTA_Pedido').AsDateTime;
      Cod_Cliente := FieldByName('COD_CLIENTE').AsInteger;
      Des_Cliente := FieldByName('DES_CLIENTE').AsString;
      Val_Pedido := FieldByName('VAL_Pedido').AsFloat;
    end;
  end;
end;


end.
