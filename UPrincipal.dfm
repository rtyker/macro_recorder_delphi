object Form1: TForm1
  Left = 511
  Top = 84
  Caption = 'Gravaodr de Macros'
  ClientHeight = 677
  ClientWidth = 821
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    Left = 0
    Top = 146
    Width = 528
    Height = 512
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
    ExplicitTop = 338
    ExplicitWidth = 821
    ExplicitHeight = 320
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 658
    Width = 821
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = True
  end
  object Memo1: TMemo
    Left = 528
    Top = 146
    Width = 293
    Height = 512
    Align = alRight
    TabOrder = 2
  end
  object pgPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 821
    Height = 146
    ActivePage = tabFile
    Align = alTop
    OwnerDraw = True
    TabOrder = 3
    OnDrawTab = pgPrincipalDrawTab
    OnMouseDown = pgPrincipalMouseDown
    object tabFile: TTabSheet
      Caption = 'File'
      ExplicitHeight = 73
    end
    object tabRecordEdit: TTabSheet
      Caption = 'Record and Edit'
      ImageIndex = 1
      ExplicitHeight = 165
    end
    object tabPlayback: TTabSheet
      Caption = 'Playback'
      ImageIndex = 2
      ExplicitHeight = 165
    end
    object tabHelp: TTabSheet
      Caption = 'Help'
      ImageIndex = 3
      ExplicitHeight = 165
    end
  end
  object popFile: TPopupMenu
    Left = 64
    Top = 56
    object New1: TMenuItem
      Caption = '&New'
    end
    object Open1: TMenuItem
      Caption = '&Open'
      OnClick = Open1Click
    end
    object Recentfiles1: TMenuItem
      Caption = '&Recent files'
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Save1: TMenuItem
      Caption = '&Save'
      OnClick = Save1Click
    end
    object SaveAs1: TMenuItem
      Caption = '&Save &As'
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Settings1: TMenuItem
      Caption = 'Settings'
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Exit1: TMenuItem
      Caption = '&Exit'
      OnClick = Exit1Click
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 400
    Top = 336
  end
end
