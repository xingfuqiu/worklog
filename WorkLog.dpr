program WorkLog;

uses
  Forms,
  uMain in 'uMain.pas' {Frm_Main},
  uDM in 'uDM.pas' {DM: TDataModule},
  uAddLog in 'uAddLog.pas' {Frm_AddLog};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'ÈÕÖ¾¼ÇÂ¼';
  Application.CreateForm(TFrm_Main, Frm_Main);
  Application.CreateForm(TDM, DM);

  Application.Run;
end.
