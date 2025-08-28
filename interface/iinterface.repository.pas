unit iinterface.repository;

interface

uses cliente.model, produto.model, Data.DB, System.SysUtils;

type
  IInterfaceRepository<T> = interface
    ['{B9F75D2C-E75F-4DAA-A595-F173214A7858}']
    function Inserir(AEntity: T): Boolean;
    function Alterar(AEntity: T; ACodigo: Integer): Boolean;
    function Excluir(ACodigo: Integer): Boolean;
    function ExecutarTransacao(AOperacao: TProc): Boolean;

  end;

implementation

end.
