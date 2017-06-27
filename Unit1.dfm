object Form1: TForm1
  Left = 1323
  Top = 141
  ActiveControl = Button1
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  Caption = 'DeskChanger'
  ClientHeight = 481
  ClientWidth = 313
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowFrame
  Font.Height = -11
  Font.Name = 'Microsoft Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 5
    Top = 30
    Width = 125
    Height = 13
    Caption = #1055#1086#1089#1083#1077#1076#1085#1077#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077': '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label6: TLabel
    Left = 191
    Top = 72
    Width = 58
    Height = 13
    Caption = #1055#1086#1076#1076#1077#1088#1078#1082#1072
    Color = clWhite
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
    OnClick = Label6Click
    OnContextPopup = Label6ContextPopup
    OnMouseEnter = Label6MouseEnter
    OnMouseLeave = Label6MouseLeave
  end
  object Label2: TLabel
    Left = 5
    Top = 72
    Width = 111
    Height = 13
    Hint = #1045#1089#1090#1100' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1099',  '#1085#1072#1078#1084#1080#1090#1077' '#1095#1090#1086#1073#1099' '#1086#1073#1085#1086#1074#1080#1090#1100
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1087#1088#1086#1075#1088#1072#1084#1084#1091'!'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Visible = False
    OnClick = Label2Click
    OnMouseDown = Label2MouseDown
    OnMouseUp = Label2MouseUp
    OnMouseEnter = Label2MouseEnter
    OnMouseLeave = Label2MouseLeave
  end
  object Label7: TLabel
    Left = 252
    Top = 72
    Width = 55
    Height = 13
    Hint = #1055#1050#1052' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1074#1089#1077#1093' '#1085#1072#1089#1090#1088#1086#1077#1082
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = Label7Click
    OnContextPopup = Label7ContextPopup
    OnMouseEnter = Label7MouseEnter
    OnMouseLeave = Label7MouseLeave
  end
  object Label3: TLabel
    Left = 5
    Top = 274
    Width = 32
    Height = 13
    Caption = 'Debug'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label5: TLabel
    Left = 119
    Top = 72
    Width = 68
    Height = 13
    Caption = #1050#1072#1088#1090#1072' '#1074#1077#1090#1088#1086#1074
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = Label5Click
    OnMouseEnter = Label5MouseEnter
    OnMouseLeave = Label5MouseLeave
  end
  object Label8: TLabel
    Left = 275
    Top = 30
    Width = 14
    Height = 13
    Caption = 'Ru'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = Label8Click
    OnMouseEnter = Label8MouseEnter
    OnMouseLeave = Label8MouseLeave
  end
  object Label9: TLabel
    Left = 292
    Top = 30
    Width = 13
    Height = 13
    Caption = 'En'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = Label9Click
    OnMouseEnter = Label9MouseEnter
    OnMouseLeave = Label9MouseLeave
  end
  object Label1: TLabel
    Left = 8
    Top = 212
    Width = 115
    Height = 13
    Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = cl3DDkShadow
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 8
    Top = 251
    Width = 66
    Height = 13
    Caption = 'FTP '#1053#1062' '#1054#1052#1047
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = Label10Click
    OnMouseEnter = Label10MouseEnter
    OnMouseLeave = Label10MouseLeave
  end
  object GroupBox1: TGroupBox
    Left = 147
    Top = 120
    Width = 161
    Height = 76
    Caption = #1055#1088#1086#1082#1089#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
  object Button1: TButton
    Tag = 1
    Left = 2
    Top = 88
    Width = 308
    Height = 25
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 175
    Width = 81
    Height = 17
    Caption = #1040#1074#1090#1086#1079#1072#1087#1091#1089#1082
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 8
    Top = 157
    Width = 86
    Height = 17
    Caption = #1054#1087#1086#1074#1077#1097#1077#1085#1080#1077
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = CheckBox2Click
  end
  object ComboBox1: TComboBox
    Left = 6
    Top = 6
    Width = 304
    Height = 21
    Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1080#1083#1080' '#1074#1089#1090#1072#1074#1100#1090#1077' '#1089#1089#1099#1083#1082#1091
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1089#1089#1099#1083#1082#1091
    OnChange = ComboBox1Change
    OnExit = ComboBox1Exit
    OnSelect = ComboBox1Select
    Items.Strings = (
      'Original FTP'
      'Original FTP HD')
  end
  object CheckBox3: TCheckBox
    Left = 8
    Top = 138
    Width = 97
    Height = 17
    Hint = #1059#1073#1080#1088#1072#1077#1090' '#1080#1082#1086#1085#1082#1091' '#1080#1079' '#1090#1088#1077#1103' ('#1054#1090#1082#1088#1099#1090#1100' '#1086#1082#1085#1086' '#1084#1086#1078#1085#1086' Shift+F9)'
    Caption = #1048#1082#1086#1085#1082#1072' '#1074' '#1090#1088#1077#1077
    Checked = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 3
    OnClick = CheckBox3Click
    OnMouseUp = CheckBox3MouseUp
  end
  object Edit2: TEdit
    Left = 153
    Top = 171
    Width = 105
    Height = 21
    HelpType = htKeyword
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Text = 'Proxy IP'
    OnChange = Edit2Change
    OnEnter = Edit2Enter
    OnExit = Edit2Exit
  end
  object Edit1: TEdit
    Left = 260
    Top = 171
    Width = 42
    Height = 21
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Text = 'Port'
    OnChange = Edit1Change
    OnEnter = Edit1Enter
    OnExit = Edit1Exit
  end
  object Button2: TButton
    Left = 6
    Top = 48
    Width = 89
    Height = 22
    Caption = 'FTP'
    TabOrder = 7
    Visible = False
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 310
    Width = 137
    Height = 170
    ScrollBars = ssVertical
    TabOrder = 8
    Visible = False
  end
  object Edit3: TEdit
    Left = 0
    Top = 289
    Width = 312
    Height = 21
    TabOrder = 9
    Text = '/'#9
    Visible = False
    OnKeyPress = Edit3KeyPress
  end
  object CheckBox4: TCheckBox
    Left = 8
    Top = 120
    Width = 113
    Height = 17
    Caption = #1057#1089#1099#1083#1082#1080' '#1089' '#1089#1077#1088#1074#1077#1088#1072
    Checked = True
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 10
    OnClick = CheckBox4Click
  end
  object RadioButton1: TRadioButton
    Left = 155
    Top = 133
    Width = 113
    Height = 17
    Caption = #1040#1074#1090#1086#1086#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077
    Checked = True
    TabOrder = 11
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 155
    Top = 150
    Width = 147
    Height = 17
    Caption = #1059#1082#1072#1079#1072#1090#1100' '#1087#1088#1086#1082#1089#1080' '#1074#1088#1091#1095#1085#1091#1102
    TabOrder = 12
    OnClick = RadioButton2Click
  end
  object ComboBox2: TComboBox
    Left = 8
    Top = 228
    Width = 97
    Height = 21
    Style = csDropDownList
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ItemIndex = 2
    ParentFont = False
    TabOrder = 14
    Text = '30'
    OnChange = ComboBox2Change
    Items.Strings = (
      #1054#1090#1082#1083#1102#1095#1077#1085#1086
      '15'
      '30'
      '60'
      '120')
  end
  object Memo2: TMemo
    Left = 263
    Top = 310
    Width = 49
    Height = 170
    TabOrder = 15
  end
  object CheckBox5: TCheckBox
    Left = 8
    Top = 192
    Width = 105
    Height = 17
    Caption = #1055#1086' '#1094#1077#1085#1090#1088#1091
    Color = clBtnFace
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 16
    OnClick = CheckBox5Click
  end
  object CheckBox6: TCheckBox
    Left = 46
    Top = 272
    Width = 57
    Height = 15
    Caption = 'step'
    TabOrder = 17
  end
  object ListBox1: TListBox
    Left = 140
    Top = 310
    Width = 121
    Height = 170
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowFrame
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 18
    OnDblClick = ListBox1DblClick
  end
  object Button3: TButton
    Left = 184
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 19
    Visible = False
    OnClick = Button3Click
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 0
    AllowCookies = False
    HandleRedirects = True
    ProxyParams.BasicAuthentication = True
    ProxyParams.ProxyPort = 80
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    OnRedirect = IdHTTP1Redirect
    Left = 16
    Top = 65520
  end
  object Timer1: TTimer
    Interval = 1800000
    OnTimer = Timer1Timer
    Left = 42
    Top = 65520
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 88
    Top = 65520
    object sas1: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1086#1073#1086#1080
      OnClick = sas1Click
    end
    object N2: TMenuItem
      Caption = #1054#1087#1086#1074#1077#1097#1077#1085#1080#1077
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      OnClick = N3Click
    end
    object N1: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = N1Click
    end
  end
  object IdFTP1: TIdFTP
    MaxLineAction = maException
    ReadTimeout = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 112
    Top = 65520
  end
  object Timer2: TTimer
    Interval = 20000
    OnTimer = Timer2Timer
    Left = 65528
    Top = 65520
  end
  object CoolTrayIcon1: TCoolTrayIcon
    CycleInterval = 0
    Icon.Data = {
      0000010002002020100000000000E80200002600000010101000000000002801
      00000E0300002800000020000000400000000100040000000000800200000000
      0000000000000000000000000000000000000000800000800000008080008000
      0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
      0000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000
      00000000CCCCCCCC000000000000000000000CCCCCCCCCCAACC0000000000000
      000CCCCCCCCCCCAAACCCC0000000000000CCCCCCCCCCCCAAACCCCC0000000000
      0CCCCCCCCCCCCCAAAACCCCC000000000CCCCCCCCCCCCAAAAAAACCCCC0000000C
      CCCCCCCCCCCCAAAAAAACCCCCC000000CCCCCCCCCCCAAAAAAAAAAACCCC00000CC
      CCCCCCCCCCAAAAAAAAAAACCCCC0000CCCCCCCCCCCCAAAAAAAAAAACCCCC0000CC
      CCCCCCCCCCAAAAAAAAAACCCCCC000CCCCCCCCCCCCCAACAAACCCCCCCCCCC00CCC
      CCCCCCCCAAACCCCCCCCCCCCCCCC00CCCCCCCCCCCAAACCCCCCCCCCCCCCCA00CCC
      CCCCCCAACCCCCCCCCCCCCCCCCCA00CCCCCCCAAACCCCCCCCCCCCCCCCCCAA00CCC
      CCCAAAACCCCCCCACCCCCCCCCAAA00CCCCCCAAACCCCCCCAACCCCCCCCAAAA00CCC
      CCAAAAAACAACAACCCCCCCCCAAAA000CCCAAAAAAACAAAAACCCCCCCCCAAA0000CC
      CAAAAAAAAAAAAACCCCCCCCCCAA0000CCCAAAAAAAAAAAAACCCCCCCCCCCA00000C
      CAAAAAAAAAAAAAACCCCCCCACC000000CCAAAAAAAAAAAAAACCCCCCAAAA0000000
      AAAAAAAAAAAAAAACCCCCCAAA000000000AAAAAAAACACAAAACCCCAAA000000000
      00AAAAAACCCCAACACCCCAA0000000000000AAAAACCCCAACACCCCA00000000000
      00000AAAACCCCCAACCC000000000000000000000CCACCCCC0000000000000000
      0000000000000000000000000000FFF00FFFFF8001FFFE00007FFC00003FF800
      001FF000000FE0000007C0000003C00000038000000180000001800000010000
      0000000000000000000000000000000000000000000000000000000000008000
      00018000000180000001C0000003C0000003E0000007F000000FF800001FFC00
      003FFE00007FFF8001FFFFF00FFF280000001000000020000000010004000000
      0000C00000000000000000000000000000000000000000000000000080000080
      00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
      000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000000000000
      0CCCCAC00000000CCCCCCAACC00000CCCCCCAAACCC0000CCCCCAAAAACC000CCC
      CCCAAAAACCC00CCCCCAAACCCCCC00CCCCAACCCCCCCC00CCCAACCCACCCCA00CCA
      AAAAAACCCAA00CCAAAAAACCCCAA000CAAAAAAACCCA0000AAAAAAAACCAA00000A
      AAACACCCA00000000AACCAC000000000000000000000F81F0000E0070000C003
      0000800100008001000000000000000000000000000000000000000000000000
      00008001000080010000C0030000E0070000F81F0000}
    IconVisible = True
    IconIndex = 0
    PopupMenu = PopupMenu1
    OnClick = CoolTrayIcon1Click
    Left = 64
    Top = 65520
  end
end
