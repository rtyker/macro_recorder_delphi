unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Menus, ComCtrls, ToolWin, ExtCtrls,
  AppEvnts, StdCtrls, Tabs;

type
  ThGravar = class(TThread)
  protected
    procedure Execute; override;
  public
    constructor Create();
  end;

  MouseLLHookStruct = record
    pt: TPoint;
    mouseData: cardinal;
    flags: cardinal;
    Time: cardinal;
    dwExtraInfo: cardinal;
  end;

  TForm1 = class(TForm)
    ListView1: TListView;
    StatusBar1: TStatusBar;
    Memo1: TMemo;
    popFile: TPopupMenu;
    New1: TMenuItem;
    Open1: TMenuItem;
    Recentfiles1: TMenuItem;
    N1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    N2: TMenuItem;
    Settings1: TMenuItem;
    N3: TMenuItem;
    Exit1: TMenuItem;
    pgPrincipal: TPageControl;
    tabFile: TTabSheet;
    tabRecordEdit: TTabSheet;
    tabPlayback: TTabSheet;
    tabHelp: TTabSheet;
    SaveDialog1: TSaveDialog;
    procedure ToolButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure pgPrincipalMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pgPrincipalDrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure PageControl1DrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure Open1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
  private
    vThread: ThGravar;
    FFile: String;
    procedure teste2;
  public

    { Public declarations }
  end;

var
  Form1: TForm1;
  OldCI: HICON;
  mHook: cardinal;

implementation

{$R *.dfm}

function LowLevelMouseHookProc(nCode, wParam, lParam: integer): integer; stdcall;
// possible wParam values: WM_LBUTTONDOWN, WM_LBUTTONUP, WM_MOUSEMOVE, WM_MOUSEWHEEL, WM_RBUTTONDOWN, WM_RBUTTONUP
var
  info: ^MouseLLHookStruct absolute lParam;
begin
  result := CallNextHookEx(mHook, nCode, wParam, lParam);
  with info^ do
  begin

    Form1.StatusBar1.SimpleText := 'X: ' + IntToStr(pt.x) + '  Y: ' + IntToStr(pt.y);
    case wParam of
      wm_lbuttondown:
        Form1.Memo1.Lines.Append(format('pressed left button (%d, %d)', [pt.x, pt.y]));
      wm_lbuttonup:
        Form1.Memo1.Lines.Append(format('released left button (%d, %d)', [pt.x, pt.y]));
      wm_mbuttondown:
        Form1.Memo1.Lines.Append(format('pressed middle button (%d, %d)', [pt.x, pt.y]));
      wm_mbuttonup:
        Form1.Memo1.Lines.Append(format('released middle button (%d, %d)', [pt.x, pt.y]));
      wm_rbuttondown:
        Form1.Memo1.Lines.Append(format('pressed right button (%d, %d)', [pt.x, pt.y]));
      wm_rbuttonup:
        Form1.Memo1.Lines.Append(format('released right button (%d, %d)', [pt.x, pt.y]));
      wm_mousewheel:
        begin
          if smallInt(mouseData shr 16) > 0
            then
            Form1.Memo1.Lines.Append('scrolled wheel (up)')
          else
            Form1.Memo1.Lines.Append('scrolled wheel (down)');
        end;
    end;
  end;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  vThread := ThGravar.Create;

  vThread.FreeOnTerminate := True;

  vThread.Resume;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  CI: TCursorInfo;
begin

  teste2;
  Exit;

  CI.cbSize := SizeOf(CI);
  GetCursorInfo(CI);
  if OldCI <> CI.hCursor then
  begin
    OldCI := CI.hCursor;
    Beep;
    Memo1.Lines.Add('coordinates X:' + inttostr(CI.ptScreenPos.X) + 'Y:' + inttostr(CI.ptScreenPos.X) + 'changed');
  end;
end;

procedure TForm1.teste2();
var
  Point: TPoint;
begin
  GetCursorPos(Point);

  Memo1.Lines.Add('coordinates X:' + inttostr(Point.X) + 'Y:' + inttostr(Point.X) + 'changed');


   {

   exemplo para simular o click

        GetCursorPos (Point); // Get the current mouse position
     SetCursorPos (Point.X-510, Point.Y); // move the mouse
     Mouse_event (MOUSEEVENTF_LEFTDOWN, 0,0,0,0); // simulate mouse button press release
  Mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
     SetCursorPos (Point.X, Point.Y); // returns to the original position

   }
end;



{ ThGravar }

constructor ThGravar.Create;
begin
  inherited Create(True);
  FreeOnTerminate := True;
  Priority := tpLower;
  Resume;
end;

procedure ThGravar.execute;
var
  sTeste: string;
begin
  sTeste := FloatToStr(Mouse.CursorPos.X);
  Form1.StatusBar1.Panels[0].Text := sTeste;

end;

procedure TForm1.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);

  procedure add(mensagem: string);
  begin
    Memo1.Lines.Add(mensagem);
  end;

begin
//
//  //Criar uma lista conforme documenta��o
//  case Msg.message of
//    WM_LBUTTONDOWN:      add('Clicou com o esquerdo');
//    WM_LBUTTONUP:      add('soltou com o esquerdo');
//    WM_RBUTTONUP: add('clicou com o direito');
//  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
const
  WH_MOUSE_LL = 14;
begin
  mHook := SetWindowsHookEx(WH_MOUSE_LL, @LowLevelMouseHookProc, HInstance, 0);

  pgPrincipal.OwnerDraw := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  UnhookWindowsHookEx(mHook);
end;

procedure TForm1.Open1Click(Sender: TObject);
var
  vOpen : TFileOpenDialog;
begin
  vOpen := TFileOpenDialog.Create(Self);
  if vOpen.Execute then
  begin
    Self.FFile := vOpen.FileName;
  end;

  FreeAndNil(vOpen);
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.pgPrincipalMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  CursorPos: TPoint;
begin
  GetCursorPos(CursorPos);

  if pgPrincipal.TabIndex = 0 then
  begin
    popFile.Popup(CursorPos.X,
      CursorPos.Y
      );
  end;
end;

procedure TForm1.Save1Click(Sender: TObject);
var
  vSave : TSaveDialog;
begin
  vSave := TSaveDialog.Create(Self);
  vSave.Execute();
  FreeAndNil(vSave);
end;

procedure TForm1.pgPrincipalDrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin

  Control.Canvas.FillRect(Rect);
  Control.Canvas.TextOut(Rect.left + 2, Rect.top + 2, TTabSheet(pgPrincipal.Pages[TabIndex]).Caption);

//the code below is works. It's a example for OwnerDrawing TPageControl

 { case TabIndex of      //quantidade de pages(abas) que ter� seu pagecontrol.

    0:
      Control.Canvas.brush.Color := clgreen;
    1:
      Control.Canvas.brush.Color := clred;
    2:
      Control.Canvas.brush.Color := clblue;
    3:
      Control.Canvas.brush.Color := clYellow;
    4:
      Control.Canvas.Font.Color := clMaroon;
    5:
      Control.Canvas.Font.Color := clWhite;
  end;

  Control.Canvas.FillRect(Rect);

  pgPrincipal.canvas.font.color := clblue;     //cor da aba do tabsheet

  Control.Canvas.TextOut(Rect.left + 2, Rect.top + 2, TTabSheet(pgPrincipal.Pages[TabIndex]).Caption);

  pgPrincipal.Pages[TabIndex].Font.Color := clblack;     //cor da fonte na "page" inteiira.


  Control.Canvas.Font.Style := [fsBold];

Control.Canvas.TextOut(Rect.left+5,Rect.top+3,pgPrincipal.Pages[tabindex].Caption);

pgPrincipal.Pages[TabIndex].Font.Color := Control.Canvas.Font.Color;
}
end;

procedure TForm1.PageControl1DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
  showmessage('oioioi');
end;

end.

