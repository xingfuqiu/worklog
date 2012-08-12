unit uDM;

interface

uses
  SysUtils, Classes, DB, ADODB, Windows;

type
  TDM = class(TDataModule)
    Conn: TADOConnection;
    Query_Log: TADOQuery;
    Query_Date: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    function ConnDB: Boolean;
  public
    function OpenTable(sSQL: String; Query: TADOQuery): Integer;
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  if Not ConnDB then
  begin
    MessageBox(0, '数据库连接失败,请重新启动软件!', '提示', MB_OK+MB_ICONWARNING);
  end;
end;

function TDM.ConnDB: Boolean;
var
  sDBPath: string;
begin
  sDBPath := ExtractFilePath(ParamStr(0))+'Data.mdb';
  if Not FileExists(sDBPath) then
  begin
    Result := False;
    Exit;
  end;
  Conn.Connected := False;
  Conn.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+sDBPath+';Persist Security Info=False';
  Conn.Connected := True;
  Result := Conn.Connected;
end;

function TDM.OpenTable(sSQL: String; Query: TADOQuery): Integer;
begin
  Result := 0;
  with Query do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sSQL);
    Open;
    Result := RecordCount;
  end;
end;

end.
