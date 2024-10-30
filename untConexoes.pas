unit untConexoes;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, VCL.Forms;

type
  TdmConexoes = class(TDataModule)
    FDConnection1: TFDConnection;
    qrClientes: TFDQuery;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    qrProdutos: TFDQuery;
    qrProdutosCodigo: TFDAutoIncField;
    qrProdutosDescricao: TStringField;
    qrProdutosPrecoVenda: TBCDField;
    qrAlteraProdutos: TFDQuery;
    FDAutoIncField1: TFDAutoIncField;
    StringField1: TStringField;
    BCDField1: TBCDField;
    qrPedidosDadosGerais: TFDQuery;
    qrPedidosProdutos: TFDQuery;
    qrClientesCodigo: TFDAutoIncField;
    qrClientesNome: TStringField;
    qrClientesCidade: TStringField;
    qrClientesUF: TStringField;
    qrPedidosDadosGeraisNumero: TFDAutoIncField;
    qrPedidosDadosGeraisCodCliente: TIntegerField;
    qrSomaProdutos: TFDQuery;
    qrSomaProdutosValorTotal: TFMTBCDField;
    qrPedidosDadosGeraisDataEmissao: TDateTimeField;
    qrPedidosDadosGeraisValorTotal: TBCDField;
    qrPedidosProdutosCodigo: TFDAutoIncField;
    qrPedidosProdutosNumeroPedido: TIntegerField;
    qrPedidosProdutosCodProduto: TIntegerField;
    qrPedidosProdutosQuantidade: TBCDField;
    qrPedidosProdutosVlrUnitario: TBCDField;
    qrPedidosProdutosVlrTotal: TBCDField;
    qrPedidosProdutosDescricao: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmConexoes: TdmConexoes;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
