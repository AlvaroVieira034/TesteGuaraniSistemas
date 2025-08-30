program TesteGuarani;

uses
  Vcl.Forms,
  umain in 'view\umain.pas' {FrmMain},
  cliente.model in 'model\cliente.model.pas',
  pedido.model in 'model\pedido.model.pas',
  pedidoitens.model in 'model\pedidoitens.model.pas',
  produto.model in 'model\produto.model.pas',
  cliente.controller in 'controller\cliente.controller.pas',
  pedido.controller in 'controller\pedido.controller.pas',
  pedidoitens.controller in 'controller\pedidoitens.controller.pas',
  produto.controller in 'controller\produto.controller.pas',
  cliente.repository in 'dao\cliente.repository.pas',
  cliente.service in 'dao\cliente.service.pas',
  pedido.repository in 'dao\pedido.repository.pas',
  pedido.service in 'dao\pedido.service.pas',
  pedidoitens.repository in 'dao\pedidoitens.repository.pas',
  produto.repository in 'dao\produto.repository.pas',
  produto.service in 'dao\produto.service.pas',
  iinterface.repository in 'interface\iinterface.repository.pas',
  iinterface.service in 'interface\iinterface.service.pas',
  ipedido.repository in 'interface\ipedido.repository.pas',
  ipedido.service in 'interface\ipedido.service.pas',
  ipedidoitens.repository in 'interface\ipedidoitens.repository.pas',
  cep.service in 'util\cep.service.pas',
  conexao in 'util\conexao.pas',
  connection in 'util\connection.pas',
  untFormat in 'util\untFormat.pas',
  ucadastropadrao in 'view\ucadastropadrao.pas' {FrmCadastroPadrao},
  ucadcliente in 'view\ucadcliente.pas' {FrmCadCliente},
  ucadpedido in 'view\ucadpedido.pas' {FrmCadPedido},
  ucadproduto in 'view\ucadproduto.pas' {FrmCadProduto},
  umostrapedido in 'view\umostrapedido.pas' {FrmMostraPedido},
  upesqpedidos in 'view\upesqpedidos.pas' {FrmPesquisaPedidos},
  urelpedidos in 'view\urelpedidos.pas' {FrmRelPedidos};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
