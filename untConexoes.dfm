object dmConexoes: TdmConexoes
  OldCreateOrder = False
  Height = 459
  Width = 677
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=root'
      'DriverID=MySQL')
    Left = 128
    Top = 96
  end
  object qrClientes: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from pdv.clientes')
    Left = 128
    Top = 160
    object qrClientesCodigo: TFDAutoIncField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qrClientesNome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'Nome'
      Origin = 'Nome'
      Size = 100
    end
    object qrClientesCidade: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'Cidade'
      Origin = 'Cidade'
      Size = 50
    end
    object qrClientesUF: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UF'
      Origin = 'UF'
      Size = 2
    end
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    VendorLib = 'C:\Users\ACCESYS\Desktop\PDV\libmysql.dll'
    Left = 128
    Top = 48
  end
  object qrProdutos: TFDQuery
    Connection = FDConnection1
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    SQL.Strings = (
      'select * from pdv.produtos')
    Left = 128
    Top = 216
    object qrProdutosCodigo: TFDAutoIncField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qrProdutosDescricao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 200
    end
    object qrProdutosPrecoVenda: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'PrecoVenda'
      Origin = 'PrecoVenda'
      DisplayFormat = 'R$#0.00'
      Precision = 18
      Size = 2
    end
  end
  object qrAlteraProdutos: TFDQuery
    Connection = FDConnection1
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    SQL.Strings = (
      'select * from pdv.produtos')
    Left = 208
    Top = 216
    object FDAutoIncField1: TFDAutoIncField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object StringField1: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 200
    end
    object BCDField1: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'PrecoVenda'
      Origin = 'PrecoVenda'
      DisplayFormat = 'R$#0.00'
      Precision = 18
      Size = 2
    end
  end
  object qrPedidosDadosGerais: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from pdv.pedidosdadosgerais')
    Left = 48
    Top = 159
    object qrPedidosDadosGeraisNumero: TFDAutoIncField
      FieldName = 'Numero'
    end
    object qrPedidosDadosGeraisCodCliente: TIntegerField
      FieldName = 'CodCliente'
    end
    object qrPedidosDadosGeraisDataEmissao: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'DataEmissao'
      Origin = 'DataEmissao'
    end
    object qrPedidosDadosGeraisValorTotal: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'ValorTotal'
      Origin = 'ValorTotal'
      Precision = 18
      Size = 2
    end
  end
  object qrPedidosProdutos: TFDQuery
    Connection = FDConnection1
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    SQL.Strings = (
      'select * from pdv.pedidosprodutos')
    Left = 47
    Top = 216
    object qrPedidosProdutosCodigo: TFDAutoIncField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qrPedidosProdutosNumeroPedido: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'NumeroPedido'
      Origin = 'NumeroPedido'
    end
    object qrPedidosProdutosCodProduto: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'CodProduto'
      Origin = 'CodProduto'
    end
    object qrPedidosProdutosQuantidade: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'Quantidade'
      Origin = 'Quantidade'
      Precision = 18
      Size = 2
    end
    object qrPedidosProdutosVlrUnitario: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VlrUnitario'
      Origin = 'VlrUnitario'
      Precision = 18
      Size = 2
    end
    object qrPedidosProdutosVlrTotal: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VlrTotal'
      Origin = 'VlrTotal'
      Precision = 18
      Size = 2
    end
    object qrPedidosProdutosDescricao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 200
    end
  end
  object qrSomaProdutos: TFDQuery
    Connection = FDConnection1
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    SQL.Strings = (
      'select sum(vlrtotal) as ValorTotal from pdv.pedidosprodutos')
    Left = 207
    Top = 160
    object qrSomaProdutosValorTotal: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'ValorTotal'
      Origin = 'ValorTotal'
      ProviderFlags = []
      ReadOnly = True
      Precision = 40
      Size = 2
    end
  end
end
