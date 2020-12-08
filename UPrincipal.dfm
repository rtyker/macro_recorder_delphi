object Form1: TForm1
  Left = 192
  Top = 107
  Width = 829
  Height = 576
  Caption = 'Gravaodr de Macros'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    Left = 0
    Top = 89
    Width = 821
    Height = 422
    Align = alClient
    Columns = <
      item
        Caption = 'Action'
      end
      item
        Caption = 'Value'
      end
      item
        Caption = 'Label'
      end
      item
        Caption = 'Comment'
      end>
    TabOrder = 0
    ViewStyle = vsReport
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 821
    Height = 89
    Align = alTop
    TabOrder = 1
    object ToolBar1: TToolBar
      Left = 1
      Top = 1
      Width = 819
      Height = 87
      Align = alClient
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 71
      Caption = 'ToolBar1'
      Ctl3D = False
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Caption = 'Gravar'
        MenuItem = Gravar1
        OnClick = ToolButton1Click
      end
      object Label1: TLabel
        Left = 71
        Top = 0
        Width = 194
        Height = 21
        Caption = 'Label1'
      end
      object ToolButton2: TToolButton
        Left = 265
        Top = 0
        Caption = 'Tocar'
        MenuItem = ocar1
      end
      object ToolButton3: TToolButton
        Left = 336
        Top = 0
        Caption = 'Parar'
        MenuItem = Parar1
      end
      object ToolButton4: TToolButton
        Left = 407
        Top = 0
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object ToolButton5: TToolButton
        Left = 415
        Top = 0
        Caption = 'ToolButton5'
        ImageIndex = 3
      end
      object ToolButton6: TToolButton
        Left = 486
        Top = 0
        Caption = 'ToolButton6'
        ImageIndex = 4
      end
      object ToolButton7: TToolButton
        Left = 557
        Top = 0
        Caption = 'ToolButton7'
        ImageIndex = 5
      end
      object ToolButton8: TToolButton
        Left = 628
        Top = 0
        Caption = 'ToolButton8'
        ImageIndex = 6
      end
      object ToolButton9: TToolButton
        Left = 699
        Top = 0
        Caption = 'ToolButton9'
        ImageIndex = 7
      end
      object ToolButton10: TToolButton
        Left = 770
        Top = 0
        Width = 8
        Caption = 'ToolButton10'
        ImageIndex = 8
        Style = tbsSeparator
      end
      object ToolButton11: TToolButton
        Left = 778
        Top = 0
        Caption = 'ToolButton11'
        ImageIndex = 8
      end
      object ToolButton12: TToolButton
        Left = 849
        Top = 0
        Width = 8
        Caption = 'ToolButton12'
        ImageIndex = 9
        Style = tbsSeparator
      end
      object ToolButton13: TToolButton
        Left = 857
        Top = 0
        Caption = 'ToolButton13'
        ImageIndex = 9
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 511
    Width = 821
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object Memo1: TMemo
    Left = 80
    Top = 144
    Width = 665
    Height = 337
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object MainMenu1: TMainMenu
    Left = 400
    Top = 272
    object File1: TMenuItem
      Caption = 'File'
    end
    object GravareEditar1: TMenuItem
      Caption = 'Gravar e Editar'
      object ocar1: TMenuItem
        Caption = 'Tocar'
      end
      object Gravar1: TMenuItem
        Caption = 'Gravar'
      end
      object Parar1: TMenuItem
        Caption = 'Parar'
      end
    end
  end
end
