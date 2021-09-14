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
  uUsers in 'src\controler\uUsers.pas';

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

  App.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      uServerReactModelConnection.Connected;
      uServerReactModelConnection.Disconnected;
      Res.Send('<h1>Pong...</h1>');
    end);

//  App.Listen(9000);
  App.start;
end.
