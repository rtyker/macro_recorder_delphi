unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, ExtCtrls, AppEvnts, StdCtrls;




type
  ThGravar = class(TThread)
  protected
    procedure Execute; override;
  public
    constructor Create();
  end;

  MouseLLHookStruct = record
    pt          : TPoint;
    mouseData   : cardinal;
    flags       : cardinal;
    time        : cardinal;
    dwExtraInfo : cardinal;
  end;



  TForm1 = class(TForm)
    ListView1: TListView;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    GravareEditar1: TMenuItem;
    ocar1: TMenuItem;
    Gravar1: TMenuItem;
    Parar1: TMenuItem;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    StatusBar1: TStatusBar;
    Memo1: TMemo;
    Label1: TLabel;
    procedure ToolButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    vThread : ThGravar;
    procedure teste2;

  public

    { Public declarations }
  end;

var
  Form1: TForm1;
  OldCI:HICON;
  mHook : cardinal;

implementation

{$R *.dfm}



function LowLevelMouseHookProc(nCode, wParam, lParam : integer) : integer; stdcall;
// possible wParam values: WM_LBUTTONDOWN, WM_LBUTTONUP, WM_MOUSEMOVE, WM_MOUSEWHEEL, WM_RBUTTONDOWN, WM_RBUTTONUP
var
  info : ^MouseLLHookStruct absolute lParam;
begin
  result := CallNextHookEx(mHook, nCode, wParam, lParam);
  with info^ do begin
    Form1.Label1.Caption := 'X: '+IntToStr(pt.x)+'  Y: '+ IntToStr(pt.y);
    case wParam of
      wm_lbuttondown : Form1.Memo1.Lines.Append(format('pressed left button (%d, %d)'    , [pt.x, pt.y]));
      wm_lbuttonup   : Form1.Memo1.Lines.Append(format('released left button (%d, %d)'   , [pt.x, pt.y]));
      wm_mbuttondown : Form1.Memo1.Lines.Append(format('pressed middle button (%d, %d)'  , [pt.x, pt.y]));
      wm_mbuttonup   : Form1.Memo1.Lines.Append(format('released middle button (%d, %d)' , [pt.x, pt.y]));
      wm_rbuttondown : Form1.Memo1.Lines.Append(format('pressed right button (%d, %d)'   , [pt.x, pt.y]));
      wm_rbuttonup   : Form1.Memo1.Lines.Append(format('released right button (%d, %d)'  , [pt.x, pt.y]));
      wm_mousewheel  : begin
        if smallInt(mouseData shr 16) > 0
        then Form1.Memo1.Lines.Append('scrolled wheel (up)')
        else Form1.Memo1.Lines.Append('scrolled wheel (down)');
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
  exit;

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
  Point : TPoint;
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
  sTeste : String;
begin
  sTeste :=   FloatToStr(Mouse.CursorPos.X);
  Form1.StatusBar1.Panels[0].Text := sTeste;
  Form1.Panel1.Caption := 'lul';
end;



procedure TForm1.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
  procedure add(mensagem : string);
  begin
    Memo1.Lines.Add(mensagem);
  end;
begin
//
//  //Criar uma lista conforme documentação
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
   mHook := SetWindowsHookEx(WH_MOUSE_LL, @LowLevelMouseHookProc, hInstance, 0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  UnhookWindowsHookEx(mHook);
end;

end.
