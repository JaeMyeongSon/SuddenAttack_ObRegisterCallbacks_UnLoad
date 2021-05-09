unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,ShellAPI, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
ShellExecute(Form2.HANDLE, 'OPEN', 'cmd.exe', '/C sc create Memory binpath= C:\Windows\KodeMonL.sys type= kernel', Nil, SW_HIDE);     
ShellExecute(Form2.HANDLE, 'OPEN', 'cmd.exe', '/C sc start Memory', Nil, SW_HIDE);   
end;

end.
