object FrmMostraPedido: TFrmMostraPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Pesquisa de Pedidos'
  ClientHeight = 411
  ClientWidth = 747
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlDados: TPanel
    Left = 0
    Top = 0
    Width = 747
    Height = 164
    Align = alTop
    TabOrder = 0
    DesignSize = (
      747
      164)
    object GrbDados: TGroupBox
      Left = 7
      Top = 5
      Width = 731
      Height = 153
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Dados do pedido '
      Enabled = False
      TabOrder = 0
      object Label1: TLabel
        Left = 41
        Top = 29
        Width = 87
        Height = 13
        Caption = '&C'#243'digo do Pedido:'
      end
      object Label2: TLabel
        Left = 51
        Top = 60
        Width = 77
        Height = 13
        Caption = '&Data do Pedido:'
      end
      object Label4: TLabel
        Left = 24
        Top = 123
        Width = 103
        Height = 13
        Caption = '&Valor Total da Venda:'
      end
      object Label3: TLabel
        Left = 38
        Top = 91
        Width = 88
        Height = 13
        Caption = 'C'#243'di&go do Cliente:'
      end
      object EdtCodPedido: TEdit
        Left = 133
        Top = 25
        Width = 74
        Height = 21
        Hint = 
          'Digite o c'#243'digo da venda ou clique no bot'#227'o pesquisar para abrir' +
          ' a janela de pesquisa.'
        Alignment = taRightJustify
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object EdtDataPedido: TEdit
        Left = 133
        Top = 56
        Width = 74
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 1
      end
      object EdtTotalPedido: TEdit
        Left = 133
        Top = 119
        Width = 76
        Height = 21
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 4
      end
      object EdtCodCliente: TEdit
        Left = 132
        Top = 89
        Width = 76
        Height = 21
        Alignment = taRightJustify
        TabOrder = 2
      end
      object LcbxNomeCliente: TDBLookupComboBox
        Left = 214
        Top = 89
        Width = 284
        Height = 21
        KeyField = 'COD_CLIENTE'
        ListField = 'DES_NOME'
        TabOrder = 3
      end
    end
  end
  object PnlGrid: TPanel
    Left = 0
    Top = 164
    Width = 747
    Height = 247
    Align = alClient
    Anchors = []
    TabOrder = 1
    ExplicitTop = 114
    ExplicitWidth = 725
    ExplicitHeight = 297
    DesignSize = (
      747
      247)
    object LblTotRegistros: TLabel
      Left = 191
      Top = 174
      Width = 65
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Contador: 0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 277
    end
    object GrbGrid: TGroupBox
      Left = 7
      Top = 6
      Width = 731
      Height = 236
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Itens do pedido '
      Enabled = False
      TabOrder = 0
      DesignSize = (
        731
        236)
      object DbGridItensPedido: TDBGrid
        Left = 10
        Top = 19
        Width = 715
        Height = 208
        Anchors = [akLeft, akRight, akBottom]
        DataSource = DsPedidoItem
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'DES_DESCRICAO'
            Title.Caption = 'Produto'
            Width = 249
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'VAL_QUANTIDADE'
            Title.Alignment = taCenter
            Title.Caption = 'Quantidade'
            Width = 81
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VAL_PRECOUNITARIO'
            Title.Alignment = taCenter
            Title.Caption = 'Pre'#231'o Unit'#225'rio'
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VAL_TOTALITEM'
            Title.Alignment = taCenter
            Title.Caption = 'Valor Total'
            Width = 101
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID_VENDA'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'COD_VENDA'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'COD_PRODUTO'
            Visible = False
          end>
      end
    end
  end
  object MTblPedidoItem: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 616
    Top = 271
    object MTblPedidoItemID_PEDIDO: TIntegerField
      FieldName = 'ID_PEDIDO'
    end
    object MTblPedidoItemCOD_PEDIDO: TIntegerField
      FieldName = 'COD_PEDIDO'
    end
    object MTblPedidoItemCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
      Required = True
    end
    object MTblPedidoItemDES_DESCRICAO: TStringField
      FieldName = 'DES_DESCRICAO'
      Size = 100
    end
    object MTblPedidoItemVAL_QUANTIDADE: TIntegerField
      FieldName = 'VAL_QUANTIDADE'
      Required = True
    end
    object MTblPedidoItemVAL_PRECOUNITARIO: TFloatField
      FieldName = 'VAL_PRECOUNITARIO'
      DisplayFormat = '##,###,##0.00'
    end
    object MTblPedidoItemVAL_TOTALITEM: TFloatField
      FieldName = 'VAL_TOTALITEM'
      DisplayFormat = '##,###,##0.00'
    end
  end
  object DsPedidoItem: TDataSource
    DataSet = MTblPedidoItem
    Left = 613
    Top = 335
  end
end
