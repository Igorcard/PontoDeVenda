unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    pnMid: TPanel;
    srcPedidosProdutos: TDataSource;
    GroupBox1: TGroupBox;
    DBGrid2: TDBGrid;
    GroupBox2: TGroupBox;
    Shape1: TShape;
    Shape2: TShape;
    edtQtd: TLabeledEdit;
    edtCodigo: TLabeledEdit;
    edtPreco: TLabeledEdit;
    edtTotal: TLabeledEdit;
    edtEnderecoCliente: TLabeledEdit;
    edtCodCliente: TLabeledEdit;
    edtNomeCliente: TLabeledEdit;
    Shape3: TShape;
    Label1: TLabel;
    lbTotalVenda: TLabel;
    GroupBox3: TGroupBox;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Shape4: TShape;
    Label3: TLabel;
    Shape5: TShape;
    btnFinalizar: TSpeedButton;
    Shape6: TShape;
    btnCancelar: TSpeedButton;
    Shape7: TShape;
    btnCarregarPedido: TSpeedButton;
    Shape8: TShape;
    btnCancelarPedido: TSpeedButton;
    srcProdutos: TDataSource;
    Label4: TLabel;
    lbNumeroPedido: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    btnInserirProduto: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtEnderecoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtNomeClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrecoKeyPress(Sender: TObject; var Key: Char);
    procedure edtTotalKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFinalizarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnCarregarPedidoClick(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure btnInserirProdutoClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure DBGrid2KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtQtdExit(Sender: TObject);
    procedure edtPrecoExit(Sender: TObject);
  private
    procedure HabilitaCampos(exibir:boolean);
    procedure LimpaVenda;
    function LocalizarVenda(NumPedido:integer;Excluir:Boolean): Boolean;
    procedure ExcluirVenda(NumPedido:Integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  chamada : string;

implementation

{$R *.dfm}

uses untConectarBanco, untConexoes;

procedure TfrmPrincipal.edtCodigoExit(Sender: TObject);
begin
  with dmConexoes do
    begin
      if edtCodigo.Text <> '' then
        begin
          try
            qrProdutos.Close;
            qrProdutos.SQL.Clear;
            qrProdutos.SQL.Add('SELECT * FROM PDV.PRODUTOS WHERE (CODIGO = :Codigo)');
            qrProdutos.ParamByName('Codigo').AsInteger := StrToInt(edtCodigo.Text);
            qrProdutos.Open;
          except on e:exception do
            begin
              qrProdutos.Close;
              qrProdutos.SQL.Clear;
              qrProdutos.SQL.Add('SELECT * FROM PDV.PRODUTOS');
              qrProdutos.Open;
              exit;
            end;
          end;

          if qrProdutos.IsEmpty then
            begin
              application.MessageBox('Produto N�o Encontrado!','Aviso - [Ponto de Venda]', MB_OK+MB_ICONWARNING);
              qrProdutos.Close;
              qrProdutos.SQL.Clear;
              qrProdutos.SQL.Add('SELECT * FROM PDV.PRODUTOS');
              qrProdutos.Open;
              exit;
            end;
          edtQtd.Text   := '1';
          edtPreco.Text := qrProdutos.FieldByName('PrecoVenda').AsString;
          edtTotal.Text := FloatToStr(StrToFloat(edtQtd.Text)*StrToFloat(edtPreco.Text));
        end
      else
        begin
          qrProdutos.Close;
          qrProdutos.SQL.Clear;
          qrProdutos.SQL.Add('SELECT * FROM PDV.PRODUTOS');
          qrProdutos.Open;
          edtQtd.Text   := '1';
          edtPreco.Text := '0';
          edtTotal.Text := '0';
        end;
    end;
end;

procedure TfrmPrincipal.edtCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_UP then
    dbGrid1.SetFocus;
  if key = VK_DOWN then
    dbGrid1.SetFocus;
end;

procedure TfrmPrincipal.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      with dmConexoes do
        begin
          if edtCodigo.Text <> '' then
            begin
              try
                qrProdutos.Close;
                qrProdutos.SQL.Clear;
                qrProdutos.SQL.Add('SELECT * FROM PDV.PRODUTOS WHERE (CODIGO = :Codigo)');
                qrProdutos.ParamByName('Codigo').AsInteger := StrToInt(edtCodigo.Text);
                qrProdutos.Open;
              except on e:exception do
                begin
                  Application.MessageBox('Produto N�o Encontrado!','Aviso - [Ponto de Venda]', MB_OK+MB_ICONWARNING);
                  qrProdutos.Close;
                  qrProdutos.SQL.Clear;
                  qrProdutos.SQL.Add('SELECT * FROM PDV.PRODUTOS');
                  qrProdutos.Open;
                  exit;
                end;
              end;

              if qrProdutos.IsEmpty then
                begin
                  application.MessageBox('Produto N�o Encontrado!','Aviso - [Ponto de Venda]', MB_OK+MB_ICONWARNING);
                  qrProdutos.Close;
                  qrProdutos.SQL.Clear;
                  qrProdutos.SQL.Add('SELECT * FROM PDV.PRODUTOS');
                  qrProdutos.Open;
                  exit;
                end;

              edtQtd.SetFocus;
              edtQtd.Text   := '1';
              edtPreco.Text := qrProdutos.FieldByName('PrecoVenda').AsString;
              edtTotal.Text := FloatToStr(StrToFloat(edtQtd.Text)*StrToFloat(edtPreco.Text));
            end
          else
            begin
              qrProdutos.Close;
              qrProdutos.SQL.Clear;
              qrProdutos.SQL.Add('SELECT * FROM PDV.PRODUTOS');
              qrProdutos.Open;
              edtQtd.Text   := '1';
              edtPreco.Text := '0';
              edtTotal.Text := '0';
            end;
        end;
    end;

  if key = #27 then
    begin
      edtEnderecoCliente.SetFocus;
      exit;
    end;
end;

procedure TfrmPrincipal.edtNomeClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    edtEnderecoCliente.SetFocus;
  if key = #27 then
    edtCodCliente.SetFocus;
end;

procedure TfrmPrincipal.edtPrecoExit(Sender: TObject);
begin
  if edtCodigo.Enabled then
    begin
      if edtPreco.Text = '' then
        edtPreco.Text := dmConexoes.qrProdutos.FieldByName('PrecoVenda').AsString;
      edtTotal.Text := FloatToStr(StrToFloat(edtQtd.Text)*StrToFloat(edtPreco.Text));
    end;
end;

procedure TfrmPrincipal.edtPrecoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', ',',#13,#27,#8,#9]) then
    begin
      Key := #0;
    end;

  if key = #13 then
    begin
      edtTotal.Text := FloatToStr(StrToFloat(edtQtd.Text)*StrToFloat(edtPreco.Text));
      edtTotal.SetFocus;
    end;

  if key = #27 then
    edtQtd.SetFocus;
end;

procedure TfrmPrincipal.edtQtdExit(Sender: TObject);
begin
  if edtCodigo.Enabled then
    begin
      if edtQtd.Text = '' then
        edtQtd.Text := '1';
      edtTotal.Text := FloatToStr(StrToFloat(edtQtd.Text)*StrToFloat(edtPreco.Text));
    end;
end;

procedure TfrmPrincipal.edtQtdKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', ',',#13,#27,#8,#9]) then
    begin
      Key := #0;
    end;

  if key = '0' then
    begin
      Application.MessageBox('Insira uma Quantidade Maior que Zero','Aviso - [Ponto de Venda]', MB_OK+MB_ICONWARNING);
      edtQtd.Text := '1';
      exit;
    end;

  if key = #13 then
    begin
      edtPreco.SetFocus;
      edtTotal.Text := FloatToStr(StrToFloat(edtQtd.Text)*StrToFloat(edtPreco.Text));
    end;

  if key = #27 then
    edtCodigo.SetFocus;
end;

procedure TfrmPrincipal.edtTotalKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
    begin
      edtPreco.SetFocus;
    end;
end;

procedure TfrmPrincipal.ExcluirVenda(NumPedido:Integer);
begin
  with dmConexoes do
    begin
      qrPedidosProdutos.Close;
      qrPedidosProdutos.SQL.Clear;
      qrPedidosProdutos.SQL.Add('SELECT * FROM PDV.PEDIDOSPRODUTOS WHERE (NUMEROPEDIDO = '+IntToStr(NumPedido)+')');
      qrPedidosProdutos.Open;

      if not qrPedidosProdutos.IsEmpty then
        begin
          qrPedidosProdutos.Close;
          qrPedidosProdutos.SQL.Clear;
          qrPedidosProdutos.SQL.Add('DELETE FROM PDV.PEDIDOSPRODUTOS WHERE (NUMEROPEDIDO = '+IntToStr(NumPedido)+')');
          qrPedidosProdutos.ExecSql;
        end;

      qrPedidosDadosGerais.Close;
      qrPedidosDadosGerais.SQL.Clear;
      qrPedidosDadosGerais.SQL.Add('DELETE FROM PDV.PEDIDOSDADOSGERAIS WHERE (NUMERO = '+IntToStr(NumPedido)+')');
      qrPedidosDadosGerais.ExecSQL;

      Application.MessageBox('Venda Cancelada!','Aviso - [Ponto de Venda]', MB_OK+MB_ICONINFORMATION);
    end;
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_f2 then
    edtCodCliente.SetFocus;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  Application.CreateForm(TfrmConectarBanco,frmConectarBanco);
  frmConectarBanco.ShowModal;
  frmConectarBanco.Free;
  edtCodCliente.SetFocus;
end;

procedure TfrmPrincipal.HabilitaCampos(exibir: boolean);
begin
  edtCodCliente.Enabled       := not exibir;
  edtCodigo.Enabled           := exibir;
  edtQtd.Enabled              := exibir;
  edtPreco.Enabled            := exibir;
  edtTotal.Enabled            := exibir;
  edtNomeCliente.Enabled      := exibir;
  edtEnderecoCliente.Enabled  := exibir;
  btnInserirProduto.Enabled   := exibir;
  DBGrid1.Enabled             := exibir;
  DBGrid2.Enabled             := exibir;
  btnFinalizar.Enabled        := exibir;
  btnCancelar.Enabled         := exibir;
  Label4.Visible              := exibir;
  lbNumeroPedido.Visible      := exibir;
  btnCarregarPedido.Enabled   := not exibir;
  btnCancelarPedido.Enabled   := not exibir;
end;

procedure TfrmPrincipal.LimpaVenda;
begin
  with dmConexoes do
    begin
      qrProdutos.Active        := false;
      qrPedidosProdutos.Active := false;
      qrClientes.Active        := false;
      lbTotalVenda.Caption     := 'R$0.00';
      edtCodigo.Text           := '';
      edtQtd.Text              := '';
      edtPreco.Text            := '';
      edtTotal.Text            := '';
      lbNumeroPedido.Caption   := '0';
      edtCodCliente.Text       := '';
      edtNomeCliente.Text      := '';
      edtEnderecoCliente.Text  := '';
      edtCodCliente.SetFocus;
    end;
end;

function TfrmPrincipal.LocalizarVenda(NumPedido:integer;Excluir:Boolean) : Boolean;
var
  Key : Char;
begin
  with dmConexoes do
    begin
      if not Excluir then
        HabilitaCampos(true);

      qrPedidosDadosGerais.Close;
      qrPedidosDadosGerais.SQL.Clear;
      qrPedidosDadosGerais.SQL.Add('SELECT * FROM PDV.PEDIDOSDADOSGERAIS WHERE (NUMERO = '+IntToStr(NumPedido)+')');
      qrPedidosDadosGerais.Open;

      if qrPedidosDadosGerais.IsEmpty then
        begin
          Application.MessageBox('Pedido N�o Encontrado!','Aviso - [Ponto de Venda]',MB_OK+MB_ICONWARNING);
          Result := false;
          exit;
        end;

      if not Excluir then
        begin
          qrPedidosProdutos.Close;
          qrPedidosProdutos.SQL.Clear;
          qrPedidosProdutos.SQL.Add('SELECT * FROM PDV.PEDIDOSPRODUTOS WHERE (NUMEROPEDIDO = '+IntToStr(NumPedido)+')');
          qrPedidosProdutos.Open;

          edtCodCliente.Text := qrPedidosDadosGerais.FieldByName('CodCliente').AsString;
          Key := #13;
          chamada := 'LocalizarVenda';
          edtCodClienteKeyPress(Self,Key);
          chamada := '';
          edtCodigo.SetFocus;
        end
      else
        begin
          ExcluirVenda(NumPedido);
        end;

      Result := true;
    end;
end;

procedure TfrmPrincipal.btnCancelarClick(Sender: TObject);
var
  NumPedido : Integer;
begin
  NumPedido := StrToInt(lbNumeroPedido.Caption);
  ExcluirVenda(NumPedido);
  HabilitaCampos(false);
  LimpaVenda;
end;

procedure TfrmPrincipal.btnCancelarPedidoClick(Sender: TObject);
var
  sNumPedido : String;
  iNumPedido : Integer;
begin
  repeat
    if InputQuery('Localizar Pedido', 'Digite o N�mero do Pedido:', sNumPedido) then
      begin
        if TryStrToInt(sNumPedido, iNumPedido) then
          begin
            if LocalizarVenda(iNumPedido,True) then
              Break;
          end
        else
          ShowMessage('Por favor, digite apenas n�meros.');
      end
    else
      Break;
  until False;
end;

procedure TfrmPrincipal.btnCarregarPedidoClick(Sender: TObject);
var
  sNumPedido : String;
  iNumPedido : Integer;
begin
  repeat
    if InputQuery('Localizar Pedido', 'Digite o N�mero do Pedido:', sNumPedido) then
      begin
        if TryStrToInt(sNumPedido, iNumPedido) then
          begin
            if LocalizarVenda(iNumPedido,False) then
              Break;
          end
        else
          ShowMessage('Por favor, digite apenas n�meros.');
      end
    else
      begin
        HabilitaCampos(false);
        Break;
      end;

  until False;
end;

procedure TfrmPrincipal.btnFinalizarClick(Sender: TObject);
begin
  with dmConexoes do
    begin
      qrPedidosDadosGerais.Edit;
      qrPedidosDadosGerais.FieldByName('VALORTOTAL').AsFloat := qrSomaProdutos.FieldByName('VALORTOTAL').AsFloat;
      qrPedidosDadosGerais.Post;
      application.MessageBox('Venda Finalizada!','Aviso - [Ponto de Venda]', MB_OK+MB_ICONINFORMATION);
      HabilitaCampos(false);
      LimpaVenda;
    end;
end;

procedure TfrmPrincipal.btnInserirProdutoClick(Sender: TObject);
begin
  if (edtCodigo.Text <> '') and
     (edtQtd.Text    <> '') and
     (edtPreco.Text  <> '') and
     (edtTotal.Text  <> '') then
  begin
    with dmConexoes do
      begin

        qrPedidosProdutos.Close;
        qrPedidosProdutos.SQL.Clear;
        qrPedidosProdutos.SQL.Add('SELECT * FROM PDV.PEDIDOSPRODUTOS WHERE (NUMEROPEDIDO = '+lbNumeroPedido.Caption+')');
        qrPedidosProdutos.Open;

        if qrPedidosProdutos.Locate('CodProduto',StrToInt(edtCodigo.Text)) then
          begin
            case Application.MessageBox('Deseja Duplicar o Item?','Aviso - [Ponto de Venda]', MB_YESNO+MB_ICONQUESTION) of
              idyes: qrPedidosProdutos.Insert;
              idno : qrPedidosProdutos.Edit;
            end;
          end
        else
          qrPedidosProdutos.Insert;

        if not (qrPedidosProdutos.State in [dsEdit, dsInsert]) then
          exit;

        qrPedidosProdutos.FieldByName('NUMEROPEDIDO').AsInteger := StrToInt(lbNumeroPedido.Caption);
        qrPedidosProdutos.FieldByName('CODPRODUTO').AsInteger   := qrProdutos.FieldByName('Codigo').AsInteger;
        qrPedidosProdutos.FieldByName('DESCRICAO').AsString     := qrProdutos.FieldByName('DESCRICAO').AsString;
        qrPedidosProdutos.FieldByName('QUANTIDADE').AsFloat     := StrToFloat(edtQtd.Text);
        qrPedidosProdutos.FieldByName('VlrUnitario').AsFloat    := StrToFloat(edtPreco.Text);
        qrPedidosProdutos.FieldByName('VlrTotal').AsFloat       := StrToFloat(edtTotal.Text);
        qrPedidosProdutos.Post;

        qrSomaProdutos.Close;
        qrSomaProdutos.SQL.Clear;
        qrSomaProdutos.SQL.Add('SELECT SUM(VLRTOTAL) AS VALORTOTAL FROM PDV.PEDIDOSPRODUTOS WHERE (NUMEROPEDIDO = '+lbNumeroPedido.Caption+')');
        qrSomaProdutos.Open;

        lbTotalVenda.Caption := FormatFloat('R$ ##0.00',qrSomaProdutos.FieldByName('VALORTOTAL').AsFloat);

        DBGrid2.Refresh;
      end;
    edtCodigo.SetFocus;
  end;

end;

procedure TfrmPrincipal.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      with dmConexoes do
        begin
          if qrProdutos.State in [dsEdit, dsInsert] then
            begin
              qrProdutos.Post;
              exit;
            end;
          edtCodigo.Text    := qrProdutos.FieldByName('CODIGO').AsString;
          edtQtd.Text       := '1';
          edtPreco.Text     := qrProdutos.FieldByName('PrecoVenda').AsString;
          edtCodigo.SetFocus;
        end;
    end;
end;

procedure TfrmPrincipal.DBGrid2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    begin
      case Application.MessageBox('Deseja Excluir o Item da Venda?','Aviso - [Ponto de Venda]', MB_YESNO+MB_ICONQUESTION) of
        idyes: begin
          with dmConexoes do
            begin
              qrPedidosProdutos.Delete;
              qrSomaProdutos.Close;
              qrSomaProdutos.SQL.Clear;
              qrSomaProdutos.SQL.Add('SELECT SUM(VLRTOTAL) AS VALORTOTAL FROM PDV.PEDIDOSPRODUTOS WHERE (NUMEROPEDIDO = '+lbNumeroPedido.Caption+')');
              qrSomaProdutos.Open;

              lbTotalVenda.Caption := FormatFloat('R$ ##0.00',qrSomaProdutos.FieldByName('VALORTOTAL').AsFloat);
            end;
        end;
      end;
      edtCodigo.SetFocus;
      DBGrid2.Refresh;
    end;
end;

procedure TfrmPrincipal.DBGrid2KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      edtCodigo.Text := dmConexoes.qrPedidosProdutos.FieldByName('CodProduto').AsString;
      edtCodigo.SetFocus;
    end;
end;

procedure TfrmPrincipal.edtCodClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', ',',#13,#27,#8,#9]) then
    begin
      Key := #0;
    end;

  if key = #13 then
    begin
      with dmConexoes do
        begin
          qrClientes.Close;
          qrClientes.SQL.Clear;
          qrClientes.SQL.Add('SELECT * FROM PDV.CLIENTES WHERE (CODIGO = '+edtCodCliente.Text+')');
          qrClientes.Open;

          if qrClientes.IsEmpty then
            begin
              application.MessageBox('C�digo N�o Encontrado!','Aviso - [Ponto de Venda]', MB_OK+MB_ICONINFORMATION);
              HabilitaCampos(false);
              exit;
            end;

          if chamada <> 'LocalizarVenda' then
            begin
              qrPedidosDadosGerais.Close;
              qrPedidosDadosGerais.SQL.Clear;
              qrPedidosDadosGerais.SQL.Add('SELECT * FROM PDV.PEDIDOSDADOSGERAIS LIMIT 1');
              qrPedidosDadosGerais.Open;

              qrPedidosDadosGerais.Insert;
              qrPedidosDadosGerais.FieldByName('CodCliente').AsInteger   := StrToInt(EdtCodCliente.Text);
              qrPedidosDadosGerais.Post;
            end
          else
            begin
              qrSomaProdutos.Close;
              qrSomaProdutos.SQL.Clear;
              qrSomaProdutos.SQL.Add('SELECT SUM(VLRTOTAL) AS VALORTOTAL FROM PDV.PEDIDOSPRODUTOS WHERE (NUMEROPEDIDO = '+lbNumeroPedido.Caption+')');
              qrSomaProdutos.Open;

              lbTotalVenda.Caption := FormatFloat('R$ ##0.00',qrSomaProdutos.FieldByName('VALORTOTAL').AsFloat);
            end;

          qrProdutos.Close;
          qrProdutos.SQL.Clear;
          qrProdutos.SQL.ADD('SELECT * FROM PDV.PRODUTOS');
          qrProdutos.Open;

          HabilitaCampos(true);
          Label4.Visible          := true;
          lbNumeroPedido.Caption  := qrPedidosDadosGerais.FieldByName('Numero').AsString;
          edtNomeCliente.Text     := qrClientes.FieldByName('Nome').AsString;
          edtEnderecoCliente.Text := qrClientes.FieldByName('Cidade').AsString+'/'+qrClientes.FieldByName('UF').AsString;
        end;
      edtNomeCliente.SetFocus;
    end;

end;

procedure TfrmPrincipal.edtEnderecoClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
     edtCodigo.SetFocus;
  if key = #27 then
    edtNomeCliente.SetFocus;
end;

end.
