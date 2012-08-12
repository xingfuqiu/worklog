unit uAddLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, RzButton, StdCtrls, Mask, RzEdit, RzLabel,
  RzCmboBx, uDM;

type
  TFrm_AddLog = class(TForm)
    RzButton1: TRzButton;
    RzButton2: TRzButton;
    RzPanel1: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    cmb_Soft: TRzComboBox;
    cmb_Type: TRzComboBox;
    RzMemo1: TRzMemo;
    procedure FormCreate(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure RzButton2Click(Sender: TObject);
  private
    procedure InitSoftCmb;
  public
    { Public declarations }
  end;

var
  Frm_AddLog: TFrm_AddLog;

implementation

{$R *.dfm}

procedure TFrm_AddLog.FormCreate(Sender: TObject);
begin
  InitSoftCmb;
end;

procedure TFrm_AddLog.InitSoftCmb;
var
  sSQL: String;
begin
  sSQL := 'Select OpSoft From WorkLog Group By OpSoft';
  if DM.OpenTable(sSQL, DM.Query_Date) > 0 then
  begin
    cmb_Soft.Items.Clear;
    while not DM.Query_Date.Eof do
    begin
      cmb_Soft.Items.Add(DM.Query_Date.FieldByName('OpSoft').AsString);
      DM.Query_Date.Next;
    end;
  end;
end;

procedure TFrm_AddLog.RzButton1Click(Sender: TObject);
var
  sSQL: String;
begin
  if cmb_Soft.Text = '' then
  begin
    MessageBox(Handle, '软件模块未输入,请输入后再保存!', '提示', MB_OK+MB_ICONWARNING);
    Exit;
  end;
  if cmb_Type.Text = '' then
  begin
    MessageBox(Handle, '操作类型未输入,请输入后再保存!', '提示', MB_OK+MB_ICONWARNING);
    Exit;
  end;
  if RzMemo1.Text = '' then
  begin
    MessageBox(Handle, '操作内容未输入,请输入后再保存!', '提示', MB_OK+MB_ICONWARNING);
    Exit;
  end;
  sSQL := 'Insert into WorkLog(OpSoft, OpType, Log, OpDate) values ('''+
          cmb_Soft.Text+''', '+IntToStr(cmb_Type.ItemIndex)+', '''+RzMemo1.Text+
          ''', '''+FormatDateTime('yyyy-mm-dd hh:mm', Now)+''')';
  try
    DM.Conn.BeginTrans;
    DM.Conn.Execute(sSQL);
    DM.Conn.CommitTrans;
    MessageBox(Handle, '添加日志记录成功!', '提示', MB_OK+MB_ICONINFORMATION);
    Close;
  except
    DM.Conn.RollbackTrans;
    MessageBox(Handle, '添加日志记录失败,请重试!', '提示', MB_OK+MB_ICONWARNING);
  end;
end;

procedure TFrm_AddLog.RzButton2Click(Sender: TObject);
begin
  Close;
end;

end.
