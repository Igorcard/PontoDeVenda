unit untConectarBanco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,System.IniFiles, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmConectarBanco = class(TForm)
    Shape1: TShape;
    Image1: TImage;
    edtDatabase: TLabeledEdit;
    edtUsuario: TLabeledEdit;
    edtPorta: TLabeledEdit;
    Shape2: TShape;
    btnConectar: TSpeedButton;
    edtSenha: TLabeledEdit;
    edtServer: TLabeledEdit;
    edtCaminho: TLabeledEdit;
    OpenDialog1: TOpenDialog;
    btnCaminhoDll: TSpeedButton;
    Shape3: TShape;
    btnSalvarDados: TSpeedButton;
    procedure btnConectarClick(Sender: TObject);
    procedure edtUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtPortaKeyPress(Sender: TObject; var Key: Char);
    procedure btnCaminhoDllClick(Sender: TObject);
    procedure btnSalvarDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtDatabaseKeyPress(Sender: TObject; var Key: Char);
    procedure edtCaminhoKeyPress(Sender: TObject; var Key: Char);
    procedure edtServerKeyPress(Sender: TObject; var Key: Char);
    procedure edtSenhaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    procedure ConectarBanco;
    { Public declarations }
  end;

var
  frmConectarBanco: TfrmConectarBanco;

implementation

{$R *.dfm}

uses untConexoes, untPrincipal;

procedure TfrmConectarBanco.btnConectarClick(Sender: TObject);
begin
  ConectarBanco;
end;

procedure TfrmConectarBanco.btnSalvarDadosClick(Sender: TObject);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  IniFile.WriteString('DatabaseConfig', 'Database', edtDatabase.Text);
  IniFile.WriteString('DatabaseConfig', 'Usuario', edtUsuario.Text);
  IniFile.WriteString('DatabaseConfig', 'Senha', edtSenha.Text);
  IniFile.WriteString('DatabaseConfig', 'Server', edtServer.Text);
  IniFile.WriteInteger('DatabaseConfig', 'Porta', StrToIntDef(edtPorta.Text, 3306));
  IniFile.WriteString('DatabaseConfig', 'Caminho', edtCaminho.Text);
  application.MessageBox('Configura��es Salvas!','Aviso - [Conex�o Banco de Dados]',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmConectarBanco.ConectarBanco;
var
  IniFile: TIniFile;
  DatabaseConfig, Usuario, Server, Caminho,Senha: string;
  Porta: Integer;
begin
  IniFile        := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  DatabaseConfig := IniFile.ReadString('DatabaseConfig', 'Database', '');
  Usuario        := IniFile.ReadString('DatabaseConfig', 'Usuario', '');
  Senha          := IniFile.ReadString('DatabaseConfig', 'Senha', '');
  Server         := IniFile.ReadString('DatabaseConfig', 'Server', '');
  Porta          := IniFile.ReadInteger('DatabaseConfig', 'Porta', 3306);
  Caminho        := IniFile.ReadString('DatabaseConfig', 'Caminho', '');

  with dmConexoes do
    begin
      FDConnection1.Connected := false;
      FDConnection1.Params.Clear;
      try
        FDConnection1.DriverName := 'MySQL';
        FDConnection1.Params.Add('Database=' + DatabaseConfig);
        FDConnection1.Params.Add('User_Name=' + Usuario);
        FDConnection1.Params.Add('Server=' + Server);
        FDConnection1.Params.Add('Port=' + IntToStr(Porta));
        FDConnection1.Params.Add('Library= ' + Caminho);
        FDConnection1.Params.Add('DriverID=MySQL');
        FDConnection1.Params.Add('Password='+edtsenha.text);
        FDConnection1.Connected := True;
        Application.MessageBox('Conectado Com Sucesso!','Aviso - [Conectar Banco]',MB_OK+MB_ICONINFORMATION);
        Close;
      except on E:Exception do
        begin
          Application.MessageBox(pchar('Erro ao Conectar no Banco de Dados: '+#13+e.message),'Aviso - [Conectar Banco]',MB_OK+MB_ICONWARNING);
        end;
      end;
    end;
end;

procedure TfrmConectarBanco.edtCaminhoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    btnCaminhoDllClick(Self);
  if key = #27 then
    edtServer.SetFocus;
end;

procedure TfrmConectarBanco.edtDatabaseKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    edtPorta.SetFocus;
end;

procedure TfrmConectarBanco.edtPortaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    edtUsuario.SetFocus;
  if key = #27 then
    edtDatabase.SetFocus;
end;

procedure TfrmConectarBanco.edtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    edtServer.SetFocus;
  if key = #27 then
    edtUsuario.SetFocus;
end;

procedure TfrmConectarBanco.edtServerKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    edtCaminho.SetFocus;
  if key = #27 then
    edtSenha.SetFocus;
end;

procedure TfrmConectarBanco.edtUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    edtSenha.SetFocus;
  if key = #27 then
    edtPorta.SetFocus;
end;

procedure TfrmConectarBanco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not dmConexoes.FDConnection1.Connected then
    frmPrincipal.Close;
end;

procedure TfrmConectarBanco.FormShow(Sender: TObject);
var
  IniFile: TIniFile;
begin
  IniFile          := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  edtDatabase.Text := IniFile.ReadString('DatabaseConfig', 'Database', '');
  edtUsuario.Text  := IniFile.ReadString('DatabaseConfig', 'Usuario', '');
  edtSenha.Text    := IniFile.ReadString('DatabaseConfig', 'Senha', '');
  edtServer.Text   := IniFile.ReadString('DatabaseConfig', 'Server', '');
  edtPorta.Text    := IniFile.ReadString('DatabaseConfig', 'Porta', '3306');
  edtCaminho.Text  := IniFile.ReadString('DatabaseConfig', 'Caminho', '');
end;

procedure TfrmConectarBanco.btnCaminhoDllClick(Sender: TObject);
begin
  OpenDialog1.Execute();
  edtCaminho.Text := OpenDialog1.FileName;
end;

end.
