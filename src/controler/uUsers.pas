unit uUsers;

interface

uses
  Horse, system.JSON;

procedure Registry(App : THorse);
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses uDAOGenerico, uUser;

procedure Registry(App : THorse);
begin
  App.Get('/users',Get);
  App.Get('/users/:id',GetID);
  App.Post('/users',Insert);
  //App.Put('/users/',Update);
  App.Put('/users/:id',Update);
  App.Delete('/users/:id',Delete);
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TUSER>;
begin
  FDAO := TDAOGeneric<TUSER>.new;
  Res.Send<TJsonArray>(FDAO.Find);
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TUSER>;
begin
   FDAO := TDAOGeneric<TUSER>.new;
   Res.Send<TJsonObject>(FDAO.Insert(Req.Body<TJsonObject>));
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TUSER>;
begin
  FDAO := TDAOGeneric<TUSER>.new;
  Res.Send<TJSONObject>(FDAO.Find(Req.Params.Items['id']));
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TUSER>;
begin
   FDAO := TDAOGeneric<TUSER>.new;
   Res.Send<TJsonObject>(FDAO.Update(Req.Body<TJsonObject>));
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TUSER>;
begin
  FDAO := TDAOGeneric<TUSER>.new;
  Res.Send<TJSONObject>(FDAO.Delete('ID',Req.Params.Items['id']));
end;

end.
