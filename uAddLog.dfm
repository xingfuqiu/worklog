object Frm_AddLog: TFrm_AddLog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #26032#22686#26085#24535
  ClientHeight = 258
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RzButton1: TRzButton
    Left = 263
    Top = 224
    Caption = #28155#21152
    TabOrder = 0
    OnClick = RzButton1Click
  end
  object RzButton2: TRzButton
    Left = 344
    Top = 224
    Caption = #21462#28040
    TabOrder = 1
    OnClick = RzButton2Click
  end
  object RzPanel1: TRzPanel
    Left = 8
    Top = 8
    Width = 411
    Height = 210
    BorderOuter = fsFlatRounded
    TabOrder = 2
    object RzLabel1: TRzLabel
      Left = 16
      Top = 16
      Width = 48
      Height = 13
      Caption = #36719#20214#27169#22359
    end
    object RzLabel2: TRzLabel
      Left = 215
      Top = 16
      Width = 48
      Height = 13
      Caption = #25805#20316#31867#22411
    end
    object RzLabel3: TRzLabel
      Left = 16
      Top = 44
      Width = 48
      Height = 13
      Caption = #26356#26032#20869#23481
    end
    object cmb_Soft: TRzComboBox
      Left = 70
      Top = 13
      Width = 129
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object cmb_Type: TRzComboBox
      Left = 270
      Top = 13
      Width = 129
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      Text = #26032#22686
      Items.Strings = (
        #26032#22686
        #20462#25913
        #21024#38500)
      ItemIndex = 0
    end
    object RzMemo1: TRzMemo
      Left = 71
      Top = 44
      Width = 328
      Height = 157
      ScrollBars = ssVertical
      TabOrder = 2
      FrameVisible = True
    end
  end
end
