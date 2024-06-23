unit Gobt_Register;

{$I GOBTLIB.INC}

{$R GobtRegister.DCR}


interface

uses Classes,DesignIntf,EXGDIPicture, EXGDIPictureDE, System.UITypes,
  Gobt_ImageAdvanced, Gobt_CategoryPanelGroup, Vcl.Forms;

procedure Register;


implementation

uses Gobt_ButtonHint
    , Gobt_ButtonAdvanced
    , Gobt_BlockProgressBar
    , Gobt_ProgressModern
    , Gobt_DirSelected
    , Gobt_TabEnterBlur
    , Gobt_DBToggleSwitch
    , Gobt_DBComboEdit
//    , gobt_DBNavigator
    , Gobt_Gradient
    , Gobt_CurrencyEdit
    , Gobt_DBCurrencyEdit
    , Gobt_DBCheckBoxStr
    , Gobt_WebLabel
    , Gobt_StatusBarPro
    , Gobt_StatusBarProDE
    , Gobt_Encryp
    , Gobt_BoxTitle
    ;



procedure Register;
begin

  {== Register Components ==}

  RegisterComponents( 'GOBT Library - Controls',
                    [ TGoMemoTransparent
                     ,TGoButtonHint
                     ,TGoButtonAdvanced
                     ,TGoBlockProgressBar
                     ,TGoProgressModern
                     ,TGoDirDialog
                     ,TGoTabEnterBlur
                     ,TGoComboEdit
                     ,TGoImageAdvanced
                     ,TGoGradient
                     ,TGoCurrencyEdit
                     ,TGoStatusBarPro
                     ,TGoEncryp
                     ,TGoBoxTitle
//                     ,TGoPageControl
                     ,TGoCategoryPanelGroup
                     ] );

  //Registrar Component Editor
  RegisterComponentEditor(TGoStatusBarPro, TStatusBarProEditor);


  RegisterComponents( 'GOBT Library - DBaware',
                    [ TGoDBButtonAdvanced
                     ,TGoDBToggleSwitch
                     ,TGoDBComboEdit
                     ,TGoDBCheckStr
                     ,TGoDBCurrencyEdit
//                     ,TGoDBNavigator
                     ] );





 // RegisterClass(TGobt_DBButtonAdvanced);


  //Registra DesingEditor
  RegisterPropertyEditor(TypeInfo(TGDIPPicture), TGoCustomButtonAdvanced, 'Picture', TGDIPPictureProperty);
  RegisterPropertyEditor(TypeInfo(TGDIPPicture), TGoCustomButtonAdvanced, 'DisabledPicture', TGDIPPictureProperty);
  RegisterPropertyEditor(TypeInfo(TGDIPPicture), TGoCustomButtonAdvanced, 'HotPicture', TGDIPPictureProperty);
  RegisterPropertyEditor(TypeInfo(TImageIndex) , TGoCustomButtonAdvanced, 'ImageIndex', TAdvImageIndexProperty);

  RegisterPropertyEditor(TypeInfo(TGDIPPicture), TGoHintInfo, 'Picture', TGDIPPictureProperty);
  RegisterPropertyEditor(TypeInfo(TGDIPPicture), TGoImageAdvanced, 'Picture', TGDIPPictureProperty);


end;

end.
