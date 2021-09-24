unit uUsuarios;

interface

uses
  Horse,
  system.JSON,
  uDAOGenerico,
  uUsuario;

procedure Registry(App : THorse);
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure Registry(App : THorse);
begin
  App.Get('/usuarios',Get);
  App.Get('/usuarios/:id',GetID);
  App.Post('/usuarios',Insert);
  //App.Put('/usuarios/',Update);
  App.Put('/usuarios/:id',Update);
  App.Delete('/usuarios/:id',Delete);
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TUSUARIO>;
begin
  FDAO := TDAOGeneric<TUSUARIO>.new;
  Res.Send<TJsonArray>(FDAO.Find);
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TUSUARIO>;
begin
   FDAO := TDAOGeneric<TUSUARIO>.new;
   Res.Send<TJsonObject>(FDAO.Insert(Req.Body<TJsonObject>));
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TUSUARIO>;
begin
  FDAO := TDAOGeneric<TUSUARIO>.new;
  Res.Send<TJSONObject>(FDAO.Find(Req.Params.Items['id']));
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TUSUARIO>;
begin
   FDAO := TDAOGeneric<TUSUARIO>.new;
   Res.Send<TJsonObject>(FDAO.Update(Req.Body<TJsonObject>));
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TUSUARIO>;
begin
  FDAO := TDAOGeneric<TUSUARIO>.new;
  Res.Send<TJSONObject>(FDAO.Delete('ID',Req.Params.Items['id']));
end;

end.
