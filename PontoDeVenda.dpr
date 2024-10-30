program PontoDeVenda;

uses
  Vcl.Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untConexoes in 'untConexoes.pas' {dmConexoes: TDataModule},
  untConectarBanco in 'untConectarBanco.pas' {frmConectarBanco};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdmConexoes, dmConexoes);
  Application.Run;
end.
