program serveReact;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.JSON,
  Horse,
  Horse.Jhonson,
  Horse.CORS,
  uServerReactModelConnection in 'src\model\uServerReactModelConnection.pas',
  uUser in 'src\model\entidades\uUser.pas',
  uDAOGenerico in 'src\model\uDAOGenerico.pas',
  uUsers in 'src\controler\uUsers.pas',
  uCategorias in 'src\controler\uCategorias.pas',
  uProdutos in 'src\controler\uProdutos.pas',
  uCategoria in 'src\model\entidades\uCategoria.pas',
  uProduto in 'src\model\entidades\uProduto.pas';

Var
  App: THorse;
begin

  try
    App:= THorse.create(9000);

  Except
    THorse.StopListen;
  end;


  App.Use(Jhonson);
  App.Use(CORS);

  //controler de entidade/classes
  uUsers.Registry(App);
  uCategorias.Registry(App);
  uProdutos.Registry(App);

//  App.Listen(9000);
  App.start;
end.
