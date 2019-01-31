unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  IdBaseComponent, IdComponent, IdHTTP, System.Win.TaskbarCore, System.UITypes, Vcl.Taskbar,
  IdIOHandler, IdIOHandlerSocket, ShellApi, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdExplicitTLSClientServerBase, registry, IdFTP, IdTCPConnection, IdTCPClient,
  wininet, Vcl.ExtCtrls, Vcl.PlatformDefaultStyleActnCtrls, Vcl.Menus, DateUtils,
  Vcl.ActnPopup;

type
  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    IdFTP1: TIdFTP;
    ListBox1: TListBox;
    Edit1: TEdit;
    Button3: TButton;
    TrayIcon1: TTrayIcon;
    ComboBox2: TComboBox;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Edit2: TEdit;
    Edit3: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label3: TLabel;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdHTTP1: TIdHTTP;
    Button4: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Timer2: TTimer;
    PopupActionBar1: TPopupActionBar;
    N1: TMenuItem;
    N2: TMenuItem;
    ��������: TMenuItem;
    CheckBox4: TCheckBox;
    ListBox2: TListBox;
    CheckBox5: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure TrayIcon1Click(Sender: TObject);
    procedure TrayIcon1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Label2MouseEnter(Sender: TObject);
    procedure Label2MouseLeave(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure Label2ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure Label3ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Edit3Enter(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Label4MouseEnter(Sender: TObject);
    procedure Label5MouseEnter(Sender: TObject);
    procedure Label6MouseEnter(Sender: TObject);
    procedure Label4MouseLeave(Sender: TObject);
    procedure Label5MouseLeave(Sender: TObject);
    procedure Label6MouseLeave(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Label7MouseEnter(Sender: TObject);
    procedure Label7MouseLeave(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label8MouseEnter(Sender: TObject);
    procedure Label8MouseLeave(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure ComboBox1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure ��������Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Label8ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ComboBox1CloseUp(Sender: TObject);
    procedure Edit1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Label3DblClick(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button4Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  ver: string = '1.0';
  exe: String = 'http://github.com/ZongerX/Deskchanger/raw/master/Win32/Release/deskchanger.exe';
  rezexe: String = 'http://games-wars.ucoz.ru/deskchanger.upd';
  lastver: String = 'https://raw.githubusercontent.com/ZongerX/Deskchanger/master/lastver.txt';
  links: String = 'https://raw.githubusercontent.com/ZongerX/Deskchanger/master/servers.txt';
  libeay32: String = 'http://games-wars.ucoz.ru/libeay32.dll';
  ssleay32: String = 'http://games-wars.ucoz.ru/ssleay32.dll';

implementation

{$R *.dfm}


function CurrentDateTime(UTC: Boolean): TDateTime;
var
  SystemTime: TSystemTime;
begin
  if UTC = true then  GetSystemTime(SystemTime)
    else
      GetLocalTime(SystemTime);

  Result := SystemTimeToDateTime(SystemTime);
end;

function GetWin(Comand: string): string;
var
  buff: array [0 .. $FF] of char;
begin
  ExpandEnvironmentStrings(PChar(Comand), buff, SizeOf(buff));
  Result := buff;
end;

function DownSSL: string;
var
  http: Tidhttp;
  buf: TMemoryStream;
  error: string;
begin
  try
    buf:=TMemoryStream.Create;
    Http := TIdHTTP.Create(nil);
    try
      //���������� ���������� libeay32.dll
      HTTP.Get(libeay32,buf);
      buf.SaveToFile('libeay32.dll');
      buf.Clear;
    except
      on E : Exception do Error:=('������ �������� libeay32.dll: '+#13+E.Message);
    end;
    try
      //���������� ���������� ssleay32.dll
      HTTP.Get(ssleay32,buf);
      buf.SaveToFile('ssleay32.dll');
      buf.Clear;
    except
      on E : Exception do Error:=('������ �������� ssleay32.dll:'+#13+E.Message);
    end;
  Finally
    Application.Terminate;
    ShellExecute(Form1.Handle,'Open', Pchar(Application.Title+'.exe'), nil, nil, SW_SHOW);
  end;
  Result:=Error;
end;

function Log(Data: string):string;
begin
 Form1.Listbox2.Items.Text:=Form1.Listbox2.Items.Text+FormatDateTime('hh:mm:ss',now)+': '+Data+' ';
end;

procedure GetProxyData(var ProxyEnabled: boolean; var ProxyServer: string; var ProxyPort: integer);
var
  ProxyInfo: PInternetProxyInfo;
  Len: LongWord;
  i, j: integer;
begin
  Len := 4096;
  ProxyEnabled := false;
  GetMem(ProxyInfo, Len);
  try
    if InternetQueryOption(nil, INTERNET_OPTION_PROXY, ProxyInfo, Len)
    then
      if ProxyInfo^.dwAccessType = INTERNET_OPEN_TYPE_PROXY then
      begin
        ProxyEnabled:= True;
        ProxyServer := ProxyInfo^.lpszProxy;
      end
  finally
    FreeMem(ProxyInfo);
  end;

  if ProxyEnabled and (ProxyServer <> '') then
  begin
    i := Pos('http=', ProxyServer);
    if (i > 0) then
    begin
      Delete(ProxyServer, 1, i+5);
      j := Pos(';', ProxyServer);
      if (j > 0) then
        ProxyServer := Copy(ProxyServer, 1, j-1);
    end;
    i := Pos(':', ProxyServer);
    if (i > 0) then
    begin
      ProxyPort := StrToIntDef(Copy(ProxyServer, i+1, Length(ProxyServer)-i), 0);
      ProxyServer := Copy(ProxyServer, 1, i-1)
    end
  end;
end;

procedure CheckUpdate;
var
  last:string;
begin
  //�������� ����������
  try
    last:=Form1.idhttp1.Get(links);
    if ver<>last then Form1.Label7.Visible:=true;
  except
  end;
end;

procedure SetWallpaper(sWallpaperBMPPath: string);
var
  reg: TRegIniFile;
begin
  //     �������� ����� �������
  //     HKEY_CURRENT_USER
  //     Control Panel\Desktop
  //     TileWallpaper (REG_SZ)
  //     Wallpaper (REG_SZ)

  reg := TRegIniFile.Create('Control Panel\Desktop');
  reg.WriteString('', 'Wallpaper', sWallpaperBMPPath);
  reg.Free;
  //��������� ����� �� ������ � �������
  SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, nil, SPIF_SENDWININICHANGE);
end;

Function Himawari : string;
var
  today : TDateTime;
  Min,Hour,Day,Mon,Year:String;
begin
  //��������� ���� � ������� �� UTC = (true)
  Today:=CurrentDateTime(true);

  //���� � ����������
  DateTimeToString(Day,'dd',today);
  DateTimeToString(Mon,'mm',today);
  DateTimeToString(Year,'yyyy',today);

  //����� � ����������
  DateTimeToString(Hour,'hh',today);
  DateTimeToString(Min,'nn',today);

//  showmessage('�����������: '+Day+'\'+Hour+':'+Min);

  //������ �������������� 5 ����� ������ 10,20,30...60 �����
  if StrToInt(Min[2])<6 then
    begin
      //�������� 10 ����� �� �������
      Today:=IncMinute(today, -10);
      //���� � ����������
      DateTimeToString(Day,'dd',today);
      DateTimeToString(Mon,'mm',today);
      DateTimeToString(Year,'yyyy',today);

      //����� � ����������
      DateTimeToString(Hour,'hh',today);
      DateTimeToString(Min,'nn',today);
    end;

  //���������� ����� �� ��������
  Min:=IntToStr(StrToInt(Min) div 10)+'0';

//  showmessage('���������: '+Day+'\'+Hour+':'+Min);
  Result := 'http://www.jma.go.jp/en/gms/imgs_c/6/visible/1/'+Year+Mon+Day+Hour+Min+'-00.png';
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  buf: TMemoryStream;
begin
  buf:=TMemoryStream.Create;
  Log('��������: '+Combobox1.Text);
  if pos('�������� ��������', Combobox1.Text)=1 then
    begin
      showmessage('��� ������');
      exit;
    end;

  if (ComboBox1.Text='Electro-L') or (ComboBox1.Text='Electro-L HD') then
    begin
      Button2.Click;
      exit;
    end;

  if (ComboBox1.Text='Himawari') or (ComboBox1.Text='Himawari HD') then
    begin
      try
      Log('���������� c����� � Himawari: '+#13+Himawari);
      Button1.Enabled:=false;
      Button1.Caption:='�������� ������ Himawari...';
      Log('�������� ������ Himawari...');
      idHTTP1.Get(Himawari, buf); //�������� � �����
      buf.SaveToFile(GetWin('%AppData%')+'\himawari.bmp'); //����������
      Log('��������� ������ Himawari: '+#13+(GetWin('%AppData%')+'\himawari.bmp'));
      SetWallpaper(GetWin('%AppData%')+'\himawari.bmp');
      label3.Visible:=true;
      label3.Caption:=('��������� ����������: ')+FormatDateTime('hh:mm',now);

      Button1.Caption:='��������';
      Button1.Enabled:=true;
      except
        Log('������ ���������� � Himawari ');
        Button1.Caption:='��������';
        Button1.Enabled:=true;
      end;
      exit;
    end;

{
  if (ComboBox1.Text='Himawari') or (ComboBox1.Text='Himawari HD') then
    begin
      Button2.Click;
      exit;
    end;
}
  if pos('http://', Combobox1.Text) or pos('https://', Combobox1.Text)=0 then
    ComboBox1.Text:=('http://'+Combobox1.Text);

  Log('���������� c����� button1: '+#13+combobox1.Text);
  Button1.Enabled:=false;
  Button1.Caption:='�������� �����������...';
  //�������� � ���������� �����������
  idHTTP1.Get(Combobox1.Text, buf); //�������� � �����
  buf.SaveToFile(GetWin('%AppData%')+'\img.bmp'); //����������

  //��������� �����
  SetWallpaper(GetWin('%AppData%')+'\img.bmp');

  //����������� ���������� ����������
  label3.Visible:=true;
  label3.Caption:=('��������� ����������: ')+FormatDateTime('hh:mm',now);

  Button1.Caption:='��������';
  Button1.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Mon,MonStr,Year,Date:String;
  sort:TStringList;
begin
  Listbox2.Items.Text:=Listbox2.Items.Text+FormatDateTime('hh:mm:ss',now)+': ���������� c����� � FTP: '+combobox1.Text;
  Date:=(DateToStr(CurrentDateTime(false))); //����������� ���� � string � � ����������
  Mon:=Date[4]+Date[5];//����� 4 � 5 �����
  Year:=Date[7]+Date[8]+Date[9]+Date[10]; //��� 7,8,9,10 �����

  //����������� �������� FTP
  Form1.idftp1.Host:='217.174.103.107';
//  Form1.idftp1.Host:='ftp.ntsomz.ru';
  Form1.idftp1.Port:=21;
  Form1.idftp1.Username:='electro';
  Form1.idftp1.Password:='electro';

  Try
    begin
      //����������� � ftp
      listbox1.Items.Text:=listbox1.Items.Text+'����������� � FTP...';
      Log('����������� � FTP...');
      Form1.Button1.Enabled:=false;
      Form1.Button1.Caption:='����������� � FTP...';
//      Form1.idftp1.Disconnect;  //���������� (���� ����� ����������)
      Form1.idftp1.Connect;  //�����������
      AssErt(Form1.idftp1.Connected);     //�����������
      listbox1.Items.Text:=listbox1.Items.Text+'���������� '+idftp1.Host;
      Log('���������� '+idftp1.Host);
      listbox1.Items.Text:=listbox1.Items.Text+'����� ������ �����...';
      Log('����� ������ �����...');
      listbox1.Items.Clear;
      Form1.idFTP1.List(ListBox1.Items,'',false); //����� ������ �����

      //������� � ������ FTP
      listbox1.Items.Text:=listbox1.Items.Text+'������� � ������ FTP...';
      Log('������� � ������ FTP...');
      Button1.Caption:='������� � ������ FTP...';
      Edit1.Text:='/ELECTRO_L_2/';
      Form1.idftp1.ChangeDir(Form1.edit1.text);      //����� ���������� FTP

      //���
      Form1.idFTP1.List(ListBox1.Items,'',false); //����� ������ �����
      Edit1.Text:=edit1.Text+(ListBox1.Items[ListBox1.Items.Count-1]+'/');//������� �� ���������� ������ �� ������
      Button1.Caption:='����� ����������... '+edit1.Text;
      Log('����� ����������... '+edit1.Text);
      Form1.idftp1.ChangeDir(Form1.edit1.text);     //����� ���������� FTP
      Form1.idFTP1.List(ListBox1.Items,'',false);   //����� ������ �����
//      showmessage('��� ������� '+edit3.text);

      //�����
      Form1.idFTP1.List(ListBox1.Items,'',false);
      Button1.Caption:='����� ����������... '+edit1.Text;
      Log('����� ����������... '+edit1.Text);
      Form1.idftp1.ChangeDir(Form1.edit1.text);   //����� ���������� FTP
      Form1.idFTP1.List(ListBox1.Items,'',false); //����� ������ �����
      Form1.Button1.Caption:='��� ������...';

      Button1.Caption:='������������� ������� ������...';
//      showmessage('�������� ����� � �����');

      //������� ���� � �����
      sort := TStringList.Create;
      if pos('January', Form1.Listbox1.Items.Text)>0 then sort.Add('01');
      if pos('February', Form1.Listbox1.Items.Text)>0 then sort.Add('02');
      if pos('Mart', Form1.Listbox1.Items.Text)>0 then sort.Add('03');
      if pos('April', Form1.Listbox1.Items.Text)>0 then sort.Add('04');
      if pos('May', Form1.Listbox1.Items.Text)>0 then sort.Add('05');
      if pos('June', Form1.Listbox1.Items.Text)>0 then sort.Add('06');
      if pos('July', Form1.Listbox1.Items.Text)>0 then sort.Add('07');
      if pos('August', Form1.Listbox1.Items.Text)>0 then sort.Add('08');
      if pos('September', Form1.Listbox1.Items.Text)>0 then sort.Add('09');
      if pos('October', Form1.Listbox1.Items.Text)>0 then sort.Add('10');
      if pos('November', Form1.Listbox1.Items.Text)>0 then sort.Add('11');
      if pos('December', Form1.Listbox1.Items.Text)>0 then sort.Add('12');

      //������� �������� �������� ������ � ���������
      if Mon='01' then MonStr:='January';
      if Mon='02' then MonStr:='February';
      if Mon='03' then MonStr:='Mart';
      if Mon='04' then MonStr:='April';
      if Mon='05' then MonStr:='May';
      if Mon='06' then MonStr:='June';
      if Mon='07' then MonStr:='July';
      if Mon='08' then MonStr:='August';
      if Mon='09' then MonStr:='September';
      if Mon='10' then MonStr:='October';
      if Mon='11' then MonStr:='November';
      if Mon='12' then MonStr:='December';

      Edit1.Text:=(edit1.Text+MonStr+'/'); //��������� ��������� ����� �� ����������
      Form1.Button1.Caption:='����� ����������... '+edit1.Text;
      Log('����� ����������... '+edit1.Text);
      Form1.idftp1.ChangeDir(Form1.edit1.text);   //����� ���������� FTP
      Form1.idFTP1.List(ListBox1.Items,'',false); //����� ������ �����
      Form1.Button1.Caption:='����� ������...';
//      showmessage('����� ������ '+edit3.Text);

      //�����
      Form1.edit1.Text:=Form1.edit1.Text+(Form1.ListBox1.Items[Form1.ListBox1.Items.Count-1]+'/');//������� �� ���������� ������ �� ������
      Form1.idFTP1.List(ListBox1.Items,'',false); //����� ������ �����
      Form1.Button1.Caption:='����� ����������... '+edit1.Text;
      Log('����� ����������... '+edit1.Text);
      Form1.idftp1.ChangeDir(Form1.edit1.text);      //����� ���������� FTP
      Form1.idFTP1.List(ListBox1.Items,'',false); //����� ������ �����
      Form1.Button1.Caption:='����� �������...';
      Log('����� �������...');
//     showmessage('����� ������� '+edit3.Text);

      //������
      Form1.edit1.Text:=Form1.edit1.Text+(Form1.ListBox1.Items[Form1.ListBox1.Items.Count-1]+'/');//������� �� ���������� ������ �� ������
      Form1.idFTP1.List(ListBox1.Items,'',false); //����� ������ �����
      Form1.Button1.Caption:='����� ����������... '+edit1.Text;
      Log('����� ����������... '+edit1.Text);
      Form1.idftp1.ChangeDir(Form1.edit1.text);   //����� ���������� FTP
      Form1.idFTP1.List(ListBox1.Items,'',false); //����� ������ �����


      Form1.Button1.Caption:='������ ������';
      Log('������ ������');

      //���������� ������ �� ������ � edit1
      if ComboBox1.Text='Electro-L HD' then
        Edit1.Text:=Edit1.Text+Listbox1.Items[Listbox1.Items.Count-1]
          else if ComboBox1.Text='Electro-L' then
            Edit1.Text:=Edit1.Text+Listbox1.Items[Listbox1.Items.Count-2];

    Form1.Button1.Caption:='�������� ������...'+Listbox1.Items[Listbox1.Items.Count-1];
    Log('�������� ������... '+Listbox1.Items[Listbox1.Items.Count-1]);

    //�������� ������
    Form1.idftp1.Get(edit1.Text, GetWin('%AppData%')+'\img.bmp', true);

	  //����������
	  Form1.Button1.Caption:='��������� �����������...';
    Log('��������� �����������...');
    Form1.Update;

	  //���������� � �������� �����
    SetWallpaper(Pchar(GetWin('%AppData%')+'\img.bmp'));

    //���������� �� ����������
{    if Form1.checkbox2.Checked then Form1.CoolTrayIcon1.ShowBalloonHint('DeskChanger '+ver,IniFile.ReadString('LANG','DESKTOPUPATED','���� ��������� '+#13+edit1.Text), bitinfo, 10);
    label4.Visible:=true;
}

    //����������� ���������� ����������
    label3.Visible:=true;
    label3.Caption:=('��������� ����������: ')+FormatDateTime('hh:mm',now);
    end;
  Except
    on E : Exception do
      begin
        Log('�� ������� �������� ������: '+#13+E.Message);
        Form1.Button1.Enabled:=True;
        Form1.Button1.Caption:='��������';
        Form1.IdFTP1.Disconnect;
        exit;
      end;
//    Form1.label4.Caption:='��������� �������� ����������';
//    Form1.CoolTrayIcon1.ShowBalloonHint('Desktop Changer '+ver, '������ ���������� �������', biterror, 10);
  End;

  Log('��������� �������: '+combobox1.Text);
  Form1.idftp1.Disconnect;
  Form1.Button1.Caption:='��������';
  Form1.Button1.Enabled:=true;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Label7.Visible:=true;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Log(IntToStr(combobox1.Items.Count));
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  reg.RootKey := HKEY_CURRENT_USER;
  if checkbox1.Checked=true then
    begin
      reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
      reg.WriteString('DeskChanger', Application.ExeName+' /s');
    end
  else
    begin
      reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
      reg.DeleteValue('DeskChanger');
    end;
  reg.CloseKey;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
var
  reg: TRegistry;
begin
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;

  if checkbox3.Checked=true then
    begin
      checkbox3.Checked:=true;
      reg.OpenKey('Control Panel\Desktop', True);
      reg.WriteString('WallpaperStyle', '6');
    end
      else
        begin
          checkbox3.Checked:=false;
          reg.OpenKey('Control Panel\Desktop', True);
          reg.DeleteValue('WallpaperStyle');
        end;
  //��������� ����� �� ���� � �������
  SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, nil, SPIF_SENDWININICHANGE);

//  SetWallpaper((GetWin('%AppData%')+'\img.bmp'), False);
  reg.Free;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
var
  reg: TRegistry;
begin
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.CreateKey('DeskChanger');
  reg.OpenKey('DeskChanger', True);

  if checkbox4.Checked=true then
    begin
      checkbox3.Checked:=true;
      reg.WriteString('Close', '0');
    end
  else
    begin
      checkbox4.Checked:=false;
      reg.WriteString('Close', '1');
    end;
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
var
  login : string;
  pass : string;
begin
  if checkbox5.Checked then
    begin
      login := InputBox('Login proxy','Login','');
      pass := InputBox('Password proxy','Password','');
//      ShowMessage('Login: '+log+#10#13+ 'password: '+pass+ ' ');
      idhttp1.ProxyParams.ProxyUsername:=login;
      idhttp1.ProxyParams.ProxyPassword:=pass;
      idftp1.ProxySettings.UserName:=login;
      idftp1.ProxySettings.Password:=pass;
      idftp1.ProxySettings.ProxyType:=fpcmUserPass;
      Log('��������� �������������� ������:'+#13+'Login: '+login+'Pass: '+pass);
    end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  reg:TRegistry;
begin
  Log('��������� ������ ���������: '+Combobox1.Text);
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.CreateKey('DeskChanger');
  reg.OpenKey('DeskChanger', True);
  reg.WriteString('Link', ComboBox1.Text);
  reg.Free;
end;

procedure TForm1.ComboBox1CloseUp(Sender: TObject);
begin
  Form1.ActiveControl:=button1;
end;

procedure TForm1.ComboBox1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
//  showmessage('��������� ������');
  Button1.Enabled:=false;
  Button1.Caption:='���������� ������ �� ���������';

  //��������� ������ ������ �� �������
  combobox1.Items.Text:=idhttp1.Get(links);

  Button1.Caption:='��������';
  Button1.Enabled:=true;
  abort
end;

procedure TForm1.ComboBox1Select(Sender: TObject);
begin
  combobox1.OnChange(self);
  combobox1.Update;
  button1.Click;
  Form1.ActiveControl:=button1;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
var
  reg: TRegistry;
begin
  //��������� ������� ������� ����������
  if Combobox2.ItemIndex=0 then Timer1.Enabled:=false
    else Timer1.Enabled:=true;
  if Combobox2.ItemIndex=1 then Timer1.Interval:=600000;
  if Combobox2.ItemIndex=2 then Timer1.Interval:=1800000;
  if Combobox2.ItemIndex=3 then Timer1.Interval:=3600000;
  if Combobox2.ItemIndex=4 then Timer1.Interval:=7200000;

  //������ � ������
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.OpenKey('DeskChanger', True);
  reg.WriteString('UpdInterval', IntToStr(Timer1.interval));
end;

procedure TForm1.Edit1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  Form1.Width:=650;
  abort;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
  begin
    if Form1.IdFTP1.Connected=false then
      begin
        idftp1.Host:='217.174.103.107';
        idftp1.Port:=21;
        idftp1.Username:='electro';
        idftp1.Password:='electro';
        idftp1.Connect;
      end;
    if pos('.jpg',edit1.Text) or pos('.png',edit1.Text) <>0 then
      begin
        idftp1.Get(edit1.text, GetWin('%AppData%')+'\img.bmp', true);
        SetWallpaper((GetWin('%AppData%')+'\img.bmp'));
      end;

    Edit1.SelStart:=Length(Edit1.Text);
    idftp1.ChangeDir(edit1.text);
    idFTP1.List(ListBox1.Items,'',false);
  end;
end;

procedure TForm1.Edit2Enter(Sender: TObject);
begin
  if Edit2.Text = 'IP' then
    begin
      Edit2.Font.Color:=clblack;
      Edit2.Text := '';
    end;
end;

procedure TForm1.Edit2Exit(Sender: TObject);
var
  reg:TRegistry;
begin
  if Edit2.Text = '' then
    begin
      Edit2.Font.Color:=clgray;
      Edit2.Text := 'IP';
    end;

  //�������� ����� ������� HKEY_CURRENT_USER/DeskChanger
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.CreateKey('DeskChanger');
  reg.OpenKey('DeskChanger', True);

  //�������� ���� ����� �� �������
  if (edit2.Text='') or (edit2.Text='Proxy IP') then
    begin
      idhttp1.ProxyParams.ProxyServer:='';
      idftp1.ProxySettings.Host:='';
      reg.DeleteValue('Proxy_server');
    end
      else
        begin
          idhttp1.ProxyParams.ProxyServer:=(Edit2.Text);
          idftp1.ProxySettings.Host:=(Edit2.Text);
          reg.WriteString('Proxy_server', Edit2.Text);
        end;

  reg.Free;
end;

procedure TForm1.Edit3Enter(Sender: TObject);
begin
  if Edit3.Text = 'Port' then
    begin
      Edit3.Font.Color:=clblack;
      Edit3.Text := '';
    end;
end;

procedure TForm1.Edit3Exit(Sender: TObject);
var
  reg:TRegistry;
begin
  if Edit3.Text = '' then
    begin
      Edit3.Font.Color:=clgray;
      Edit3.Text := 'Port';
      exit;
    end;

  //�������� ����� ������� HKEY_CURRENT_USER/DeskChanger
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.CreateKey('DeskChanger');
  reg.OpenKey('DeskChanger', True);

  if (edit3.Text='') or (edit3.Text='Port') then
    begin
      idhttp1.ProxyParams.ProxyPort:=0;
      idftp1.ProxySettings.Port:=0;
      reg.DeleteValue('Proxy_port');
    end
      else
        begin
          idhttp1.ProxyParams.ProxyPort:=(StrToInt(Edit3.Text));
          idftp1.ProxySettings.Port:=(StrToInt(Edit3.Text));
          reg.WriteString('Proxy_port', Edit3.Text);
        end;

  reg.Free;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  temp:Word;
  reg: TRegistry;
begin
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  if reg.KeyExists('Deskchanger')=false then
    begin
      temp:=MessageBox(handle, PChar('�� ������ ������� ��� ��������?'+#13+'"��" ������� "���" ��������'), PChar('�������� ���������'), MB_YESNO+MB_ICONQUESTION);
      case temp of
        idYes:
          begin
            Application.Terminate;
            checkbox4.Checked:=false;
            //������ ��������� � ������
            reg:=TRegistry.Create;
            reg.RootKey:=HKEY_CURRENT_USER;
            reg.CreateKey('DeskChanger');
            reg.OpenKey('DeskChanger', True);
            reg.WriteString('Close', '1');
          end;
        idNo:
          begin
            form1.Visible:=false;
            checkbox4.Checked:=false;
            abort;
            //������ ��������� � ������
            reg:=TRegistry.Create;
            reg.RootKey:=HKEY_CURRENT_USER;
            reg.CreateKey('DeskChanger');
            reg.OpenKey('DeskChanger', True);
            reg.WriteString('Close', '0');
          end;
      end;
    end
      else
        begin
          if checkbox4.Checked=true then
            begin
              form1.Visible:=false;
              Label3.OnDblClick(self);
              abort;
            end
              else Application.Terminate;
        end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  reg:TRegistry;
  isProxyEnabled:boolean;
  ProxyServer,startparam:string;
  ProxyPort:integer;
begin
  form1.ClientHeight:=120;
  form1.Width:=350;

  //���������� ������� ��������� � ���������
  Form1.Caption:= Form1.Caption+' '+ver;

  //��������� �������
  startparam := ParamStr(1);
  if startparam = '/s' then Application.ShowMainForm:=false;
  if startparam = '/upd' then
    begin
      //�������� ����� ������ ������
      DeleteFile(Pchar(Application.Title+'.old'));
      Listbox2.Items.Text:=Listbox2.Items.Text+FormatDateTime('hh:mm:ss',now)+': ��������� ���������';
      Form1.Hide;
      if checkbox2.Enabled = true then
        begin
          trayicon1.BalloonHint:=('Desktop Changer '+ver+' ��������� ���������!');
          trayicon1.ShowBalloonHint;
        end;
    end;

  //�������� ������ SSL ���������
  if startparam = '/SSL' then
    begin
      DeleteFile(ExtractFilePath(Application.ExeName)+'libeay32.dll.old');
      DeleteFile(ExtractFilePath(Application.ExeName)+'ssleay32.dll.old');
    end;

  //��������� �������� �� �������
  reg:= TRegistry.Create(KEY_READ);
  reg.RootKey := HKEY_CURRENT_USER;
  reg.OpenKey('DeskChanger', False);

  //��������� ������
  if reg.ValueExists('Link') then ComboBox1.text:=(reg.ReadString('Link'));
  if reg.ReadString('Close')='1' then checkbox4.Checked:=false
    else checkbox4.Checked:=true;

  //��������� ��������� ����������
  if reg.ValueExists('Updinterval') then Timer1.interval:=StrToInt(reg.ReadString('UpdInterval'));
  if Timer1.Interval=600000 then Combobox2.ItemIndex:=1;
  if Timer1.Interval=1800000 then  Combobox2.ItemIndex:=2;
  if Timer1.Interval=3600000 then  Combobox2.ItemIndex:=3;
  if Timer1.Interval=7200000 then  Combobox2.ItemIndex:=4;

  //��������� �������� ������ �� �������
  if reg.ReadString('AutoProxy')='1' then
  begin
    GetProxyData(isProxyEnabled, ProxyServer, ProxyPort);
      if isProxyEnabled=true then
      begin
        idhttp1.ProxyParams.ProxyServer:=(ProxyServer);
        idhttp1.ProxyParams.ProxyPort:=(ProxyPort);
        idftp1.ProxySettings.Port:=StrToInt(Edit3.Text);
        idftp1.ProxySettings.Host:=Edit3.Text;
        Log('�������� ��������� ������ ������� :'+#13+'server: '+ProxyServer+' port: '+IntToStr(ProxyPort));
//        ShowMessage(ProxyServer+':'+IntToStr(ProxyPort));
      end;
  end;
  //��������� �������� ������ �� �������
  if reg.ReadString('AutoProxy')='0' then
    begin
      if reg.ValueExists('ProxyServer') then edit2.Text:=(reg.ReadString('ProxyServer'));
      if reg.ValueExists('ProxyPort') then edit3.Text:=(reg.ReadString('ProxyPort'));
    end;
  reg.CloseKey;

  //��������� ��������� "����������� �� ������"
  reg.OpenKey('Control Panel\Desktop', False);
  if  reg.ReadString('WallpaperStyle')='6' then
    begin
      checkbox3.Checked:=true;
    end;
  reg.CloseKey;

  //�������� ����������� � �������
  reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', False);
  if reg.ValueExists('DeskChanger') then Checkbox1.Checked:=true;
  reg.CloseKey;

end;

procedure TForm1.FormResize(Sender: TObject);
begin
Listbox1.Height:=Form1.Height-357;
end;

procedure TForm1.Label2Click(Sender: TObject);
  var i :integer;
begin
//������������ � �������������� ��������
if form1.ClientHeight<200 then Form1.ClientHeight:=form1.ClientHeight+120
  else
    begin
      i:=0;
      if form1.Height > 150 then
        begin
          while form1.Height > 150 do
            begin
              i:=i+1;
//              Form1.Caption:=inttostr(vers);
//              Form1.Caption:=Form1.Caption+'.';
              form1.Height:=form1.Height-4;
              form1.Update;
              sleep(1);
            end;
        end;
      while form1.Height > Listbox1.Top+190 do
        begin
          i:=i+1;
          Form1.Caption:=inttostr(i);
          Form1.Caption:=Form1.Caption+'.';
          form1.Height:=form1.Height+4;
          form1.Update;
          sleep(1);
        end;
    end;

//  trayicon1.ShowBalloonHint;
//  Trayicon1.BalloonHint:=('Desktop Changer '+ver, '��������� ���������!', bitInfo, 10);
end;

procedure TForm1.Label2ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  reg: TRegistry;
begin
  //�������� ��������
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.DeleteKey('DeskChanger');
  checkbox1.Checked:=false;
  checkbox2.Checked:=false;
  checkbox3.Checked:=false;
  checkbox4.Checked:=false;
//  Deletefile(Pchar(ExtractFileDir(Application.ExeName)+'\'+'Config.ini'));
  reg.Free;
  Application.MessageBox('��� ��������� ��������� �������!','Deskchanger',MB_OK);
end;

procedure TForm1.Label2MouseEnter(Sender: TObject);
begin
  Label2.Font.Color:=clwindowframe;
  Label2.Font.Style:=label2.Font.Style+[fsunderline];
end;

procedure TForm1.Label2MouseLeave(Sender: TObject);
begin
  Label2.Font.Color:=clgray;
  Label2.Font.Style:=Label2.Font.Style-[fsunderline];
end;

procedure TForm1.Label3ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  Form1.ClientHeight:=Listbox1.Top+250;
end;

procedure TForm1.Label3DblClick(Sender: TObject);
begin
  if form1.Width < 700 then
    begin
      Form1.BorderStyle:=TFormBorderStyle(2);
      button4.Visible:=true;
      Form1.ClientHeight:=Listbox1.Top+190;
      Form1.Width:=700;
    end
      else
        begin
          Form1.BorderStyle:=TFormBorderStyle(1);
          Button4.Visible:=false;
          form1.Width:= 350;
          Label2.OnClick(self);
        end;
end;

procedure TForm1.Label4Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://vk.com/deskchanger', nil, nil, SW_SHOW);
  Listbox2.Items.Text:=Listbox2.Items.Text+FormatDateTime('hh:mm:ss',now)+': ������� "���������"';
end;

procedure TForm1.Label4MouseEnter(Sender: TObject);
begin
  Label4.Font.Color:=clwindowframe;
  Label4.Font.Style:=label4.Font.Style+[fsunderline];
end;

procedure TForm1.Label4MouseLeave(Sender: TObject);
begin
  Label4.Font.Color:=clgray;
  Label4.Font.Style:=Label4.Font.Style-[fsunderline];
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
  Listbox2.Items.Text:=Listbox2.Items.Text+FormatDateTime('hh:mm:ss',now)+': ������� "����� ������"';
  ShellExecute(0, 'open', 'https://earth.nullschool.net/ru/#current/wind/surface/level/orthographic=77.8,35.797', nil, nil, SW_SHOW);
end;

procedure TForm1.Label5MouseEnter(Sender: TObject);
begin
  Label5.Font.Color:=clwindowframe;
  Label5.Font.Style:=label5.Font.Style+[fsunderline];
end;

procedure TForm1.Label5MouseLeave(Sender: TObject);
begin
  Label5.Font.Color:=clgray;
  Label5.Font.Style:=Label5.Font.Style-[fsunderline];
end;

procedure TForm1.Label6Click(Sender: TObject);
begin
  Log('������� "FTP �� ���"');
  //������ �� FTP "�� ���"
  ShellExecute(0, 'open', 'ftp://electro:electro@ftp.ntsomz.ru/', nil, nil, SW_SHOW);
end;

procedure TForm1.Label6MouseEnter(Sender: TObject);
begin
  Label6.Font.Color:=clwindowframe;
  Label6.Font.Style:=label6.Font.Style+[fsunderline];
end;

procedure TForm1.Label6MouseLeave(Sender: TObject);
begin
  Label6.Font.Color:=clgray;
  Label6.Font.Style:=Label6.Font.Style-[fsunderline];
end;

procedure TForm1.Label7Click(Sender: TObject);
var
  buf: TMemoryStream;
begin
  Log('������ ���������� ��������� '+ver+' �� '+lastver);
  //���������� ���������
  try
    buf:=TMemoryStream.Create;
    RenameFile(Application.ExeName, Application.Title+'.old');
    Form1.Button1.Enabled:=false;

    //������� ������� � ��������� �������, � ���� ������ � �������
    try
      Log('������� ���������� c '+exe);
      Form1.Button1.Caption:='���������� ���������...';
      idHTTP1.Get(exe,buf);
    except
      Log('������� ���������� c '+rezexe);
      buf.Clear;
      idHTTP1.Get(rezexe,buf);
    end;

    Log('��������� ���������, ����������...');
    buf.SaveToFile(Application.Title+'.exe');
    buf.Clear;
    Application.Terminate;
    ShellExecute(Form1.Handle,'Open', Pchar(Application.Title+'.exe'), '/upd', nil, SW_SHOW);
    DeleteFile(Pchar(Application.Title+'.exe'));
  except
    on E : Exception do Log('�� ������� �������� ���������: '+#13+E.Message);
  end;

  Form1.Button1.Enabled:=true;
  Form1.Button1.Caption:='��������';
end;

procedure TForm1.Label7MouseEnter(Sender: TObject);
begin
  Label7.Font.Color:=clMenuHighlight;
  Label7.Font.Style:=label7.Font.Style+[fsunderline];
end;

procedure TForm1.Label7MouseLeave(Sender: TObject);
begin
  Label7.Font.Color:=clHighlight;
  Label7.Font.Style:=label7.Font.Style-[fsunderline];
end;



procedure TForm1.Label8Click(Sender: TObject);
//var
//  http: Tidhttp;
//  buf: TMemoryStream;
//  error: integer;
begin
  //�������� SSL ��������� libeay32.dll, ssleay32.dll
  DownSSL;

// ���� ������
// #0 - ������ ���;
// #1 - ������ �������� libeay32.dll
// #2 - ������ �������� ssleay32.dll
// #3 - ������ �������� ����� ���������

//  Log(': ���������� ����������� � ����� ������: #'+IntToStr(error));
//  Listbox2.Items.Text:=Listbox2.Items.Text+'#0 - ������ ���';
//  Listbox2.Items.Text:=Listbox2.Items.Text+'#1 - ������ �������� libeay32.dll';
//  Listbox2.Items.Text:=Listbox2.Items.Text+'#2 - ������ �������� ssleay32.dll';
//  Listbox2.Items.Text:=Listbox2.Items.Text+'#3 - ������ �������� ����� ���������';

//  Form1.Button1.Enabled:=true;
//  Form1.Button1.Caption:='��������';
end;



procedure TForm1.Label8ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  try
    listbox1.Items.Text:=(listbox1.Items.Text+'Deleting SSL librares...');
    RenameFile(ExtractFilePath(Application.ExeName)+'ssleay32.dll', ExtractFilePath(Application.ExeName)+'ssleay32.dll.old');
    RenameFile(ExtractFilePath(Application.ExeName)+'libeay32.dll', ExtractFilePath(Application.ExeName)+'libeay32.dll.old');
    Application.Terminate;
    ShellExecute(Form1.Handle,'Open', Pchar(Application.Title+'.exe'), '/SSL', nil, SW_SHOW);
  except
    on E : Exception do Showmessage(E.Message);
  end;
end;



procedure TForm1.Label8MouseEnter(Sender: TObject);
begin
  Label8.Font.Color:=clwindowframe;
  Label8.Font.Style:=label8.Font.Style+[fsunderline];
end;

procedure TForm1.Label8MouseLeave(Sender: TObject);
begin
  Label8.Font.Color:=clgray;
  Label8.Font.Style:=Label8.Font.Style-[fsunderline];
end;

procedure TForm1.ListBox1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  idftp1.Disconnect;
  idftp1.Connect;
  idFTP1.ChangeDirUp();
  idftp1.List(ListBox1.Items,'',false); //����� ������ �����
  edit1.Text:='/';
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);

begin
  edit1.Text:=edit1.Text+'/'+Listbox1.Items[listbox1.ItemIndex]; //���������� � edit ���������� ������ �� listbox

  if pos('.jpg',edit1.Text)<>0  then
    else
      begin
        idftp1.ChangeDir(edit1.text);     //����� ���������� FTP
        idftp1.List(ListBox1.Items,'',false);   //����� ������ �����
      end;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  Form1.Visible:=true;
  Label2.OnClick(self);
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  if radiobutton1.Checked=true then
    begin
      edit2.Enabled:=false;
      edit3.Enabled:=false;
      checkbox5.Enabled:=false;
    end;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  if radiobutton2.Checked=true then
    begin
      edit2.Enabled:=true;
      edit3.Enabled:=true;
      checkbox5.Enabled:=true;
    end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  newver:string;
begin
  Log('��������� Timer1');
  //��������� ������ ������ �� �������
  try
    Log('��������� ������ ������ �� �������');
    combobox1.Items.Text:=(idhttp1.Get(links));
  except
    Log('������ ��������� ������ �� �������');
//    ��������� ������ ������
  end;

  Log('���������� button1');
  button1.Click;
{  //���� ���������� �� ���������� ��� ���� �� �������� ���������
  if label7.Visible = true then
    begin
      label7.OnClick(self);
    end;
}
  try
    Log('�������� ���������� ���������');
    //�������� ���������� ���������
    newver:=idhttp1.Get(lastver);
    if newver <> ver then
      begin
        label7.Visible := true;
        if checkbox2.Checked = true then
          begin
            Log('�������� ���������� ��������� '+newver);
            trayicon1.BalloonHint := '�������� ���������� ���������: Deskchanger '+newver;
            trayicon1.ShowBalloonHint;
          end;
      end;
  except
    Log('������ �������� ���������� ���������. ��������� ��������, ���� SSL ����������');
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
  newver: String;
begin
  Log('��������� Timer2');

  //��������� ������ ������ �� �������
  If combobox1.Items.Count<5 then
    begin
      Log('��������� ������ ������ �� �������'+#13+links);
      Combobox1.Items.Text:=(idhttp1.Get(links));
    end;

  //�������� �� ����������
  if Application.MainForm.Visible=true then
    begin
      //���� ������� �������� ���������� ��� �������
      Log('����� �������, �������� ������������ � ����...');
      timer2.Interval:=timer2.Interval+5000;
      exit;
    end
      else
        begin
          //����� �������� ������
//          if checkbox1.Checked then button1.Click;
        end;

  try
  //�������� ������� ��������� SSL: ssleay32 � libeay32
 if (FileExists('ssleay32.dll')) and (FileExists('libeay32.dll'))
    then Log('ssleay32.dll � libeay32.dll ������������')
      else
        begin
          Log('ssleay32 � libeay32 �����������');
          //��������� SSL ���������
          Log('�������� SSL ���������... ');
          DownSSL;
          abort;
        end;

//  if FileExists('ssleay32.dll') then Log('ssleay32.dll ������������');
//  if FileExists('libeay32.dll') then Log('libeay32.dll ������������')
  except
  end;

  try
  //�������� ���������� ���������
  Log('�������� ����� ������ ���������: '+#13+lastver);
  newver:=idhttp1.Get(lastver);
  Log('����� ������ ���������: '+newver);
  if newver <> ver then
    begin
      label7.Visible:=true;
      trayicon1.BalloonHint:='�������� ���������� ���������: Deskchanger '+newver;
      if Checkbox2.Checked then trayicon1.ShowBalloonHint;
    end;
  except
  end;

    button1.Click;

  timer2.Destroy;
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
  Form1.Show;
end;

procedure TForm1.TrayIcon1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if button = mbLeft then
    begin
    end;

  if button = mbRight then
    begin
    end;

  if button = mbMiddle then
    begin
    end;
end;

procedure TForm1.��������Click(Sender: TObject);
begin
  Button1.Click();
end;

end.
