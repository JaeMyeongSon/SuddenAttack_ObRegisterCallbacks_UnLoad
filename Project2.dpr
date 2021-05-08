program Project2;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  WinHttp_TLB in '..\로그인_코드발급기\코드발급기\WinHttp_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
