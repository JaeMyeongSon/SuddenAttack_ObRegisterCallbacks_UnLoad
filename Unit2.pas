unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,ShellAPI, Vcl.StdCtrls,WinHttp_TLB,
  Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    LOGIN_BOX: TGroupBox;
    ID_TEXT: TEdit;
    PW_TEXT: TEdit;
    CODE_TEXT: TEdit;
    LOGIN_BUTTON: TButton;
    REGISTER: TButton;
    CODE_DATE: TEdit;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure LOGIN_BUTTONClick(Sender: TObject);
    procedure REGISTERClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
    A : Cardinal;

implementation

{$R *.dfm}


Procedure Wait2(milliseconds: integer);
var dTime: DWORD;
begin
  dTime:= GetTickCount;
  while GetTickCount <= (dTime + milliseconds) do
  begin
    Application.ProcessMessages;
  end;
end;

Procedure SmoothComponent(Target: AnsiString; Speed: Byte);
var MyComponent: TComponent;
    save, val, ScaleWidth: integer;
    squareroot: single;
    rc: TRect;
begin
  with Form2 do
  begin
    MyComponent:= FindComponent(Target);
    if MyComponent is TControl then
    begin
      save:= TControl(MyComponent).Left;
      Rc:= GetClientRect;
      ScaleWidth:= rc.Right - rc.Left;
      TControl(MyComponent).Left:= ScaleWidth;
      while(true) do
      begin
        squareroot:= Sqrt(TControl(MyComponent).Left);
        val:= TControl(MyComponent).Left div Speed;
        TControl(MyComponent).Left:= (TControl(MyComponent).Left - val) - round(squareroot);
        if TControl(MyComponent).Left <= save then
        begin
          TControl(MyComponent).Left:= save;
          break;
        end;
        Wait2(15);
      end;
    end;
  end;
end;


procedure TForm2.Button1Click(Sender: TObject);
begin
ShellExecute(Form2.HANDLE, 'OPEN', 'cmd.exe', '/C sc create Memory binpath= C:\Windows\KodeMonL.sys type= kernel', Nil, SW_HIDE);     //성능  sc start Memory
ShellExecute(Form2.HANDLE, 'OPEN', 'cmd.exe', '/C sc start Memory', Nil, SW_HIDE);     //성능
end;

procedure TForm2.LOGIN_BUTTONClick(Sender: TObject);
var
  WinHttp, WinHttp1: IWinHttpRequest;
  WinhttpDate : String;
begin
  WinHttp := coWinHttpRequest.Create;
  WinHttp1 := coWinHttpRequest.Create;
    try
      WinHttp.Open('GET', 'http://galaxys.dothome.co.kr/login.php?id=' +ID_TEXT.Text + '&pw=' + PW_TEXT.Text, False);
      WinHttp.Send(EmptyParam);
        if WinHttp.ResponseText = 'OK' then begin
        //로그인을 성공했을 경우
        ShowMessage('로그인 성공 !');
        LOGIN_BOX.Visible := False;
        LOGIN_BOX.Enabled := False;

       // FUNTION_BOX.Visible := True;
        SmoothComponent('LoginBox', 200);
       // FUNTION_BOX.Enabled := True;
        end else

        begin
          WinHttp1.Open('GET', 'http://galaxys.dothome.co.kr/getdate.php?id='+ID_TEXT.Text, False);
          WinHttp1.Send(EmptyParam);
          WinhttpDate := Winhttp1.ResponseText;

        if WinhttpDate = '' then begin
        //로그인을 시도한 계정의 아이디가 서버에 등록되어 있지 않다면
        ShowMessage('접속이 차단되었습니다');
        end else

        if WinhttpDate < datetostr(now) then begin
        //사용기간이 만료되었거나 접속이 차단되었을 경우
        ShowMessage('기간이 만료되었습니다');
        end;
      end;
    except
  end;
end;

procedure TForm2.REGISTERClick(Sender: TObject);
var
  WinHttp: IWinHttpRequest;
  WinHttp1: IWinHttpRequest;
  WinHttp2: IWinHttpRequest;
  WinHttp3: IWinHttpRequest;
  WinHttp4: IWinHttpRequest;
begin
  WinHttp := coWinHttpRequest.Create;
  WinHttp1 := coWinHttpRequest.Create;
  WinHttp2 := coWinHttpRequest.Create;
  WinHttp3 := coWinHttpRequest.Create;
  WinHttp4 := coWinHttpRequest.Create;
  WinHttp.Open('GET', 'http://galaxys.dothome.co.kr/login_code.php?id=' +CODE_TEXT.Text + '&pw=' + CODE_TEXT.Text, False);
  WinHttp.Send(EmptyParam);

    if WinHttp.ResponseText = 'OK' then begin
      WinHttp1.Open('GET', 'http://galaxys.dothome.co.kr/getdate_code.php?id='+CODE_TEXT.Text, False);
      WinHttp1.Send(EmptyParam);
      CODE_DATE.Text := Winhttp1.ResponseText;
      WinHttp2.Open('GET', 'http://galaxys.dothome.co.kr/del_code.php?id=' +CODE_TEXT.Text, False);
      WinHttp2.Send(EmptyParam);

    if WinHttp2.ResponseText = 'OK' then begin
      WinHttp3.Open('GET', 'http://galaxys.dothome.co.kr/join.php?id=' +ID_TEXT.Text +'&pw=' +PW_TEXT.Text, False);
      WinHttp3.Send(EmptyParam);

    if WinHttp3.ResponseText = 'OK' then
      WinHttp4.Open('GET', 'http://galaxys.dothome.co.kr/allow.php?id=' +ID_TEXT.Text +'&dt=' +CODE_DATE.Text, False);
      WinHttp4.Send(EmptyParam);

    if WinHttp4.ResponseText = 'OK' then
      MessageBox(0,pchar('회원가입완료!'),pchar('PIXEL WORLD'),mb_iconinformation);
      CODE_TEXT.Text := '';
      CODE_DATE.Text := '';
    end else
   //입력한 시리얼 번호가 서버에 등록되어 있지 않을때
   ShowMessage('입력하신 코드가 맞지 않습니다');
  end;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
var
  Winhttp : IWinHttpRequest;
  begin
    Winhttp := coWinHttpRequest.Create;
    Winhttp.Open('GET','http://crcserver.dothome.co.kr/on.txt', false);
    Winhttp.send('');
  if AnsiPos('((on))',winhttp.responsetext) <> 0 then

  begin
    Form2.Enabled := true;
    Timer1.Enabled := false;

end else
    begin// 아닐시에는
      Form2.Enabled := False;
     begin
        Application.Terminate;
      end;
    end;
end;

end.
