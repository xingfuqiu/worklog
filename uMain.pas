unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, RzListVw, ExtCtrls, RzTreeVw, RzPanel, RzButton, ImgList,
  uDM, DateUtils;

type
  TFrm_Main = class(TForm)
    imgList_ToolBar: TImageList;
    RzPanel1: TRzPanel;
    RzPanel3: TRzPanel;
    tbar_Oper: TRzToolbar;
    lv_Log: TRzListView;
    RzToolButton2: TRzToolButton;
    RzSpacer1: TRzSpacer;
    RzToolButton4: TRzToolButton;
    RzToolButton5: TRzToolButton;
    RzToolButton6: TRzToolButton;
    RzToolButton1: TRzToolButton;
    RzToolButton7: TRzToolButton;
    RzToolButton3: TRzToolButton;
    procedure FormShow(Sender: TObject);
    procedure lv_LogAdvancedCustomDrawItem(Sender: TCustomListView; Item:
        TListItem; State: TCustomDrawState; Stage: TCustomDrawStage; var
        DefaultDraw: Boolean);
    procedure lv_LogDblClick(Sender: TObject);
    procedure RzToolButton1Click(Sender: TObject);
    procedure RzToolButton2Click(Sender: TObject);
    procedure RzToolButton3Click(Sender: TObject);
    procedure RzToolButton4Click(Sender: TObject);
    procedure RzToolButton5Click(Sender: TObject);
    procedure RzToolButton6Click(Sender: TObject);
    procedure RzToolButton7Click(Sender: TObject);
  private
    procedure InitLogList(iType: Integer = 9);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Main: TFrm_Main;

implementation

uses uAddLog;

{$R *.dfm}

procedure TFrm_Main.FormShow(Sender: TObject);
begin
  RzToolButton1.Down := True;
  InitLogList;
end;

procedure TFrm_Main.InitLogList(iType: Integer = 9);
var
  sSQL: String;
  Item: TListItem;
begin
  case iType of
    0: sSQL := 'Select * from WorkLog where OpType = 0 Order By OpDate DESC';
    1: sSQL := 'Select * from WorkLog where OpType = 1 Order By OpDate DESC';
    2: sSQL := 'Select * from WorkLog where OpType = 2 Order By OpDate DESC';
    3: sSQL := 'Select * from WorkLog where OpDate Between #'+FormatDateTime('yyyy-mm-dd 00:00:00', Now)+'# and #'+FormatDateTime('yyyy-mm-dd 23:59:59', Now)+'# Order By OpDate DESC'
    else
      sSQL := 'Select * from WorkLog Order By OpDate DESC';    
  end;

  lv_Log.Items.Clear;
  if DM.OpenTable(sSQL, DM.Query_Log) > 0 then
  begin
    With DM.Query_Log do
    begin
      lv_Log.Items.BeginUpdate;
      while Not Eof do
      begin
        Item := lv_Log.Items.Add;
        Item.Caption :=  FieldByName('OpSoft').AsString;
        Item.SubItems.Add(FieldByName('Log').AsString);
        Item.SubItems.Add(FormatDateTime('yyy-MM-dd hh:mm', FieldByName('OpDate').AsDateTime));
        Item.ImageIndex := FieldByName('OpType').AsInteger;
        Next;
      end;
      lv_Log.Items.EndUpdate;
    end;
  end;
end;

procedure TFrm_Main.lv_LogAdvancedCustomDrawItem(Sender: TCustomListView; Item:
    TListItem; State: TCustomDrawState; Stage: TCustomDrawStage; var
    DefaultDraw: Boolean);
begin
  //默认隔行颜色
  if Item.Index mod 2 = 0 then
    Sender.Canvas.Brush.Color := $00E6F0F0
  else
    Sender.Canvas.Brush.Color := clWhite;
end;

procedure TFrm_Main.lv_LogDblClick(Sender: TObject);
var
  Item: TListItem;
begin
  //双击列表项,显示详细信息
  Item := lv_Log.Selected;
  if Item = nil then Exit;
  frm_AddLog := TFrm_AddLog.Create(Self);
  try
    Frm_AddLog.RzButton1.Enabled := False;   //保存不可用
    Frm_AddLog.cmb_Soft.ItemIndex := Frm_AddLog.cmb_Soft.IndexOf(Item.Caption);
    Frm_AddLog.cmb_Type.ItemIndex := Item.ImageIndex;
    Frm_AddLog.RzMemo1.Text := Item.SubItems[0];
    Frm_AddLog.ShowModal;
  finally
    Frm_AddLog.Free;
  end;
end;

procedure TFrm_Main.RzToolButton1Click(Sender: TObject);
begin
  TRzToolButton(Sender).Down := True;
  InitLogList;
end;

procedure TFrm_Main.RzToolButton2Click(Sender: TObject);
begin
  frm_AddLog := TFrm_AddLog.Create(Self);
  try
    Frm_AddLog.ShowModal;
    RzToolButton1.Down := True;
    InitLogList;
  finally
    Frm_AddLog.Free;                          
  end;
end;

procedure TFrm_Main.RzToolButton3Click(Sender: TObject);
begin
  Close;
end;

procedure TFrm_Main.RzToolButton4Click(Sender: TObject);
begin
  TRzToolButton(Sender).Down := True;
  InitLogList(0);
end;

procedure TFrm_Main.RzToolButton5Click(Sender: TObject);
begin
  TRzToolButton(Sender).Down := True;
  InitLogList(1);
end;

procedure TFrm_Main.RzToolButton6Click(Sender: TObject);
begin
  TRzToolButton(Sender).Down := True;
  InitLogList(2);
end;

procedure TFrm_Main.RzToolButton7Click(Sender: TObject);
begin
  InitLogList(3);
end;

end.
